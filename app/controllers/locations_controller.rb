class LocationsController < ApplicationController
    
    before_action :authenticate_user!

    def index
        @locations = Location.all 
    end

    def show
        @location = Location.find(params[:id])
    end

    def new
        @location = Location.new
    end


    def create
        @location = Location.new(location_params)

            if @location.save
                redirect_to locations_url              
            else
                render:new
            end
    end

    def edit
        @location = Location.find(params[:id])
    end

    def update
        @location = Location.find(params[:id])
            post_params = location_params

            if @location.update(post_params)
                redirect_to locations_path                
            else
                render :edit                
            end
    end

    def destroy
        @location = Location.find(params[:id])
        @location.destroy
        puts "location destroyed"
        redirect_to locations_path
    end



private

    def location_params
        params.require(:location).permit(:place, :address, :description)
    end

end