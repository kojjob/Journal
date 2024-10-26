class JournalsController < ApplicationController
  before_action :set_journal, only: [ :show, :edit, :update, :destroy ]

  def index
    @journals = Journal.order(created_at: :desc)
  end

  def show
    @journal = Journal.find(params[:id])
    @related_journals = Journal.where(category: @journal.category)
                               .where.not(id: @journal.id)
                               .order(published_at: :desc)
                               .limit(5)
  end

  def new
    @journal = Journal.new
  end

  def edit
  end

  def create
    @journal = Journal.new(journal_params)

    if @journal.save
      redirect_to @journal, notice: "Journal was successfully created."
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @journal.update(journal_params)
        process_attachments
        format.html { redirect_to @journal, notice: "Journal was successfully updated." }
        format.json { render :show, status: :ok, location: @journal }
      else
        Rails.logger.error "Journal update failed. Errors: #{@journal.errors.full_messages}"
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @journal.destroy
    redirect_to journals_url, notice: "Journal was successfully destroyed."
  end

  private

  def set_journal
    @journal = Journal.find(params[:id])
  end

  def journal_params
    params.require(:journal).permit(:title, :content, :author, :published_at, images: [], videos: [])
  end

  def process_attachments
    if params[:journal][:images].present?
      @journal.images.attach(params[:journal][:images])
      @journal.images.each { |image| MediaProcessorJob.perform_later(image) }
    end

    if params[:journal][:videos].present?
      @journal.videos.attach(params[:journal][:videos])
      @journal.videos.each { |video| MediaProcessorJob.perform_later(video) }
    end
  end
end
