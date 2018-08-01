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

  # get '/trips/new' do
  #   if logged_in?
  #     erb :'/trips/new'
  #   else
  #     redirect to '/users/login'
  #   end
  # end

  post '/trips' do
    if params[:new_city_name].empty?
      @city = City.find_or_create_by(name: params[:city_name])
    else
      @city = City.find_or_create_by(name: params[:new_city_name])
    end
    # we know we have a select and a text input for city
    # if params[:new_city_name].empty?
    #   city = City.find_or_create_by_name(params[:city_name])
    # else
    #   city = City.find_or_create_by_name(params[:new_city_name])
    # end
    # what could we do if city fails to be created?
    @trip = Trip.new(length_of_visit: params[:length_of_visit])
    @user = current_user
    @trip.user_id = @user.id
    @trip.city_id = @city.id
    @trip.save

    # binding.pry
    #   flash[:message] = "Oops! Please fill out all criteria before continuing."
    #   redirect to '/trips/new'

    # @trip = Trip.new # add incoming info from params and city
    flash[:message] = "You have created a new trip."
    redirect to "/trips/#{@trip.id}"
    if @trip.invalid?
      flash[:message] = "Oops! Please fill out all criteria before continuing."
      erb :'/users/show'
      # failure
    # else`
    #   @trip = Trip.create(length_of_visit: params[:length_of_visit])
    #   @user = current_user
    #   @trip.user_id = @user.id
    #   # need city_ids
    #   @trip.save
      # flash[:message] = "You have created a new trip."
      # redirect to "/trips/#{@trip.id}"
    end
  end

  get '/trips/:id' do
    if logged_in?
      @user = current_user
      @trip = Trip.find_by_id(params[:id])
      @city = City.find_by_id(@trip.city_id)
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
        redirect to "/trips/#{params[:id]}/edit"
      else
        if @trip && @trip.user == current_user
          if params[:new_city_name].empty?
            @city.update(name: params[:city_name])
          else
            @city.update(name: params[:new_city_name])
          end

          @trip.update(length_of_visit: params[:length_of_visit], city_id: @city.id, user_id: current_user.id)
          binding.pry
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
