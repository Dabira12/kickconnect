class Address < ApplicationRecord
    belongs_to :user

    validates :line1, presence: true


end
