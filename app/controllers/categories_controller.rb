class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end


  def new
    @category = Category.new
  end

  def show
  end


  def create
    @category = Category.new(whitelist_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to root_path, notice: 'Category created successfully' }
        format.json { render_action 'show', status: :created, location: @category}
      else
        format.html { render_action 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end

  # This method is used in the typeahead to retrieve
  # an array of categories
  def data
    @categories = Category.all.map{|e| e.key}
    respond_to do |format|
      format.json { render json: @categories}
    end
  end

  private
  def whitelist_params
    params.require(:category).permit(:key, :description)
  end
end