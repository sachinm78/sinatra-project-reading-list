class BooksController < ApplicationController 
    
    get "/books/index" do
      @books = Book.all
      erb :'books/index'
    end

    get "/books/show" do
      user = current_user
      @books = current_user.books
      erb :'books/show'
    end
  
    get "/books" do
      @books = Book.all
      erb :'books/index'
    end
  
    post "/books" do
        @book = Book.new(params)
        @book.user_id = current_user.id
        @book.save
        redirect '/books/show'
    end

    get "/books/new" do
      erb :'books/new'
    end

    get "/books/:id" do
      @book = Book.find_by(id: params[:id]) 
      erb :'books/show'
    end

    patch '/books/:id' do
      old_book = Book.find_by(id: params[:id]) 
      old_book[:title] = params[:title]
      old_book[:author] = params[:author]
      old_book[:genre] = params[:genre]
      old_book.save
      redirect "/books/show"
    end

    post '/books/:id' do
      old_book = Book.find_by(id: params[:id]) 
      old_book[:title] = params[:title]
      old_book[:author] = params[:author]
      old_book[:genre] = params[:genre]
      old_book.save
      redirect "/books/show"
    end

    get "/books/:id/edit" do
      @book = Book.find_by(id: params[:id])
      erb :'books/edit'
    end
 
    delete '/books/:id/delete' do
      @book = Book.find_by(id: params[:id])
      @book.destroy
      erb :'books/show'
    end
    
  end