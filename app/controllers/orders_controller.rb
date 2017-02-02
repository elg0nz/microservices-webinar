##
# OrdersController is an example of an extremely coupled controller that should
# be refactored
#
class OrdersController < ApplicationController

  def create
    ## Check current user is active
    if ! current_user.active?
       render json: MultiJson.dump({error: 'User not active'}), status: 422
    end

    if ! current_user.can_create_orders?
       render json: MultiJson.dump({error: 'User Cannot Create orders'}), status: 422
    end

    processing = true
    while processing do
      logger.log "Processing"
      transaction = FakeBraintree.generate_transaction(
        amount: '20.00',
        status: Braintree::Transaction::Status::Settled,
        subscription_id: 'foobar',
        created_at: Time.now + 60
      )
      logger.log "Done"
      processing = false
    end

      uri = URI.parse("http://www.twweet$.com/mssg")
      req = Net::HTTP::Post.new(uri.path)
      req['Content-Length'] = 3

      res = Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(req, "I just ordered the trailblazer book!")
      end

    if (transaction && res)
      render json: MultiJson.dump({status: 'Order created'}), status: 200
    end
    render json: MultiJson.dump({error: 'Order could not be created'}), status: 500
  end
end
