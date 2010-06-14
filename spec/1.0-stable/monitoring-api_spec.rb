require File.dirname(__FILE__)+'/../spec_helper'

describe "Monitoring API 1.0-stable" do
  it "should correctly fetch the status of the rennes site" do
    get uri_for("/1.0-stable/sites/rennes/statuses/current"), :accept => :json do |response|
      response.code.should == 200
      result = parse(response)
      result.should have_key('aggregated_nodes_stats')
      result.should have_key('clusters')
    end
  end
end
