class UsersController < ApplicationController 

    get '/signup' do
        puts "test"
        # if !session[:user_id]
        # erb :'users/new'
        # else
        # redirect to '/signup'
        # end
    end

    # post '/signup' do 
    #     if params[:username] == "" || params[:email] == "" || params[:password] == ""
    #     redirect to '/signup'
    #     else
    #     @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    #     session[:user_id] = @user.id
    #     redirect '/books'
    #     end
    # end
end