class Api::V1::ActivitiesController < ApplicationController

    def index 
        # activities = Activity.all
        activities = Activity.order('created_at DESC')
        render json: ActivitiesSerializer.new(activities)
        #create a new instance of activities when it renders
    end

    def create
        activity = Activity.find_or_create_by(activities_params)
        if activity.valid?
            activity.save
            render json: ActivitiesSerializer.new(activity), status: :accepted
        else
            render json: {errors: activity.errors.full_messages}, status: :unprocessible_entity
        end
    end


    def update
        activity = Activity.find(params[:id])
        activity.update(activities_params)
        render json: ActivitiesSerializer.new(activity), status: :accepted
    end

    
    private

    def activities_params
        params.require(:activity).permit(:title, :description, :category_id)
    end
end



