class BooksController < ApplicationController 
    
    get "/books" do
      redirect_if_not_logged_in 
      @books = Book.all
      erb :'books/index'
    end
  
    post "/books" do
        redirect_if_not_logged_in 
        unless Book.valid_params?(params)
          redirect "/books/new?error=invalid book"
        end
        Book.create(params)
        redirect "/books"
    end

    get "/books/new" do
      redirect_if_not_logged_in 
      @error_message = params[:error]
      erb :'books/new'
    end

end