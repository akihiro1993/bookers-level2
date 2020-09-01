class BooksController < ApplicationController

before_action :authenticate_user!

  def top
  end

  def new
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice]="Book was successfully created."
       redirect_to book_path(@book.id) #複数系ではない
       else @books = Book.all
            @user = @book.user
            render :index#バリデーション完成
    end
  end

  def index
    @books = Book.all
    @book =Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new=Book.new
  end
  def edit
    @book = Book.find(params[:id])
    if @book.user_id.to_i != current_user.id
        flash[:notice] = "error"
        redirect_to books_path
      end
  end

  def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
  else
    render:edit
   end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end

 private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
