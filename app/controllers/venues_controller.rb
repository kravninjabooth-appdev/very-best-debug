class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list.html.erb" })
  end

  def show
    venue_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => venue_id })
    @venue = matching_venues.first

    render({ :template => "venue_templates/details.html.erb" })
  end

  def create
    @venue = Venue.new
    @venue.address = params.fetch("query_address")
    @venue.name = params.fetch("query_name")
    @venue.neighborhood = params.fetch("query_neighborhood")
    @venue.save

    redirect_to("/venues/#{@venue.id}")
  end
  
  def update
    venue_id = params.fetch("the_id")
    #Parameters: {"query_address"=>"Suite 993 9368 Cassin Village, New Pearlyhaven, ID 66162", "query_name"=>"Belly Pizza", "query_neighborhood"=>"Royal Oaks Sq", "the_id"=>"24"}

    @venue = Venue.where({ :id => venue_id }).at(0)
    @venue.address = params.fetch("query_address")
    @venue.name = params.fetch("query_name")
    @venue.neighborhood = params.fetch("query_neighborhood")
    @venue.save
    
    redirect_to("/venues/#{@venue.id}")
  end

  def destroy
    the_id = params.fetch("id_to_delete")
    matching_venues = Venue.where({ :id => the_id }).at(0)
    venue = matching_venues
    venue.destroy

    redirect_to("/venues")
  end

end
