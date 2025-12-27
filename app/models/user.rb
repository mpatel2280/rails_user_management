class User < ApplicationRecord
    has_secure_password

    normalizes :email, with: -> e { e.strip.downcase}

    validates :name, presence: true 
    validates :email, presence: true, uniqueness: true 
end
