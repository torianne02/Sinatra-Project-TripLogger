class CitiesController < ApplicationController
  get '/cities' do
    if logged_in?
      erb :"/cities/index"
    else
      redirect to '/users/login'
    end
  end

  get '/cities/new' do
    if logged_in?
      erb :"/cities/new"
    else
      redirect to '/users/login'
    end
  end

  post '/cities' do
    if params[:name].empty? || params[:length_of_visit].empty?
      redirect '/cities/new'
    else
      @city = City.create(name: params[:name], length_of_visit: params[:length_of_visit])
      @user = User.find(session[:user_id])
      @city.user_id = @user.id
      @city.save
      redirect to "/cities/#{@city.id}"
    end
  end

  get '/cities/:id' do
    if logged_in?
      @city = City.find_by_id(params[:id])
      erb :'/cities/show'
    else
      redirect to '/users/login'
    end
  end

  get '/cities/:id/edit' do
    if logged_in?
      @city = City.find_by_id(params[:id])
      if session[:user_id] == @city.user_id
        erb :'/cities/edit'
      else
        redirect to '/cities'
      end
    else
      redirect to '/users/login'
    end
  end

  patch '/cities/:id' do
    if logged_in?
      if params[:name].empty? || params[:length_of_visit].empty?
        redirect to "/cities/#{params[:id]}/edit"
      else
        @city = City.find_by_id(params[:id])
        if session[:user_id] = @city.user_id
          @city.update(name: params[:name], length_of_visit: params[:length_of_visit])
          @city.save
        else
          redirect to '/cities'
        end
      end
    else
      redirect to 'users/login'
    end
  end

  delete '/cities/:id/delete' do
    @city = City.find_by_id(params[:id])
    if session[:user_id] != @tweet.user_id
      redirect to '/cities'
    else
      @city.delete
      redirect to '/cities'
    end
  end
end
