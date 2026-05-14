

class BookmarksController < ApplicationController
  require "open-uri"
  require "json"
  def new
    @list = List.find(params[:list_id])

    if params[:query].present?
      url = "http://openlibrary.org/search.json?q=#{URI.encode_www_form_component(params[:query])}&limit=10"

      response = URI.open(url).read
      data = JSON.parse(response)

      @results = data["docs"]
    else
      @results = []
    end
  end

  def create
    @list = List.find(params[:list_id])

    @book = Book.find_or_create_by(open_library_key: params[:open_library_key]) do |book|
      book.title = params[:title]
      book.author = params[:author]
      book.cover_url = params[:cover_url]
      book.description = "Added from Open Library"
    end


  @bookmark = Bookmark.new(
    list: @list,
    book: @book,
    comment: params[:comment],
    rating: params[:rating]
  )

  if @bookmark.save
    redirect_to list_path(@list)
  else
    flash.now[:alert] = @bookmark.errors.full_messages.join(", ")

    @results = [ {
      "title" => params[:title],
      "author_name" => [ params[:author] ],
      "key" => params[:open_library_key],
      "cover_url" => params[:cover_url]
    } ]
    render :new, status: :unprocessable_entity
  end
  end
end
