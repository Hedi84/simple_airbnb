# frozen_string_literal: true

# name             : string
# address          : string
# description      : string
# price_per_night  : integer
# number_of_guests : integer
# user_id          : foreign_key
# url              : string

class Flat < ApplicationRecord
  belongs_to :user
  validates :name, :description, :address, :price_per_night, :number_of_guests, presence: true

  def property_image
    if url.empty?
      'https://static.vecteezy.com/system/resources/previews/000/322/151/original/realistic-house-vector.jpg'
    else
      url
    end
  end
end
