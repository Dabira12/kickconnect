class Address < ApplicationRecord
    require 'json'
    belongs_to :user

    before_save :try

    serialize :google_address_components

    # validates :line1, presence: true
    private
        def try
            street_number, locality, route, neighborhood, administrative_area_level_1, administrative_area_level_2, administrative_area_level_3, zipcode = nil
            # locality = nil
            # route = nil
            # neighborhood = nil
            # administrative_area_level_1 = nil
            # administrative_area_level_2 = nil
            # administrative_area_level_3 = nil
            # postal_code = nil

            states = get_states
            
            
            
                address_components = JSON.parse(self.google_address_components)

                for component in address_components
                    puts component
                    if component['types'].include?('street_number') == true
                        street_number = component['long_name']
                        
                    elsif component['types'].include?('route') == true
                            route = component['long_name']
                           
                    elsif component['types'].include?('neighborhood') == true
                        neighborhood = component['long_name']


                    elsif component['types'].include?('locality') == true
                            locality = component['long_name']

                    elsif component['types'].include?('administrative_area_level_3') == true
                            administrative_area_level_3 = component['long_name']
    

                    elsif component['types'].include?('administrative_area_level_2') == true 
                            administrative_area_level_2 = component['long_name']
    
                    

                    elsif component['types'].include?('administrative_area_level_1') == true
                        if component['long_name'] == 'Federal Capital Territory'

                            administrative_area_level_1_short_name = 'FC'
                            administrative_area_level_1 = 'Abuja'

                        else

                            for state in states
                                administrative_area_level_1 = component['long_name']
                                if state['name'] == administrative_area_level_1
                                    administrative_area_level_1_short_name = state['isoCode']
                                end

                            end
                        
                       
                       
                        end

                   
                    

                    elsif component['types'].include?('postal_code') == true
                        zipcode = component['long_name']

                    end
                end 

                if street_number == nil and route!= nil
                    self.line1 = route
                else
                    self.line1 = street_number + ' ' + route

                end

                self.state = administrative_area_level_1
                self.state_code = administrative_area_level_1_short_name
                self.zipcode = zipcode
                self.country_code = 'NG'

                puts neighborhood
                puts 'oh oh '


                url = URI("https://api.terminal.africa/v1/cities?country_code=NG&state_code=" + self.state_code)

                http = Net::HTTP.new(url.host, url.port);
                http.use_ssl = true
                request = Net::HTTP::Get.new(url)
                request["Authorization"] = "Bearer sk_live_1TbW7FD0YBcPcvMks29t9OEUBskgi9UR"
            
                response = http.request(request)
                cities = JSON.parse(response.read_body)['data']

                for city in cities
                    if city['name'] == administrative_area_level_2
                        self.city = administrative_area_level_2
                        break
                    elsif city['name'] == neighborhood
                        self.city = neighborhood

                        break
                    elsif city['name'] == locality
                        self.city = locality

                        break
                    end
                     
               
                end


        end


        def get_states

            url = URI("https://api.terminal.africa/v1/states?country_code=NG")
            http = Net::HTTP.new(url.host, url.port);
            http.use_ssl = true
            request = Net::HTTP::Get.new(url)
            request["Authorization"] = "Bearer sk_live_1TbW7FD0YBcPcvMks29t9OEUBskgi9UR"
            response = http.request(request)
            states = JSON.parse(response.read_body)['data']
            puts states
            return states

        end

end
