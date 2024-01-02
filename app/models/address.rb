class Address < ApplicationRecord
    belongs_to :user
    # belongs_to :listing

    validates :line1, presence: true


end
