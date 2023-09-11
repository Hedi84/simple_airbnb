# frozen_string_literal: true

# email                    :   string, default: "", null: false
# encrypted_password       :   string, default: "", null: false
# reset_password_token     :   string
# reset_password_sent_at   :   datetime
# remember                 :   datetime
# admin                    :   boolean

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
