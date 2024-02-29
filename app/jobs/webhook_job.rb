class WebhookJob < ApplicationJob
  queue_as :default

  def perform(webhook)
    # Do something later
    event = webhook.event

    puts event
    case event
      
    
    when "shipment.created"
      data = webhook.data.to_json
      puts data['metadata']
    when "shipment.in-transit"
      data = webhook.data.to_json
      puts data['metadata']
    end

  end

end
