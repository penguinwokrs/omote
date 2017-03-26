# frozen_string_literal: true
module TrustDock
  module Callbacks
    class Base
      attr_accessor :authentication, :params

      def initialize(args = {})
        @authentication = args[:authentication]
        @params = args[:params]&.with_indifferent_access
      end

      def update
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end
    end
  end
end
