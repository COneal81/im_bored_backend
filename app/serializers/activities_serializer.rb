class ActivitiesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :category, :category_id
end
