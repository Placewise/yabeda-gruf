# frozen_string_literal: true

require 'yabeda/gruf/version'
require 'yabeda'
require 'gruf'

require 'yabeda/gruf/server_interceptor'
require 'yabeda/gruf/server_hook'
require 'yabeda/gruf/stats_collector'

module Yabeda
  module Gruf
    LONG_RUNNING_REQUEST_BUCKETS = [
      0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5, 10, # standard
      30, 60, 120, 300, 600, # Sometimes requests may be really long-running
    ].freeze
    REQUEST_LABELS = %i[grpcService grpcMethod grpcStatus status].freeze

    class << self
      attr_accessor :gruf_server

      def install!
        configure_yabeda!
      end

      private

      def configure_yabeda!
        Yabeda.configure do
          group :gruf do
            # server interceptor
            counter   :served_requests_total,
                      comment: 'A counter of the total number of gRPC requests processed.',
                      tags: REQUEST_LABELS
            histogram :served_request_duration, unit: :seconds, buckets: LONG_RUNNING_REQUEST_BUCKETS,
                                                comment: 'A histogram of the response latency.',
                                                tags: REQUEST_LABELS

            # server collector
            gauge :pool_jobs_waiting_total, comment: 'Number of jobs in thread pool waiting'
            gauge :pool_ready_workers_total, comment: 'Number of non-busy workers in thread pool'
            gauge :pool_workers_total, comment: 'Total number of workers in thread pool'
            gauge :pool_initial_size, comment: 'Initial size of thread pool'
            gauge :poll_period, comment: 'Polling period for thread pool'
          end

          collect do
            Yabeda::Gruf::StatsCollector.new.collect! if Yabeda::Gruf.gruf_server
          end
        end
      end
    end
  end
end

Yabeda::Gruf.install!
