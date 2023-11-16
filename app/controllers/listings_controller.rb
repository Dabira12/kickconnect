class ListingsController < ApplicationController
  include ListingHelper

  # before_action :can_edit_listing, only:[:edit]
  before_action :can_view_edit_listing, only:[:show, :edit]
  before_action :can_sell, only:[:sale]
  
  def index
  end

  def sale
    @listings = Listing.where(is_sold: false, user_id: current_user.id)
  end

  def storefront
      @user = User.find_by(username: params[:username])
      @username= params[:username]
      puts @user
  end

  def sold
  end

  def show
    @listing = Listing.find(params[:id])
  end 

  def show_all
    @listings = Listing.all
  end

  # GET /listings/new
  def new
    # @listing = Listing.new
    @listing = current_user.listings.build

    
  end

  

  def create
    # @listing = listing.new(listing_params)
    @listing = current_user.listings.build(listing_params)
   
    
    
    if @listing.save
      
      redirect_to sell_sale_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @listing = Listing.find(params[:id])
  end 

  def update
    @listing = Listing.find(params[:id])

    if @listing.update(listing_params)
      redirect_to sell_sale_path
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def subcategories
    @subcategories = getSubCategories(params[:category], params[:department])
    @target = params[:target]

   

  end

  def departments
    @target = params[:target]

  end 

  def categories
    @categories = getCategories(params[:department])
    @target = params[:target]
   

    
  end

  def sizes
    @sizes = getSizes(params[:category])
    @target = params[:target]


  end 

  def getCategories(department)
    if department == "menswear"
        return [['Select a category',nil],['Tops','tops'],['Bottoms','bottoms'],['Footwear','footwear'],['Outerwear','outerwear'],['Accessories','accessories']]

    elsif department == "womenswear"
      return [['Select a category',nil],['Tops','tops'],['Bottoms','bottoms'],['Footwear','footwear'],['Outerwear','outerwear'],['Accessories','accessories'],['Dresses','dresses']]
    end
    

end

def getSubCategories(category,department)
  if category == "tops"
    return [['Select a sub-category',nil],['Shirts','shirts'],['T-shirts','tshirts'],['Jerseys','jerseys'],['Sweatshirts','sweatshirts'],['Polos','polos'],['Tanks','tanks']]

  elsif category == "bottoms" && department == "menswear"
    return [['Select a sub-category',nil],['Jeans','jeans'],['Pants','pants'],['Sweatpants/Joggers', 'sweatpants'],['Shorts','shorts']]

  elsif category == "bottoms" && department == "womenswear"
    return [['Select a sub-category',nil],['Jeans','jeans'],['Pants','pants'],['Sweatpants/Joggers', 'sweatpants'],['Shorts','shorts'],['Skirts','skirts']]


  elsif category == "outerwear"
    return [['Select a sub-category',nil],['Coats','coats'],['Jackets','jackets']]

  elsif category== "footwear" &&  department == "menswear" 
    return [['Select a sub-category',nil],['Sneakers', 'sneakers'], ['Boots','boots'],['Loafers','loafers'], ['Sandals','sandals'],['Slippers','slippers'],['Oxfords','oxfords'],['Brogues','brogues'],['Boat shoes', 'boats'], ['Espadrilles','espadrilles']]

  elsif category == "footwear"  &&  department =="womenswear" 
    return [['Select a sub-category',nil],['Heels', 'heels'], ['Sneakers' ,'sneakers'], ['Flats', 'flats'], ['Sandals', 'sandals'],['Slippers','slippers'], ['Mules','mules'], ['Platforms','platform'],['Boots','boots']]

  elsif category == "accessories"
    return[['Select a sub-category',nil],['Belts','belts'],['Glasses','glasses'],['Hats','hats'],['Wallets/Cardholders','wallets'],['Jewelry','jewelry'],['Watches','watches'],['Scarves','scarves']]

  elsif category == "dresses" 
    return [['Select a sub-category',nil],['MiniDresses','minidresses'],['Maxidresses','maxidresses'],['Mididresses', 'mididresses'],['Gowns','gowns']]

  end
end

def getSizes(category)
  if category == "tops"
    return [['Select a size',nil],['US XXS/EU 40','usxxs'],['US XS/EU 42', 'usxs'],['US S/EU 44-46','uss'], ['US M/EU 48-50','usm'],['US L/EU 52-54','usl'],['US XL/EU 56','usxl'], ['US XXL/EU 58', 'usxxl']]

  elsif category == "bottoms"
    return [['Select a size', nil], ['US 26/EU 42','us26'], ['US 27','us27'],['US 28/EU 44', 'us28'],['US 29','us29'], ['US 30/EU 46','us30'],['US 31','us31'],['US 32/EU 48','us32'], ['US 33','us33'],['US 34/EU 50','us34'],['US 35','us35'],['US 36/ EU 52','us36'],['US 37','us37'], ['US 38/EU 54','us38',],['US 39', 'us39'],['US 40/EU 56','us40'],['US 41','us41'],['US 42/EU58','us42'],['US 43','us43'],['US 44/EU 60','us44']]

  elsif category =="accessories"
    return [['Select a size', nil], ['ONE SIZE','onesize']]

  elsif category =="outerwear"
    return [['Select a size',nil],['US XXS/EU 40','usxxs'],['US XS/EU 42', 'usxs'],['US S/EU 44-46','uss'], ['US M/EU 48-50','usm'],['US L/EU 52-54','usl'],['US XL/EU 56','usxl'], ['US XXL/EU 58', 'usxxl']]
    # return [['Select a sub-category',nil],['MiniDresses','minidresses'],['Maxidresses','maxidresses'],['Mididresses', 'mididresses'],['Gowns','gowns']]
  elsif category =="footwear"
    return [['Select a size',nil],['US 5/ EU 37','us5'], ['US 5.5 / EU 38','us5_5'] ,['US 6/ EU 39','us6'],['US 6.5/EU 39-40','us6_5'],['US 7/EU 40','us7'],['US 7.5/EU 40-41','us7_5'],['US 8/ EU41','us8'],['US 8.5/EU 41-42','us8_5'],['US 9/EU 42','us9'],['US 9.5/EU 42-43','us9_5'],['US 10/EU 42','us10'],['US 10.5/EU 42-43','us10_5'],['US 11/EU 43','us11'],['US 11.5/EU 43-44','us11_5'],['US 12/EU 44','us12'],['US 12.5/EU 44-45','us12_5'],['US 13/EU 45','us13'],['US 14/EU 46','us14'],['US 15','us15']]
  end
end




  def can_view_edit_listing
    @listing =  Listing.find(params[:id])
    
    if @listing.nil?
      redirect_to shop_path,
      notice: "That Item is no longer available"
    end

    if @listing.is_sold == true
      redirect_to shop_path,
      notice: " That Item is no longer available"

     end


  end

  def can_sell

    if !user_signed_in?
      redirect_to  new_user_registration_path
    end

  end

  


  private
    def listing_params
      params.require(:listing).permit(:name, :brand, :colour, :condition, :department, :category, :size, :price, :is_sold, :cover_photo, :subcategory, :description, :supporting_photo_one,:supporting_photo_two,:supporting_photo_three,:supporting_photo_four,:supporting_photo_five,:supporting_photo_six)
    end




end
