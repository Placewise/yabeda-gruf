# frozen_string_literal: true

module Yabeda
  module Gruf
    class ServerInterceptor < ::Gruf::Interceptors::ServerInterceptor
      def call # rubocop:disable Metrics/MethodLength
        response = nil
        error = nil

        start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

        begin
          response = yield
        rescue StandardError => e
          error = e
        end

        stop_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

        l = labels(response, error)

        Yabeda.gruf.served_requests_total.increment(l)
        Yabeda.gruf.served_request_duration.measure(l, stop_time - start_time)

        raise error if error
        response
      end

      private

      def labels(_response, error)
        {
          grpcService: request.service_key,
          grpcMethod: request.method_key,
          grpcStatus: error ? error.class.name : 'GRPC::Ok',
          status: status_code(error)
        }
      end

      def status_code(error)
        return '0' unless error
        return 'error' unless error.respond_to?(:code)

        error.code.to_s
      end
    end
  end
end
