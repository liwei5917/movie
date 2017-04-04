class Film < ApplicationRecord
  validates :title, presence: true
end
