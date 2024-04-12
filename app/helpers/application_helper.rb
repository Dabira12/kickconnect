module ApplicationHelper
    ORDER_STATUS_SELLER = {
        "sold" => 'A buyer has bought your item, Waiting for you to fulfill shipping',
        "in_transit"=> 'Item shipped, in transit ',
        "delivered" => 'Item delivered to buyer, waiting for buyer to confirm items are okay before releasing funds to you',
        "accepted" => ' Item delivered, funds released to you',
        "refund_request" => 'Refund requested by buyer, being investigated',
        "refund_issued" => 'Refund issued to buyer, item sent back to you'
      }

      ORDER_STATUS_BUYER = {
        "sold" => 'Item Sold, Waiting for seller to ship the item',
        "in_transit"=> 'Item shipped by seller, in transit  ',
        "delivered" => 'Item delivered, waiting for you to confirm items are okay before releasing funds to seller. You have 3 days from when item was delivered to request a refund or confirm if the item is as expected ',
        "accepted" => ' Funds released to seller, Order is now non refundable',
        "refund_request" => 'You have requested a refund, it is being investigated',
        "refund_issued" => 'Refund issued to you, item sent back seller'
      }



    
      
      def show_status_seller(value)
        # return ORDER_STATUS.key(value)
       
        # return ORDER_STATUS.keys
        return ORDER_STATUS_SELLER[value]
      end

      def show_status_buyer(value)
        # return ORDER_STATUS.key(value)
       
        # return ORDER_STATUS.keys
        return ORDER_STATUS_BUYER[value]
      end

      def send_text_termii(number,message)

      termii_uri = URI("https://api.ng.termii.com/api/sms/send")

               
            payload = {
                from: 'N-alert',
                to: number,
                sms: message,
                type: "plain",
                channel: "dnd",
                api_key: "TL69UmCAmrH9rruZ8MOGtLcDUYrz88tI5NQqsJeWV1zWPgyXE5YMn7CTIaNnV6"
            }

            headers = { 'Content-Type': 'application/json'}
            response = Net::HTTP.post(termii_uri, payload.to_json, headers)
            res= JSON.parse(response.body)
            puts res
     end

end
