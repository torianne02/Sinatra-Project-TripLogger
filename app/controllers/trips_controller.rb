class TripsController < ApplicationController

  # GET: /trips
  get "/trips" do
    erb :"/trips/index.html"
  end

  # GET: /trips/new
  get "/trips/new" do
    erb :"/trips/new.html"
  end

  # POST: /trips
  post "/trips" do
    redirect "/trips"
  end

  # GET: /trips/5
  get "/trips/:id" do
    erb :"/trips/show.html"
  end

  # GET: /trips/5/edit
  get "/trips/:id/edit" do
    erb :"/trips/edit.html"
  end

  # PATCH: /trips/5
  patch "/trips/:id" do
    redirect "/trips/:id"
  end

  # DELETE: /trips/5/delete
  delete "/trips/:id/delete" do
    redirect "/trips"
  end
end
