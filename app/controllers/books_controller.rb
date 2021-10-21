class BooksController < ApplicationController
  before_action :authenticate_user!,except: [:top]
  before_action :ensure_current_user, {only: [:edit, :update, :destroy]}
  def ensure_current_user
    @book = Book.find(params[:id])
    redirect_to books_path if @book.user.id != current_user.id
  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "You have created book successfully."
    else
      @user = current_user
      @books = Book.page(params[:page])
      render :index
    end
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.page(params[:page])
  end


  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = "You have updated book successfully."
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
      params.require(:book).permit(:title, :body)
    end

end
