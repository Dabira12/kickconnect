class ListingsController < ApplicationController

  before_action :set_current_user
  
  def index
  end

  def sale
    @listings = Listing.where(is_sold: false)
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
    # @listing = listing.new
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


  private
    def listing_params
      params.require(:listing).permit(:name, :brand, :colour, :condition, :department, :category, :price, :is_sold, :cover_photo, :description, :supporting_photo_one,:supporting_photo_two,:supporting_photo_three,:supporting_photo_four,:supporting_photo_five,:supporting_photo_six)
    end




end
