class Listing < ApplicationRecord
    belongs_to :user
   

    has_one_attached :cover_photo do |attachable|
        attachable.variant :medium, resize_to_limit:[300,100]
        attachable.variant :large, resize_to_limit:[1200,1000]
    end

    has_one_attached :supporting_photo_one do |attachable|
        attachable.variant :medium, resize_to_limit:[300,300]
        attachable.variant :large, resize_to_limit:[1200,1000]
    end

    has_one_attached :supporting_photo_two do |attachable|
        attachable.variant :medium, resize_to_limit:[300,300]
        attachable.variant :large, resize_to_limit:[1200,1000]
    end

    has_one_attached :supporting_photo_three do |attachable|
        attachable.variant :medium, resize_to_limit:[300,300]
        attachable.variant :large, resize_to_limit:[1200,1000]
    end

    has_one_attached :supporting_photo_four do |attachable|
        attachable.variant :medium, resize_to_limit:[300,300]
        attachable.variant :large, resize_to_limit:[1200,1000]
    end

    has_one_attached :supporting_photo_five do |attachable|
        attachable.variant :medium, resize_to_limit:[300,300]
        attachable.variant :large, resize_to_limit:[1200,1000]
    end

    has_one_attached :supporting_photo_six do |attachable|
        attachable.variant :medium, resize_to_limit:[300,300]
        attachable.variant :large, resize_to_limit:[1200,1000]
    end

    validates :name, presence: true
    validates :brand, presence:true
    validates :colour, presence:true
    validates :condition, presence:true
    validates :price, presence:true
    validates :department, presence:true
    validates :category, presence:true
    # validates :cover_photo, presence:true
    # validates :supporting_photos, length:{minimum:3, message:"A minimum of 3 supporting photos is required"}

    # def validate_photos
    #     errors.add(:suppor "minimum of 3 supporting photos is required") if supporting_photos.size < 3
    # end

    enum department:{
        menswear:'menswear',
        womenswear:'womenswear'
    }

    enum condition:{
        never_worn: 'new/never worn',
        gently_used: 'gently used',
        used: 'used',
        very_worn: 'very worn'
    }

    enum category:{
        footwear:'footwear',
        top:'top',
        bottom:'bottom',
        outerwear:'outerwear'
    }

    private
    def ensure_login_has_a_value
      puts 'congrats'
    end


end
