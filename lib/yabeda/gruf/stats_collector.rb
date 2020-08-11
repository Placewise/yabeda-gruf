# frozen_string_literal: true

module Yabeda
  module Gruf
    class StatsCollector
      def collect!
        return unless server

        server.instance_variable_get(:@run_mutex).synchronize { measure_metrics }
      end

      private

      def measure_metrics
        return unless pool

        Yabeda.gruf.pool_jobs_waiting_total.set({}, pool.jobs_waiting.to_i)
        Yabeda.gruf.pool_ready_workers_total.set({}, pool.instance_variable_get(:@ready_workers)&.size)
        Yabeda.gruf.pool_workers_total.set({}, pool.instance_variable_get(:@workers)&.size)
        Yabeda.gruf.pool_initial_size.set({}, server.instance_variable_get(:@pool_size)&.to_i)
        Yabeda.gruf.poll_period.set({}, server.instance_variable_get(:@poll_period)&.to_i)
      end

      def pool
        @pool ||= server&.instance_variable_get(:@pool)
      end

      def server
        @server ||= Yabeda::Gruf.gruf_server&.server
      end
    end
  end
end
