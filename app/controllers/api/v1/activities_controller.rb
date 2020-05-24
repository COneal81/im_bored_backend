class Api::V1::ActivitiesController < ApplicationController
    def index 
        activities = Activity.all 
        render json: activities
    end

    def create
        activity = Activity.new(activities_params)
        if activity.save
            render json: activity, status: :accepted
        else
            render json: {errors: activity.errors.full_messages}, status: :unprocessible_entity
        end
    end

    private

    def activities_params
        params.require(:activity).permit(:title, :description, :category_id)
    end
end
