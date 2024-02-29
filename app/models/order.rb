class Order < ApplicationRecord
    belongs_to :listing

    enum :status, {sold: "sold", in_transit: "in_transit", delivered: "delivered", refund_request: "refund_request", refund_issued: "refund_issued"}

    
end
