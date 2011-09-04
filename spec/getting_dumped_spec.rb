require 'spec_helper'

describe GettingDumped do
  it "should have some tests" do
    getting_dumped = GettingDumped.new({})
    getting_dumped.start_dump
  end
end
