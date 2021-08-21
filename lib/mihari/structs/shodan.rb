require "json"
require "dry/struct"

module Mihari
  module Structs
    module Shodan
      class Location < Dry::Struct
        attribute :country_code, Types::String
        attribute :country_name, Types::String

        def self.from_dynamic!(d)
          d = Types::Hash[d]
          new(
            country_code: d.fetch("country_code"),
            country_name: d.fetch("country_name")
          )
        end
      end

      class Match < Dry::Struct
        attribute :asn, Types::String
        attribute :hostnames, Types.Array(Types::String)
        attribute :location, Location
        attribute :domains, Types.Array(Types::String)
        attribute :ip_str, Types::String

        def self.from_dynamic!(d)
          d = Types::Hash[d]
          new(
            asn: d.fetch("asn"),
            hostnames: d.fetch("hostnames"),
            location: Location.from_dynamic!(d.fetch("location")),
            domains: d.fetch("domains"),
            ip_str: d.fetch("ip_str")
          )
        end
      end

      class Result < Dry::Struct
        attribute :matches, Types.Array(Match)
        attribute :total, Types::Int

        def self.from_dynamic!(d)
          d = Types::Hash[d]
          new(
            matches: d.fetch("matches", []).map { |x| Match.from_dynamic!(x) },
            total: d.fetch("total")
          )
        end
      end
    end
  end
end
