class UsersController < ApplicationController
  get '/users/signup' do
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
      redirect 'users/signup'
    else
      flash[:message] = "Oops! Make sure to fill in all criteria."
      redirect 'users/signup'
    end
  end

  get '/users/login' do
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
      redirect '/users/login'
    end
  end

  get '/users/:id' do
    @user = User.find_by(params[:id])
    @cities = @user.cities
    erb :'users/show'
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "You have been successfully logged out."
      redirect '/'
    else
      redirect '/'
    end
  end
end
