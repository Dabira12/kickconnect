class ListingsController < ApplicationController
  include ListingHelper
  include ApplicationHelper

  require 'phonelib'
  require 'json'
  # before_action :authenticate_user!
  # before_action :can_edit_listing, only:[:edit]
  before_action :signed_in, only:[:new, :edit, :sale]
  before_action :can_edit_listing, only:[ :edit]
  # before_action :can_view_listing, only: [:show]
  # before_action :can_sell, only:[:sale]

  # before_action :valid_bank_account, only:[:new]
 before_action :storefront_user_exists, only:[:storefront]
  
  def index
    
    
  end

  def sale
    @listings = Listing.where(is_sold: false, user_id: current_user.id)
   
  end

  def storefront
      @user = User.find_by(username: params[:username])
      @username= params[:username]
      @listings = Listing.where(user_id:@user.id, is_sold:false)
      
  end

  def sold
    @orders = Order.where( seller_id: current_user.id).order("created_at ASC")
  end

  def get_listing_price
    if Listing.exists?(params[:id])
      listing = Listing.find(params[:id])
      puts listing.price
      price = (listing.price)
      
      render json: {price: price}, status: 200
    end 
  end

  def show

    if Listing.exists?(params[:id])
      @listing = Listing.find(params[:id])
      # num = current_user.phone_number
      # send_text_termii(num)
      respond_to do |format|
        format.html 
        format.json { render json:@listing,status: :ok }
      end
    else
      respond_to do |format|
        format.html {redirect_to shop_path}
        format.json { render json: {message: 'listing not found'}, status: :unprocessable_entity}
      end
     
     
      
    end
    
  end 

  def show_all
    # valid_exp =~ /(7|8|9){1}(0|1){1}[0–9]{8}\

   puts current_user
    # puts '8023377545'.match?(valid_exp)

   
   puts params
      
    if params[:department] != nil
      @listings = Listing.where(is_sold: false, department: params[:department])
    else
      @listings = Listing.where(is_sold: false)
    end
     
  end

  def purchases
    @orders = Order.where( buyer_id:current_user.id)
  end

  # GET /listings/new
  def new
    # @listing = Listing.new
    @listing = current_user.listings.build
  


    
  end

  

  def create
    # @listing = listing.new(listing_params)
    @listing = current_user.listings.build(listing_params)
    user = User.find(current_user.id)
    # address = Address.find(user.default_address_id)
   
    
    
    if @listing.save

       
      

      
      redirect_to sell_sale_path
    else
      puts"test"
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @default_address = Address.find_by(user_id:current_user.id, id:current_user.default_address_id)
    @listing = Listing.find(params[:id])
  end 

  def update
    @listing = Listing.find(params[:id])
    @default_address = Address.find_by(user_id:current_user.id, id:current_user.default_address_id)
    puts 'yes'

  #  if @listing.update(listing_address_params)
  #       puts 'yes'
  #  end 


  
    if @listing.update(listing_address_params)
      if @listing.saved_change_to_addresses_id
        
        render turbo_stream: turbo_stream.replace("address", partial:"addresses/show",locals:{current_address_id: @listing.addresses_id, default: false, listing_id:@listing.id})
        return
      end
     
    end

    if @listing.update(listing_params)
      # @listing.update_attribute(:addresses_id, address.id)
      # @listing.update_attribute(:sender_address, address.line1)
      # puts 'updated'

      redirect_to listing_path(@listing.id)
      
    



     

      
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

   
    respond_to do |format|
      format.html { redirect_to shop_path, notice: "Listing was successfully deleted." }
      format.json { head :no_content }
    end
    # flash.now[:notice] = "Listing sucessfuly deleted"

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
    puts @sizes


  end 


#   def getCategories(department)
#     if department == "menswear"
#         return [['Select a category',nil],['Tops','tops'],['Bottoms','bottoms'],['Footwear','footwear'],['Outerwear','outerwear'],['Accessories','accessories']]

#     elsif department == "womenswear"
#       return [['Select a category',nil],['Tops','tops'],['Bottoms','bottoms'],['Footwear','footwear'],['Outerwear','outerwear'],['Accessories','accessories'],['Dresses','dresses']]
#     end
    

# end

# def getSubCategories(category,department)
#   if category == "tops"
#     return [['Select a sub-category',nil],['Shirts','shirts'],['T-shirts','tshirts'],['Jerseys','jerseys'],['Sweatshirts','sweatshirts'],['Polos','polos'],['Tanks','tanks']]

#   elsif category == "bottoms" && department == "menswear"
#     return [['Select a sub-category',nil],['Jeans','jeans'],['Pants','pants'],['Sweatpants/Joggers', 'sweatpants'],['Shorts','shorts']]

#   elsif category == "bottoms" && department == "womenswear"
#     return [['Select a sub-category',nil],['Jeans','jeans'],['Pants','pants'],['Sweatpants/Joggers', 'sweatpants'],['Shorts','shorts'],['Skirts','skirts']]


#   elsif category == "outerwear"
#     return [['Select a sub-category',nil],['Coats','coats'],['Jackets','jackets']]

