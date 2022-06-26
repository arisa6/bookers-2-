class BooksController < ApplicationController
     before_action :authenticate_user!
     before_action :correct_user, only: [:edit, :update]
     #(ログインユーザー以外の人が情報を遷移しようとした時に制限をかける)

	def create
        @user = current_user
		@book = Book.new(book_params)
        @book.user_id = (current_user.id)
	    if @book.save
        flash[:notice] = "You have creatad book successfully."
		redirect_to  book_path(@book.id)
        # redirect_to "/books/#{@book.id}"

        else
        @books = Book.all
        flash[:notice] = ' errors prohibited this obj from being saved:'
        render "index"
        end
	end

    def show
        @user = current_user
    	@book = Book.find(params[:id])
    	@book_new = Book.new
    end

    def index
        @users = User.all
        @books = Book.all
        @book = Book.new
        @user = current_user
    end

    def edit
    	@book = Book.find(params[:id])
    end


    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
        flash[:notice] = "You have updated book successfully."
        redirect_to  book_path

        else
        @books = Book.all
         flash[:notice]= ' errors prohibited this obj from being saved:'
        render "edit"
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to "/books"
     end

	private

    def book_params
        params.require(:book).permit(:title, :body)
    end

     def user_params
        params.require(:user).permit(:name,:profile_image,:introduction)
   end

    def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end