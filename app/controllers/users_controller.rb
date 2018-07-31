class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect "/users/#{@user.id}" # unsure if I want to redirect here or /cities
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user.valid?
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    elsif @user.invalid? && User.find_by(username: @user.username)
      flash[:message] = "Sorry, that username is already taken."
      redirect '/signup'
    else
      flash[:message] = "Oops! Make sure to fill in all criteria."
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect "/users/#{@user.id}"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome back, #{@user.username}!"
      redirect "/users/#{@user.id}"
    else
      flash[:message] = "Invalid username or password. Please try again."
      redirect '/login'
    end
  end

  get '/users/:id' do
    @user = current_user
    erb :'users/show'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/welcome'
    end
  end
end
