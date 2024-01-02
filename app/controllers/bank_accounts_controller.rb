class BankAccountsController < ApplicationController
    require "uri"
    require "net/http"
    require 'json'
    before_action :bank_account_exists, only:[:new]
   
    
    def new
        # if current_user.bank_account== nil


        # flash.now[:alert] = "Before you create a listing, you must enter your bank account details so we can pay you when your item gets sold!"
        # end

            
        url = URI("https://api.flutterwave.com/v3/banks/NG")

        http = Net::HTTP.new(url.host, url.port);
        http.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request["Authorization"] = "Bearer FLWSECK_TEST-bc051d6049a3f37b4f52dd749f6943b5-X"

        response = http.request(request)
        ans = JSON.parse(response.read_body)
        @banklist=[]
        ans ['data'].each do |bank|
                @banklist.push( [bank['name'], bank['code']])

        end
      

            @bank_account = current_user.build_bank_account
       
     end

    def create
            
        url = URI("https://api.flutterwave.com/v3/banks/NG")

        http = Net::HTTP.new(url.host, url.port);
        http.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request["Authorization"] = "Bearer FLWSECK_TEST-bc051d6049a3f37b4f52dd749f6943b5-X"

        response = http.request(request)
        ans = JSON.parse(response.read_body)
        @banklist=[]
        ans ['data'].each do |bank|
                @banklist.push( [bank['name'], bank['code']])

        end
        @bank_account = current_user.build_bank_account(bank_account_params)
       
    
        if @bank_account.save

            respond_to do |format|
                format.html { redirect_to new_listing_path, notice: "Bank Account sucessfully added you may now create a listing" }
                format.json { head :no_content }
              end
           
            


        else
            render :new
            
            @bank_account.errors.full_messages.each do |message| 
                   
                     
                puts message
            end
                
            

        end
    
     
    end 

    def bank_account_exists
        if current_user.bank_account != nil
            redirect_to sell_sale_path
        end 
    end

    private
    def bank_account_params
      params.require(:bank_account).permit(:account_number, :bank_code, :bank_name)
    end



end
