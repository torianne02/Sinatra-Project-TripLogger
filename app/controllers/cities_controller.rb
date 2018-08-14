class CitiesController < ApplicationController
  get '/cities' do
    redirect_if_not_logged_in
    
    @user = current_user
    session[:user_id] = @user.id
    @cities = City.all
    erb :'/cities/index'
  end

  get '/cities/:id' do
    redirect_if_not_logged_in

    @user = current_user
    @city = City.find_by_id(params[:id])
    erb :'/cities/show'
  end
end
