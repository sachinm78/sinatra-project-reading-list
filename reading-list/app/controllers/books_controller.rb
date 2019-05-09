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

    get "/books/index" do
      redirect_if_not_logged_in
      @books = Books.all
      erb :'books/index'
    end
    
    get "/books/:id" do
      redirect_if_not_logged_in 
      @book = Book.find_by(params[:id]) 
      erb :'books/show'
    end
  
    post "/books/:id" do
      redirect_if_not_logged_in 
      @book = Book.find_by(params[:id]) 
      unless Book.valid_params?(params)
        redirect "/books/#{@book.id}/edit?error=invalid book"
      end
      @book.update(params.select{|i| i=="title" || i=="author" || i=="genre"})
      redirect "/books/#{@book.id}"
    end

    get "/books/:id/edit" do
      redirect_if_not_logged_in 
      @error_message = params[:error]
      @book = Book.find_by(params[:id]) 
      erb :'books/edit'
    end

    patch '/books/:id' do
      id = params[:id]
      new_params = {}
      old_book = Book.find_by(id) 
      new_params[:title] = params["title"]
      new_params[:author] = params["author"]
      new_params[:genre] = params["genre"]
      old_book.update(new_params)
  
      redirect "/books/#{old_book.id}"
    end
  
    delete '/books/:id/delete' do
      @book = Book.find_by(params[:id]) 
      @book.destroy
      erb :delete
    end
end