#   elsif category== "footwear" &&  department == "menswear" 
#     return [['Select a sub-category',nil],['Sneakers', 'sneakers'], ['Boots','boots'],['Loafers','loafers'], ['Sandals','sandals'],['Slippers','slippers'],['Oxfords','oxfords'],['Brogues','brogues'],['Boat shoes', 'boats'], ['Espadrilles','espadrilles']]

#   elsif category == "footwear"  &&  department =="womenswear" 
#     return [['Select a sub-category',nil],['Heels', 'heels'], ['Sneakers' ,'sneakers'], ['Flats', 'flats'], ['Sandals', 'sandals'],['Slippers','slippers'], ['Mules','mules'], ['Platforms','platform'],['Boots','boots']]

#   elsif category == "accessories"
#     return[['Select a sub-category',nil],['Belts','belts'],['Glasses','glasses'],['Hats','hats'],['Wallets/Cardholders','wallets'],['Jewelry','jewelry'],['Watches','watches'],['Scarves','scarves']]

#   elsif category == "dresses" 
#     return [['Select a sub-category',nil],['MiniDresses','minidresses'],['Maxidresses','maxidresses'],['Mididresses', 'mididresses'],['Gowns','gowns']]

#   end
# end

# def getSizes(category)
#   if category == "tops"
#     return [['Select a size',nil],['US XXS/EU 40','usxxs'],['US XS/EU 42', 'usxs'],['US S/EU 44-46','uss'], ['US M/EU 48-50','usm'],['US L/EU 52-54','usl'],['US XL/EU 56','usxl'], ['US XXL/EU 58', 'usxxl']]

#   elsif category == "bottoms"
#     return [['Select a size', nil], ['US 26/EU 42','us26'], ['US 27','us27'],['US 28/EU 44', 'us28'],['US 29','us29'], ['US 30/EU 46','us30'],['US 31','us31'],['US 32/EU 48','us32'], ['US 33','us33'],['US 34/EU 50','us34'],['US 35','us35'],['US 36/ EU 52','us36'],['US 37','us37'], ['US 38/EU 54','us38',],['US 39', 'us39'],['US 40/EU 56','us40'],['US 41','us41'],['US 42/EU58','us42'],['US 43','us43'],['US 44/EU 60','us44']]

#   elsif category =="accessories"
#     return [['Select a size', nil], ['ONE SIZE','onesize']]

#   elsif category =="outerwear"
#     return [['Select a size',nil],['US XXS/EU 40','usxxs'],['US XS/EU 42', 'usxs'],['US S/EU 44-46','uss'], ['US M/EU 48-50','usm'],['US L/EU 52-54','usl'],['US XL/EU 56','usxl'], ['US XXL/EU 58', 'usxxl']]
#     # return [['Select a sub-category',nil],['MiniDresses','minidresses'],['Maxidresses','maxidresses'],['Mididresses', 'mididresses'],['Gowns','gowns']]
#   elsif category =="footwear"
#     return [['Select a size',nil],['US 5/ EU 37','us5'], ['US 5.5 / EU 38','us5_5'] ,['US 6/ EU 39','us6'],['US 6.5/EU 39-40','us6_5'],['US 7/EU 40','us7'],['US 7.5/EU 40-41','us7_5'],['US 8/ EU41','us8'],['US 8.5/EU 41-42','us8_5'],['US 9/EU 42','us9'],['US 9.5/EU 42-43','us9_5'],['US 10/EU 42','us10'],['US 10.5/EU 42-43','us10_5'],['US 11/EU 43','us11'],['US 11.5/EU 43-44','us11_5'],['US 12/EU 44','us12'],['US 12.5/EU 44-45','us12_5'],['US 13/EU 45','us13'],['US 14/EU 46','us14'],['US 15','us15']]
#   end
# end




  def can_edit_listing
    @listing =  Listing.find(params[:id])
    

    if @listing.is_sold == true
      redirect_to shop_path,
      notice: " You can no longer edit that item"

     end


  end

  def valid_bank_account
  

    if current_user.bank_account === nil
      redirect_to new_bank_account_path,
      alert: "Before you create a listing, you must enter your bank account details so we can pay you when your item gets sold!"
    
    end 
  end

  def can_view_listing
    listing = Listing.find(params[:id])

    if listing.is_sold === true && (!user_signed_in? || current_user.id != listing.user_id)
      puts listing.user_id
      redirect_to shop_path,
      
      notice: " You can no longer view that item"
    end 
  end

  def can_sell

    if !user_signed_in?
      redirect_to  new_user_registration_path
    end

  end

  def signed_in
    if !user_signed_in?
      redirect_to  new_user_registration_path
    end
  
  end

  def storefront_user_exists
    user = User.find_by(username: params[:username])
    if user == nil
      redirect_to shop_path
    end
  end

  


  private
    def listing_params
      params.require(:listing).permit(:name, :brand, :colour, :condition, :department, :category, :size, :price, :is_sold, :cover_photo, :subcategory, :description, :addresses_id, :supporting_photo_one,:supporting_photo_two,:supporting_photo_three,:supporting_photo_four,:supporting_photo_five,:supporting_photo_six)
    end



    def listing_address_params
      params.require(:listing).permit(:addresses_id)
    end




end
