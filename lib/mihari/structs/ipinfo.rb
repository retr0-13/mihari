# frozen_string_literal: true

module Mihari
  module Structs
    module IPInfo
      class Response < Dry::Struct
        attribute :ip, Types::String
        attribute :hostname, Types::String.optional
        attribute :loc, Types::String
        attribute :country_code, Types::String
        attribute :asn, Types::Integer.optional

        class << self
          include Mixins::AutonomousSystem

          def from_dynamic!(d)
            d = d.deep_stringify_keys
            d = Types::Hash[d]

            asn = nil
            asn_ = d.dig("asn", "asn")
            asn = normalize_asn(asn_) unless asn_.nil?

            new(
              ip: d.fetch("ip"),
              loc: d.fetch("loc"),
              hostname: d["hostname"],
              country_code: d.fetch("country"),
              asn: asn
            )
          end
        end
      end
    end
  end
end
