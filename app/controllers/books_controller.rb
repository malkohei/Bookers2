class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :proper_user_books, only: [:edit, :update, :destroy]

  def new
    @newbook = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:succsess] = "You have created successfully!"
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @newbook = Book.new
      @user = current_user
      render :index
    end
  end

  def index
    @books = Book.all
    @newbook = Book.new
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
  end

  def edit
  end

  def update
    @book = Book.find_by(id:params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:success] = "You have updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def proper_user_books
      @book = Book.find(params[:id])
      user = @book.user
      if current_user != user
        redirect_to books_path
      end
  end

end
