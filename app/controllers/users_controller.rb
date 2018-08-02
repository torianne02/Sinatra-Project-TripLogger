class UsersController < ApplicationController
  get '/users/signup' do
    if logged_in?
      redirect "/users/#{@user.id}"
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
      flash[:notice] = "Sorry, that username is already taken."
      redirect 'users/signup'
    else
      flash[:notice] = "Oops! Make sure to fill in all criteria."
      erb :'users/signup'
    end
  end

  get '/users/login' do
    if logged_in?
      @user = current_user
      redirect "/users/#{@user.id}"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      flash[:error] = "Invalid username or password. Please try again."
      redirect '/users/login'
    end
  end

  get '/users/:id' do
    @user = User.find_by(params[:id])
    @cities = City.all
    erb :'users/show'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end
end
