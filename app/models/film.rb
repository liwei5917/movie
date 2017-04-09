class Film < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :reviews
end
