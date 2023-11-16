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
    validates :subcategory, presence:true
    validates :size, presence: true
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

    # enum category:{
    #     tops:'Tops'
    # }

    # enum :category, [
    #     :footwear,
    #     :tops,
    #     :bottoms,
    #     :outerwear,
    #     :dresses,
    #     :accessories,
    # ]

   

    # enum subcategory:[

    #     :tshirts,
    #     :hoodies,
    #     :sweatshirts,
    #     :sweaters,
    #     :cardigans,
    #     :jerseys,
    #     :tanks,
    #     :shirts,
    #     :polos,
    #     :jeans,
    #     :sweatpants,
    #     :coats,
    #     :jackets,
    #     :vests,
    #     :shorts,
    #     :skirts,
    #     :blazers,
    #     :maxidresses,
    #     :minidresses,
    #     :mididresses,
    #     :gowns,
    #     :sunglasses,
    #     :jewelry


    # ]

    # enum :size,[


    #     :usxxs,
    #     :usxs,
    #     :uss,
    #     :usm,
    #     :usl,
    #     :usxl,
    #     :usxxl,
    #     :us26,
    #     :us27,
    #     :us28,
    #     :us29,
    #     :us30,
    #     :us31,
    #     :us32,
    #     :us33,
    #     :us34,
    #     :us35,
    #     :us36,
    #     :us37,
    #     :us38,
    #     :us39,
    #     :us40,
    #     :us41,
    #     :us42,
    #     :us43,
    #     :us44,

    #     :us5,
    #     :us5_5,
    #     :us6,
    #     :us6_5,
    #     :us7,
    #     :us7_5,
    #     :us8,
    #     :us8_5,
    #     :us9,
    #     :us9_5,
    #     :us10,
    #     :us10_5,
    #     :us11,
    #     :us12,
    #     :us12_5,
    #     :us13,
    #     :us14,
    #     :us15


    # ]
    # def categories
    #     if department == nil
    #         return  []
    #     end
    #     if department == "womenswear"
    #         return [['Top','top'],['Bottom','bottom'],['Footwear','footwear'],['Outerwear','outerwear']] || []
    #     end

    # end

    private
    def ensure_login_has_a_value
      puts 'congrats'
    end


end
