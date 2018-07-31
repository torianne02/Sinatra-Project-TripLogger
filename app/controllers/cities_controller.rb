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

  get '/cities/new' do
    if logged_in?
      erb :'/cities/new'
    else
      redirect to '/users/login'
    end
  end

  post '/cities' do
    if params[:name] == "" || params[:length_of_visit] == ""
      flash[:message] = "Oops! Please fill out all criteria before continuing."
      redirect to '/cities/new'
    else
      @city = City.create(name: params[:name], length_of_visit: params[:length_of_visit])
      @user = current_user
      @city.user_id = @user.id
      @city.save
      flash[:message] = "You have created a new trip."
      redirect to "/cities/#{@city.id}"
    end
  end

  get '/cities/:id' do
    if logged_in?
      @user = current_user
      @city = City.find_by_id(params[:id])
      erb :'/cities/show'
    else
      flash[:message] = "Sorry, you have to be logged in to see this content."
      redirect to '/users/login'
    end
  end

  get '/cities/:id/edit' do
    if logged_in?
      @city = City.find_by_id(params[:id])
      if @city.user == current_user
        erb :'/cities/edit'
      else
        redirect to "/cities/#{params[:id]}"
      end
    end
  end

  patch '/cities/:id' do
    if logged_in?
      if params[:name] == "" || params[:length_of_visit] == ""
        redirect to "/cities/#{params[:id]}/edit"
      else
        @city = City.find_by_id(params[:id])
        if @city && @city.user == current_user
          @city.update(name: params[:name], length_of_visit: params[:length_of_visit])
          flash[:message] = "Successfully updated trip."
          redirect to "/cities/#{params[:id]}"
        else
          flash[:message] = "You are not authorized to edit this trip."
          redirect to '/cities'
        end
      end
    else
      redirect to '/users/login'
    end
  end

  delete '/cities/:id/delete' do
    if logged_in?
      @city = City.find_by_id(params[:id])
      if @city && @city.user == current_user
        @city.delete
        flash[:message] = "You have successfully deleted the trip."
        redirect to '/cities'
      else
        flash[:message] = "You are not authorized to delete this trip."
        redirect to "/cities/#{params[:id]}"
      end
    else
      redirect to '/users/login'
    end
  end
end
