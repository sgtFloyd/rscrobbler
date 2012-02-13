module LastFM
  module Api
    class Venue
      class << self

        # Get a list of upcoming events for a venue.
        #
        # @option params [Fixnum,  required] :venue           the id for the venue to fetch event listings for
        # @option params [Boolean, optional] :festivalsonly   whether only festivals should be returned, or all events
        # @see http://www.last.fm/api/show?service=394
        def get_events( params )
          LastFM.get( "venue.getEvents", params )
        end

        # Get a paginated list of all the events held at this venue in the past.
        #
        # @option params [Fixnum,  required] :venue           the id for the venue to fetch event listings for
        # @option params [Boolean, optional] :festivalsonly   whether only festivals should be returned, or all events
        # @option params [Fixnum,  optional] :page            the page number to fetch. defaults to first page
        # @option params [Fixnum,  optional] :limit           the number of results to fetch per page. defaults to 50
        # @see http://www.last.fm/api/show?service=395
        def get_past_events( params )
          LastFM.get( "venue.getPastEvents", params )
        end

        # Search for a venue by venue name.
        #
        # @option params [String, required] :venue      the venue name to search for
        # @option params [String, optional] :country    a country name used to limit results, as defined by ISO 3166-1
        # @option params [Fixnum, optional] :page       the page number to fetch. defaults to first page
        # @option params [Fixnum, optional] :limit      the number of results to fetch per page. defaults to 50
        # @see http://www.last.fm/api/show?service=396
        def search( params )
          LastFM.get( "venue.search", params )
        end

      end
    end
  end 
end