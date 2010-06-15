module TwoDot0
  module Helpers
    def submit_job_on(site, payload, &block)
      response = get uri_for("/2.0/grid5000/sites/#{site}/status"), :accept => :json
      stats = {:hardware => {}, :system => {}}
      parse(response)['items'].each do |node_status|
        stats[:hardware][node_status["hardware_state"]] ||= 0
        stats[:hardware][node_status["hardware_state"]] += 1
        stats[:system][node_status["system_state"]] ||= 0
        stats[:system][node_status["system_state"]] += 1
      end
      if stats[:hardware]["alive"] > 0 && stats[:system]["free"] > 0
        post uri_for("/2.0/grid5000/sites/#{site}/jobs"), payload, 
          {:accept => :json} do |response|
          if block_given?
            yield response
          else
            response.return!
          end
        end
      else
        pending "Not enough free resources to submit a job on #{site}: #{stats.inspect}"
      end
    end
  end
end
