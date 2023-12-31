class BooksController < ApplicationController
  before_action :authenticate_user!,
    only: [:index, :show, :new, :create, :edit]

  def index
    @books = Book.order(created_at: :desc).page(params[:page]).per(30)
    @authors_count = Author.count
  end

  def index_json
    @books = Book.includes(:author)

    render json: @books, only: [:id, :title, :description, :year_published]
  end

  def show_json
    @book = Book.includes(:author).find(params[:id])

    render json: @book,
      only: [:id, :title, :description, :year_published],
      include: { author: { only: [:id, :name] } }
  end

  def new
    @book  = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "#{@book.title} created successfully"
      UserMailer
        .with(user: current_user, book: @book)
        .notify_book_added.deliver_later
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :description, :year_published, :author_id)
  end
end
