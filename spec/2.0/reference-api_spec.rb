require File.dirname(__FILE__)+'/../spec_helper'

describe "Reference API 2.0" do
  it "should correctly fetch the description of the rennes site" do
    get uri_for("/2.0/grid5000/sites/rennes"), :accept => :json do |response|
      response.code.should == 200
      result = parse(response)
      result['links'].should == [
        {"href"=>"/2.0/grid5000/sites/rennes/versions/#{result['version']}", "title"=>"version", "rel"=>"member", "type"=>"application/vnd.fr.grid5000.api.Version+json;level=1"}, 
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
  
  it "should correctly fetch a specific version of a node, using a timestamp" do
    timestamp = 1266735757
    get uri_for("/2.0/grid5000/sites/rennes/clusters/paradent/nodes/paradent-1?version=#{timestamp}"), :accept => :json do |response|
      response.code.should == 200
      version_uri = parse(response)['links'].find{|link| 
        link['title'] == 'version'}['href']
      get uri_for(version_uri) do |response|
        response.code.should == 200
        Time.parse(parse(response)['date']).to_i.should <= timestamp
      end
    end
  end
  
  it "should correctly fetch a specific version of a cluster, using a given commit hash" do
    hash = "a7f8aa62fc101dd41b6febbc7b1a9ce4ccb95e1a"
    get uri_for("/2.0/grid5000/sites/rennes/clusters/paradent?version=#{hash}"), :accept => :json do |response|
      response.code.should == 200
      parse(response)['version'].should == hash
    end
  end
end
