class UsersController < ApplicationController
  get '/users/signup' do
    if !session[:user_id]
      erb :'/users/signup'
    else
      redirect '/cities'
    end
  end

  post '/signup' do
    if params.values.include?("")
      redirect '/users/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/cities'
    end
  end

  get '/users/login' do
    if logged_in?
      redirect '/cities'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user != nil
      session[:user_id] = @user.id
      redirect '/cities'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/users/login'
    else
      redirect '/welcome'
    end
  end
end
