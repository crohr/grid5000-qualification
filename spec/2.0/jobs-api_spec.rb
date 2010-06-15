require File.dirname(__FILE__)+'/../spec_helper'
require File.dirname(__FILE__)+'/helpers'

describe "Jobs API 2.0" do
  include TwoDot0::Helpers
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
    submit_job_on("rennes", {:command => "sleep 100"}) do |response|
      response.code.should == 201
      response.headers[:location].should_not be_nil
    end
  end
  
  it "should correctly delete a job" do
    submit_job_on("rennes", {:command => "sleep 100"}) do |response|
      response.code.should == 201
      delete uri_for(response.headers[:location]) do |response|
        response.code.should == 202
      end
    end
  end
end
