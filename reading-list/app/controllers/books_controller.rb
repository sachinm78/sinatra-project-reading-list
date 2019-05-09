class BooksController < ApplicationController 
    
    get "/books/index" do
      # redirect_if_not_logged_in
      @books = Book.all
      erb :'books/index'
    end

    get "/books/show" do
      # redirect_if_not_logged_in
      user = current_user
      @books = current_user.books
      erb :'books/show'
    end
  
    get "/books" do
      # redirect_if_not_logged_in 
      @books = Book.all
      erb :'books/index'
    end
  
    post "/books" do
        # redirect_if_not_logged_in 
        unless Book.valid_params?(params)
          redirect "/books/new?error=invalid book"
        end
        @book = Book.new(params)
        @book.user_id = current_user.id
        @book.save
        redirect '/books/show'
    end

    get "/books/new" do
      # redirect_if_not_logged_in 
      @error_message = params[:error]
      erb :'books/new'
    end

    get "/books/:id" do
      # redirect_if_not_logged_in
      @book = Book.find_by(id: params[:id]) 
      erb :'books/show'
    end

    patch '/books/:id' do
      old_book = Book.find_by(id: params[:id]) 
      old_book.update(params[:old_book])
  
      redirect:"/books/show"
    end

    get "/books/:id/edit" do
      # redirect_if_not_logged_in 
      @error_message = params[:error]
      @book = Book.find_by(id: params[:id])
      erb :'books/edit'
    end
 
  
    delete '/books/:id/delete' do
      @book = Book.find_by(id: params[:id])
      @book.destroy
      erb :delete
    end
end