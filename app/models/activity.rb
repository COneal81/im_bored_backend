class Activity < ApplicationRecord
  belongs_to :category
  validates :title, :category, presence: true
end
