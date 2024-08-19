class WebhooksController < ApplicationController
  def callback
    logger.info "Received webhook request body: #{request.raw_post}"
    logger.info "Received webhook request params: #{params.to_unsafe_h}"
  end
end
