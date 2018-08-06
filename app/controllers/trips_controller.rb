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
      @cities = City.all
      erb :'/trips/new'
    else
      redirect to '/users/login'
    end
  end

  post '/trips' do
    if params[:new_city_name].empty?
      @city = City.find_or_create_by(name: params[:city_name])
    else
      @city = City.find_or_create_by(name: params[:new_city_name])
    end

    @trip = Trip.new(length_of_visit: params[:length_of_visit])
    @user = current_user
    @trip.user_id = @user.id
    @trip.city_id = @city.id
    @trip.save

    flash[:message] = "You have successfully created the trip."
    redirect to "/trips/#{@trip.id}"

    if @trip.invalid?
      flash[:message] = "Oops! Make sure to fill out all criteria!"
      erb :'/users/show'
    end
  end

  get '/trips/:id' do
    if logged_in?
      @user = current_user
      @trip = Trip.find_by_id(params[:id])
      @city = City.find_by_id(@trip.city_id)
      erb :'/trips/show'
    else
      redirect to '/users/login'
    end
  end

  get '/trips/:id/edit' do
    if logged_in?
      @trip = Trip.find_by_id(params[:id])
      if @trip.user == current_user
        @cities = City.all
        erb :'/trips/edit'
      else
        redirect to "/trips/#{params[:id]}"
      end
    end
  end

  patch '/trips/:id' do
    if logged_in?
      @trip = Trip.find_by_id(params[:id])
      @city = City.find_by_id(@trip.city_id)

      if @trip.invalid?
        flash[:message] = "Oops! Make sure to fill out all criteria!"
        erb :'/trips/edit'
      else
        if @trip && @trip.user == current_user
          if params[:new_city_name].empty?
            @city.update(name: params[:city_name])
          else
            @city.update(name: params[:new_city_name])
          end

          @trip.update(length_of_visit: params[:length_of_visit], city_id: @city.id, user_id: current_user.id)
          flash[:message] = "Trip successfully updated."
          redirect to "/trips/#{params[:id]}"
        else
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
        flash[:message] = "Trip has been deleted."
        redirect to "/users/#{@trip.user_id}"
      else
        redirect to "/trips/#{params[:id]}"
      end
    else
      redirect to '/users/login'
    end
  end
end
