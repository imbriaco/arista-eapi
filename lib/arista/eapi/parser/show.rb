module Arista
  module EAPI
    class Parser
      class Show
        def self.show_lldp_neighbors(body)
          lldp = {
            :last_update => nil,
            :ports => {}
          }

          lldp[:last_update] = body.match(/^Last table change time\s+:\s(.*?)$/m)[1]
          ports = body.match(/.*Neighbor Port ID\s*TTL\s(.*)/m)[1]

          unless ports.nil?
            ports.split("\n").each do |line|
              name, neighbor_device_id, neighbor_port_id, ttl = line.split
              lldp[:ports][name] = {
                :neighbor_device_id => neighbor_device_id,
                :neighbor_port_id   => neighbor_port_id,
                :ttl                => ttl
              }
            end
          end

          { :lldp_neighbors => lldp }
        end
      end
    end
  end
end