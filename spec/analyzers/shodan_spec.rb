# frozen_string_literal: true

RSpec.describe Mihari::Analyzers::Shodan, :vcr do
  subject { described_class.new(query) }

  let(:query) { "ip:1.1.1.1" }

  describe "#artifacts" do
    it do
      artifacts = subject.artifacts

      expect(artifacts).to be_an(Array)
      expect(artifacts.length).to eq(1)

      expect(artifacts.first.data).to eq("1.1.1.1")

      expect(artifacts.first.autonomous_system.asn).to eq(13_335)

      expect(artifacts.first.geolocation.country_code).to eq("US")

      expect(artifacts.first.metadata).to be_an(Array)
      expect(artifacts.first.metadata.first).to be_a(Hash)
    end
  end

  context "when api config is not given" do
    before do
      allow(Mihari.config).to receive(:shodan_api_key).and_return(nil)
    end

    it do
      expect { subject.artifacts }.to raise_error(ArgumentError)
    end
  end

  context "when the API raises a timeout error" do
    describe "#artifacts" do
      before do
        mock = double("API")
        allow(mock).to receive_message_chain(:host, :search).and_raise(Shodan::Error.new("The search request timed out."))
        allow(Shodan::API).to receive(:new).and_return(mock)
      end

      it do
        expect { subject.artifacts }.to raise_error(Mihari::RetryableError)
      end
    end
  end
end
