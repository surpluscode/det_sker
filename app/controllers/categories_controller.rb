class CategoriesController < ApplicationController

  def index
    render json: Category.all
  end


  def new
    @category = Category.new
    render layout: nil
  end

  def show
  end

  def create
    @category = Category.new(whitelist_params)
    respond_to do |format|
      if @category.save
        format.html { render 'created.html.erb', layout: nil }
        format.json { render json: @category, status: :created }
      else
        format.html { render action: 'new' }
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

  private
  def whitelist_params
    params.require(:category).permit(:english, :danish)
  end
end