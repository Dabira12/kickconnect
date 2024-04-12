class WebhookJob < ApplicationJob
  include ApplicationHelper
  queue_as :default

  def perform(webhook)
    # Do something later
    event = webhook.event

    puts 'yesokl'
    data = webhook.data
    puts data
    ship_id= data['shipment_id']
    puts ship_id
    buyer_id = data['metadata']['buyer_id']
    listing_id = data['metadata']['listing_id']

    puts listing_id
    puts buyer_id
    

    # headers = { 'Content-Type': 'application/json', 'Authorization': 'Bearer sk_test_yRZJuyWvH4HALP8upPDcoaEw3JIs0yVO' }
    # uri = URI('https://sandbox.terminal.africa/v1/shipments/'+ship_id)
    # response = Net::HTTP.get_response(uri, headers)
    # response_json = JSON.parse(response.body)
    # puts "buffer"
    # puts response_json['data']['metadata']
    # puts "ooo"
    # listing_id = response_json['data']['metadata']['listing_id']
    # puts listing_id
    # buyer_id = response_json['data']['metadata']['buyer_id']
    # puts buyer_id
    phone_number = User.find(buyer_id).phone_number
    
    puts phone_number

    case event
    


    when "shipment.created"
      puts "this is my id"
      puts ship_id
      mes = "your item is on its way!"
      send_text_termii(phone_number,mes) #method from application helper
    when "shipment.in-transit"
     
      
    end

  end

end
