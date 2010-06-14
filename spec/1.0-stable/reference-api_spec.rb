require File.dirname(__FILE__)+'/../spec_helper'

describe "Reference API 1.0-stable" do
  it "should correctly fetch the description of the rennes site" do
    get uri_for("/1.0-stable/sites/rennes/versions/current.json") do |response|
      response.code.should == 200
      result = parse(response)
      result['uid'].should == 'rennes'
    end
  end
end
