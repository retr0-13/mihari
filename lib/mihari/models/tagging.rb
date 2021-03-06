# frozen_string_literal: true

module Mihari
  class Tagging < ActiveRecord::Base
    belongs_to :alert
    belongs_to :tag
  end
end
