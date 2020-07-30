# frozen_string_literal: true

module Yabeda
  module Gruf
    class ServerHook < ::Gruf::Hooks::Base
      def before_server_start(server:)
        Yabeda::Gruf.gruf_server = server
        Yabeda.configure! unless Yabeda.already_configured?
      end
    end
  end
end
