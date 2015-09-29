$: << File.join(File.dirname(__FILE__), %w{ .. .. })
require 'test_helper'

describe Webhookr::Vero do
  it "must be defined" do
    Webhookr::Vero::VERSION.wont_be_nil
  end
end