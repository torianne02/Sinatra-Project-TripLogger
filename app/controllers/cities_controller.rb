class CitiesController < ApplicationController

  # GET: /cities
  get "/cities" do
    erb :"/cities/index.html"
  end

  # GET: /cities/new
  get "/cities/new" do
    erb :"/cities/new.html"
  end

  # POST: /cities
  post "/cities" do
    redirect "/cities"
  end

  # GET: /cities/5
  get "/cities/:id" do
    erb :"/cities/show.html"
  end

  # GET: /cities/5/edit
  get "/cities/:id/edit" do
    erb :"/cities/edit.html"
  end

  # PATCH: /cities/5
  patch "/cities/:id" do
    redirect "/cities/:id"
  end

  # DELETE: /cities/5/delete
  delete "/cities/:id/delete" do
    redirect "/cities"
  end
end
