class MarkCartAsAbandonedJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts ">>>>> TestJob is working! Args: #{args.inspect}"
  end
end
