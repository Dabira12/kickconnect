class Refund < ApplicationRecord
    has_one_attached :supporting_photo_one
    has_one_attached :supporting_photo_two
    has_one_attached :supporting_photo_three
    has_one_attached :supporting_photo_four
    has_one_attached :supporting_photo_five
    has_one_attached :supporting_photo_six

    validates :supporting_photo_one, presence: true
    validates :supporting_photo_two, presence: true
    validates :supporting_photo_three, presence: true
    validates :supporting_photo_four, presence: true
    validates :supporting_photo_five, presence: true
    validates :supporting_photo_six, presence: true
end
