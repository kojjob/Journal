class CategoriesController < ApplicationController
  include Pagy::Backend
  def show
    @category = Category.find(params[:id])
    @pagy, @journals = pagy(@category.journals.order(published_at: :desc))
  end
end
