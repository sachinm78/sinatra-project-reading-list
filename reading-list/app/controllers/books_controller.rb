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
        @book = Book.create(params)
        @book.user_id = @current_user.id
        erb :"books"
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
  
    post "/books/:id" do
      # redirect_if_not_logged_in 
      @book = Book.find_by(id: params[:id])
      unless Book.valid_params?(params)
        redirect "/books/#{@book.id}/edit?error=invalid book"
      end
      @book.update(params.select{|i| i=="title" || i=="author" || i=="genre"})
      erb :"books/#{@book.id}"
    end

    get "/books/:id/edit" do
      # redirect_if_not_logged_in 
      @error_message = params[:error]
      @book = Book.find_by(id: params[:id])
      erb :'books/edit'
    end

    patch '/books/:id' do
      id = params[:id]
      new_params = {}
      old_book = Book.find(id) 
      new_params[:title] = params["title"]
      new_params[:author] = params["author"]
      new_params[:genre] = params["genre"]
      old_book.update(new_params)
  
      erb :"books/#{old_book.id}"
    end
  
    delete '/books/:id/delete' do
      @book = Book.find_by(id: params[:id])
      @book.destroy
      erb :delete
    end
end