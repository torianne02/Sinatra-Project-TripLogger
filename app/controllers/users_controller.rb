class UsersController < ApplicationController
  get '/users/signup' do
    if !session[:user_id]
      erb :'/users/signup'
    else
      redirect '/users/:id' # unsure if I want to redirect here or /cities
    end
  end

  post '/signup' do
    if params.values.include?("")
      flash[:message] = "Oops! Make sure to fill in all criteria."
      redirect '/users/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/users/:id'
    end
  end

  get '/users/login' do
    if logged_in?
      redirect '/users/:id'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user != nil
      session[:user_id] = @user.id
      redirect '/users/:id'
    end
  end

  get '/users/:id' do
    @user = current_user
    erb :'users/show'
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
