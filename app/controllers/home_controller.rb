class HomeController < ApplicationController
  def index
    @latest_journal = Journal.order(published_at: :desc).first
    @other_journals = Journal.order(published_at: :desc).offset(1).limit(6)
    @categories = Category.all
  end

  def about
  end

  def contact
  end
end
