require File.dirname(__FILE__)+'/../spec_helper'

describe "Reference API 2.0" do
  it "should correctly fetch the description of the rennes site" do
    get uri_for("/2.0/grid5000/sites/rennes"), :accept => :json do |response|
      response.code.should == 200
      result = parse(response)
      result['links'].should == [
        {"href"=>"/2.0/grid5000/sites/rennes/versions/b11b4e515b921cc83d4f2a68923e899fcadf7c6a", "title"=>"version", "rel"=>"member", "type"=>"application/vnd.fr.grid5000.api.Version+json;level=1"}, 
        {"href"=>"/2.0/grid5000/sites/rennes/versions", "title"=>"versions", "rel"=>"collection", "type"=>"application/vnd.fr.grid5000.api.Collection+json;level=1"}, 
        {"href"=>"/2.0/grid5000/sites/rennes", "rel"=>"self", "type"=>"application/vnd.fr.grid5000.api.Site+json;level=1"}, 
        {"href"=>"/2.0/grid5000/sites/rennes/clusters", "title"=>"clusters", "rel"=>"collection", "type"=>"application/vnd.fr.grid5000.api.Collection+json;level=1"}, 
        {"href"=>"/2.0/grid5000/sites/rennes/environments", "title"=>"environments", "rel"=>"collection", "type"=>"application/vnd.fr.grid5000.api.Collection+json;level=1"}, 
        {"href"=>"/2.0/grid5000", "rel"=>"parent", "type"=>"application/vnd.fr.grid5000.api.Grid+json;level=1"}, 
        {"href"=>"/2.0/grid5000/sites/rennes/status", "title"=>"status", "rel"=>"collection", "type"=>"application/vnd.fr.grid5000.api.Collection+json;level=1"}, 
        {"href"=>"/2.0/grid5000/sites/rennes/metrics", "title"=>"metrics", "rel"=>"collection", "type"=>"application/vnd.fr.grid5000.api.Collection+json;level=1"}, 
        {"href"=>"/2.0/grid5000/sites/rennes/jobs", "title"=>"jobs", "rel"=>"collection", "type"=>"application/vnd.fr.grid5000.api.Collection+json;level=1"}, 
        {"href"=>"/2.0/grid5000/sites/rennes/deployments", "title"=>"deployments", "rel"=>"collection", "type"=>"application/vnd.fr.grid5000.api.Collection+json;level=1"}
      ]
      result['uid'].should == 'rennes'
    end
  end
end
