class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
    # @books = Book.all
    # @bookmark = Bookmark.new
    # @bookmark.list = @list
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to list_path(@list)
    else
      # @books = Book.all
      # @bookmark = Bookmark.new
      # @bookmark.list = @list
      render :new, status: :unprocessable_entity
    end
  end

  private
  def list_params
    params.require(:list).permit(:name)
  end
end
