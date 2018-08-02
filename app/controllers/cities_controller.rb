class CitiesController < ApplicationController
  get '/cities' do
    if logged_in?
      @user = current_user
      session[:user_id] = @user.id
      @cities = City.all
      erb :'/cities/index'
    else
      redirect to '/users/login'
    end
  end

  get '/cities/:id' do
    if logged_in?
      @user = current_user
      @city = City.find_by_id(params[:id])
      erb :'/cities/show'
    else
      session[:message] = "Sorry, you have to be logged in to see this content."
      redirect to '/users/login'
    end
  end
end
