# frozen_string_literal: true

require 'yabeda/gruf/version'
require 'yabeda'
require 'gruf'

require 'yabeda/gruf/server_interceptor'

module Yabeda
  module Gruf
    LONG_RUNNING_REQUEST_BUCKETS = [
      0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5, 10, # standard
      30, 60, 120, 300, 600, # Sometimes requests may be really long-running
    ].freeze

    class << self
      def install!
        configure_yabeda!
      end

      private

      def configure_yabeda!
        Yabeda.configure do
          group :gruf

          # server
          counter   :served_requests_total, comment: 'A counter of the total number of gRPC requests processed.'
          histogram :served_request_duration, unit: :seconds, buckets: LONG_RUNNING_REQUEST_BUCKETS,
                                              comment: 'A histogram of the response latency.'
        end
      end
    end
  end
end

Yabeda::Gruf.install!
