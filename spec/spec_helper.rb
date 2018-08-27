require 'simplecov'

SimpleCov.start "rails" do
  minimum_coverage 85
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'colonel_kurtz'
require 'pry'
