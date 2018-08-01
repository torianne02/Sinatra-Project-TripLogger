class TripsController < ApplicationController
  get '/trips' do
    if logged_in?
      @user = current_user
      session[:user_id] = @user.id
      @trips = Trip.all
      erb :'/trips/index'
    else
      redirect to '/users/login'
    end
  end

  get '/trips/new' do
    if logged_in?
      erb :'/trips/new'
    else
      redirect to '/users/login'
    end
  end

  post '/trips' do
    if params[:length_of_visit] == ""
      flash[:message] = "Oops! Please fill out all criteria before continuing."
      redirect to '/trips/new'
    else
      @trip = Trip.create(length_of_visit: params[:length_of_visit])
      @user = current_user
      @trip.user_ids = @user.id
      # need city_ids
      @trip.save
      flash[:message] = "You have created a new trip."
      redirect to "/trips/#{@trip.id}"
    end
  end

  get '/trips/:id' do
    if logged_in?
      @user = current_user
      @trip = Trip.find_by_id(params[:id])
      erb :'/trips/show'
    else
      flash[:message] = "Sorry, you have to be logged in to see this content."
      redirect to '/users/login'
    end
  end

  get '/trips/:id/edit' do
    if logged_in?
      @trip = Trip.find_by_id(params[:id])
      if @trip.user == current_user
        erb :'/trips/edit'
      else
        redirect to "/trips/#{params[:id]}"
      end
    end
  end

  patch '/trips/:id' do
    if logged_in?
      if params[:length_of_visit] == ""
        redirect to "/trips/#{params[:id]}/edit"
      else
        @trip = Trip.find_by_id(params[:id])
        if @trip && @trip.user == current_user
          @trip.update(length_of_visit: params[:length_of_visit])
          flash[:message] = "Successfully updated trip."
          redirect to "/trips/#{params[:id]}"
        else
          flash[:message] = "You are not authorized to edit this trip."
          redirect to '/trips'
        end
      end
    else
      redirect to '/users/login'
    end
  end

  delete '/trips/:id/delete' do
    if logged_in?
      @trip = Trip.find_by_id(params[:id])
      if @trip && @trip.user == current_user
        @trip.delete
        flash[:message] = "You have successfully deleted the trip."
        redirect to '/trips'
      else
        flash[:message] = "You are not authorized to delete this trip."
        redirect to "/trips/#{params[:id]}"
      end
    else
      redirect to '/users/login'
    end
  end
end
