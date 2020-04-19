class Inquiry < ApplicationRecord

    validates :firstname, :lastname, :email, :message, presence: true
end
