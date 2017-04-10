class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :films
  has_many :reviews
  has_many :film_relationships
  has_many :participated_films, :through => :film_relationships, :source => :film

  def is_member_of?(film)
    participated_films.include?(film)
  end
end
