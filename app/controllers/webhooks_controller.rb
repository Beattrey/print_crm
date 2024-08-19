class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callback]
  before_action :verify_webhook_token, only: [:callback]

  def callback
    logger.info "Received webhook request body: #{request.raw_post}"
    logger.info "Received webhook request params: #{params.to_unsafe_h}"
    head :ok
  end

  private

  def verify_webhook_token
    token = request.headers['X-Webhook-Token']
    unless token && ActiveSupport::SecurityUtils.secure_compare(token, Rails.application.credentials.webhook_secret)
      logger.warn "Invalid webhook token"
      head :unauthorized
    end
  end
end
