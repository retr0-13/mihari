# frozen_string_literal: true

require "mihari/commands/init"

module Mihari
  module CLI
    class Initialization < Base
      include Mihari::Commands::Initialization
    end
  end
end
