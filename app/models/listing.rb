class Listing < ApplicationRecord
    belongs_to :user
    has_one :order, dependent: :destroy
    # has_one :address

    # def addresses_id=(val)
    #     puts add
    #   end


   

    has_one_attached :cover_photo do |attachable|
        # attachable.variant :medium, resize_to_limit:[300,100]
        # attachable.variant :large, resize_to_limit:[1200,1000]
    end

    has_one_attached :supporting_photo_one do |attachable|
       
        # attachable.variant :large, resize_to_limit:[1200,1000]
    end

    has_one_attached :supporting_photo_two do |attachable|
     
        # attachable.variant :large, resize_to_limit:[1200,1000]
    end

    has_one_attached :supporting_photo_three do |attachable|
        
        # attachable.variant :large, resize_to_limit:[1200,1000]
    end

    has_one_attached :supporting_photo_four do |attachable|
       
        # attachable.variant :large, resize_to_limit:[1200,1000]
    end

    has_one_attached :supporting_photo_five do |attachable|
       
        # attachable.variant :large, resize_to_limit:[1200,1000]
    end

    has_one_attached :supporting_photo_six do |attachable|
       
        # attachable.variant :large, resize_to_limit:[1200,1000]
    end

    validates :name, presence: true
    validates :brand, presence:true
    validates :colour, presence:true
    validates :condition, presence:true
    validates :price, presence:true
    validates :department, presence:true
    validates :category, presence:true
    validates :subcategory, presence:true
    validates :cover_photo, presence:true
    validates :size, presence: true

    # validate :validate_supporting_photos
    

    def validate_supporting_photos
        count = 0
        puts self.supporting_photo_one.attached?
        
        if self.supporting_photo_one.attached? != false
            count = count+ 1
        end

        if self.supporting_photo_two.attached? != false
            count = count+ 1
        end
        if self.supporting_photo_three.attached? != false
            count = count+ 1
        end
        if self.supporting_photo_four.attached? != false
            count = count+ 1
        end
        if self.supporting_photo_five.attached? != false
            count = count+ 1
        end
        if self.supporting_photo_six.attached? != false
            count = count+ 1
        end

        if count < 3
            puts'yesiii'
            errors.add(:base,"You need a minimum of 2 supporting photos")
        end
        
    end

    # enum department:{
    #     menswear:'menswear',
    #     womenswear:'womenswear'
    # }

    # enum condition:[
    #     :never_worn,
    #     :gently_used,
    #     :used,
    #     :very_worn,
    # ]

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

    # enum size:{


    #     usxxs: 'US XXS/EU 40',
    #     usxs: 'US XS/EU 42',
    #     uss:'US S/EU 44-46',
    #     usm:'US M/EU 48-50',
    #     usl:'US L/EU 52-54',
    #     usxl:'US XL/EU 56',
    #     usxxl:'US XXL/EU 58',


    #     us26:'US 26/EU 42',
    #     us27:'US 27',
    #     us28:'US 28/EU 44',
    #     us29:'US 29',
    #     us30: 'US 30/EU 46',
    #     us31: 'US 31',
    #     us32:'US 32/EU 48',
    #     us33: 'US 33',
    #     us34:'US 34/EU 50',
    #     us35:'US 35',
    #     us36:'US 36/ EU 52',
    #     us37:'US 37',
    #     us38:'US 38/EU 54',
    #     us39:'US 39',
    #     us40:'US 40/EU 56',
    #     us41: 'US 41',
    #     us42:'US 42/EU58',
    #     us43:'US 43',
    #     us44:'US 44/EU 60',

    #     us5:'US 5/ EU 37' ,
    #     us5_5:'US 5.5 / EU 38',
    #     us6:'US 6/ EU 39',
    #     us6_5:'US 6.5/EU 39-40',
    #     us7:'US 7/EU 40',
    #     us7_5:'US 7.5/EU 40-41',
    #     us8:'US 8/ EU41',
    #     us8_5:'US 8.5/EU 41-42',
    #     us9:'US 9/EU 42',
    #     us9_5:'US 9.5/EU 42-43',
    #     us10:'US 10/EU 42',
    #     us10_5:'US 10.5/EU 42-43',
    #     us11:'US 11/EU 43',
    #     us12:'US 12/EU 44',
    #     us12_5:'US 12.5/EU 44-45',
    #     us13:'US 13/EU 45',
    #     us14:'US 14/EU 46',
    #     us15:'US 15'


    # }
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
