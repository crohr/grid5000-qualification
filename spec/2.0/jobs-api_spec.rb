require File.dirname(__FILE__)+'/../spec_helper'

describe "Jobs API 2.0" do
  it "should correctly fetch the list of running jobs" do
    get uri_for("/2.0/grid5000/sites/rennes/jobs"), :accept => :json do |response|
      response.code.should == 200
      result = parse(response)
      result.should have_key('items')
      result.should have_key('total')
      result.should have_key('offset')
    end
  end
  
  it "should correctly submit a job" do
    response = get uri_for("/2.0/grid5000/sites/rennes/status"), :accept => :json
    stats = {:hardware => {}, :system => {}}
    parse(response)['items'].each do |node_status|
      stats[:hardware][node_status["hardware_state"]] ||= 0
      stats[:hardware][node_status["hardware_state"]] += 1
      stats[:system][node_status["system_state"]] ||= 0
      stats[:system][node_status["system_state"]] += 1
    end
    if stats[:hardware]["alive"] > 0 && stats[:system]["free"] > 0
      post uri_for("/2.0/grid5000/sites/rennes/jobs"), {
        :command => "sleep 100"
      }, {:accept => :json} do |response|
        response.code.should == 201
        response.headers[:location].should_not be_nil
      end
    else
      pending "Not enough free resources to submit a job: #{stats.inspect}"
    end
  end
end
