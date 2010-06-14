require File.dirname(__FILE__)+'/../spec_helper'

describe "Monitoring API 2.0" do
  it "should correctly fetch the status of the rennes site" do
    get uri_for("/2.0/grid5000/sites/rennes/status"), :accept => :json do |response|
      response.code.should == 200
      result = parse(response)
      result.should have_key('items')
      result.should have_key('total')
      result.should have_key('offset')
      result['links'].should == [
        {
          "href"=>"/2.0/grid5000/sites/rennes/status", 
          "rel"=>"self", 
          "type"=>"application/vnd.fr.grid5000.api.Collection+json;level=1"
        }
      ]
    end
  end
end
