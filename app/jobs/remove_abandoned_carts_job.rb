class RemoveAbandonedCartsJob < ApplicationJob
  queue_as :default

  def perform
    Cart.abandoned_for_seven_days_or_more.find_each do |cart|
      begin
        cart.destroy!
      rescue ActiveRecord::RecordNotDestroyed => e
        Rails.logger.error("Failed to destroy cart with id #{cart.id}: #{e.message}")
      end
    end
  end
end
