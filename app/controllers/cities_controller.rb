class CitiesController < ApplicationController
  get "/cities" do
    if logged_in?
      erb :"/cities/index"
    else
      redirect '/users/login'
    end
  end

  get "/cities/new" do
    if logged_in?
      erb :"/cities/new"
    else
      redirect '/users/login'
    end
  end

  post "/cities" do
    if params[:name].empty? || params[:length_of_visit].empty?
      redirect '/cities/new'
    else
      @city = City.create(name: params[:name], length_of_visit: params[:length_of_visit])
      @user = User.find(session[:user_id])
      @city.user_id = @user.id
      @city.save
    end
  end

  get "/cities/:id" do
    if logged_in?
      @city = City.find_by_id(params[:id])
      erb :'/cities/show'
    else
      redirect '/users/login'
    end
  end

  get "/cities/:id/edit" do
    if logged_in?
      @city = City.find_by_id(params[:id])
      if session[:user_id] == @city.user_id
        erb :'/cities/edit'
      else
        redirect '/cities'
      end
    else
      redirect '/users/login'
    end
  end

  patch "/cities/:id" do
    if logged_in?
      if params[:name].empty? || params[:length_of_visit].empty?
        redirect "/cities/#{params[:id]}/edit"
      else
        @city = City.find_by_id(params[:id])
        if session[:user_id] = @city.user_id
          if @city.update(name: params[:name], length_of_visit: params[:length_of_visit])
            redirect "/cities/#{@city.id}"
          else
            redirect "/cities/#{@city.id}/edit"
          end
        else
          redirect '/cities'
        end
      end
    else
      redirect 'users/login'
    end
  end

  delete "/cities/:id/delete" do
    @city = City.find_by_id(params[:id])
    if session[:user_id] != @tweet.user_id
      redirect '/cities'
    else
      @city.delete
      redirect '/cities'
    end
  end
end
