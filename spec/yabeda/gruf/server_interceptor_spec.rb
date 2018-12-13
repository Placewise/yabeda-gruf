# frozen_string_literal: true

require 'spec_helper'

describe Yabeda::Gruf::ServerInterceptor do
  let(:base_subject) { described_class.new(request, error) }

  let(:block) { proc { 42 } }
  let(:request) { instance_double(Gruf::Controllers::Request) }
  let(:error) { nil }

  describe '#call' do
    before do
      allow(request).to receive(:service_key)
      allow(request).to receive(:method_key)
    end

    it 'returns returned value from given block' do
      expect(base_subject.call(&block)).to eq(42)
    end
  end
end
