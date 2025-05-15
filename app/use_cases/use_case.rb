module UseCase
  extend ActiveSupport::Concern

  module ClassMethods
    def perform(...)
      new(...).tap(&:perform)
    end
  end

  def perform
    raise NotImplementedError
  end
end
