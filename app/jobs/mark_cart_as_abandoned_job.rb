class MarkCartAsAbandonedJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Cart.abandonable.update_all(status: 'abandoned')
  end
end
