class UsersController < ApplicationController 

    get '/signup' do
        if !session[:user_id]
        erb :'users/new'
        else
        redirect '/books'
        end
    end

    post '/signup' do 
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect '/signup'
        else
        @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
        session[:user_id] = @user.id
        erb :'/books/new'
        end
    end

    get '/login' do 
        @error_message = params[:error]
        if !session[:user_id]
          erb :'users/login'
        else
          erb :"books/show"
        end
      end
    
      post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          erb :'books/show'
        else
          redirect '/signup'
        end
      end

      get '/users/:id' do
        # if !logged_in?
        #   redirect '/books'
        # end
        @user = User.find_by(id: params[:id])
        if !@user.nil? && @user == current_user
          erb :'users/show'
        # else
        #   redirect '/books'
        end
      end
    
      get '/logout' do
        if session[:user_id] != nil
          session.destroy
          redirect '/login'
        else
          redirect '/'
        end
      end
end