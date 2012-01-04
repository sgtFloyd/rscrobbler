module LastFM
  class Radio
    class << self

      TYPE = 'radio'

      # Fetch new radio content periodically in an XSPF format.
      #
      # @option params [Boolean, optional] :discovery           whether to request last.fm content in discovery mode
      # @option params [Boolean, optional] :rtp                 whether the user is scrobbling or not during this session (helps content generation)
      # @option params [Boolean, optional] :buylinks            whether the response should contain links for purchase/download
      # @option params [String,  optional] :speed_multiplier    the rate at which to provide the stream (supported multipliers are 1.0 and 2.0)
      # @option params [String,  optional] :bitrate             what bitrate to stream content at, in kbps (supported bitrates are 64 and 128)
      # @see: http://www.last.fm/api/show?service=256
      def get_playlist( params )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getPlaylist", params, :secure )
      end

      # Resolve the name of a resource into a station depending
      # on which resource it is most likely to represent.
      #
      # @option params [String, required] :name   the tag or artist name to resolve
      # @see: http://www.last.fm/api/show?service=418
      def search( params )
        LastFM.get( "#{TYPE}.search", params )
      end

      # Tune in to a Last.fm radio station.
      #
      # @option params [String, required] :station    a 'lastfm://...' radio url
      # @option params [String, optional] :lang       the language to return the station name in, expressed as an ISO 639 alpha-2 code
      # @see: http://www.last.fm/api/show?service=160
      def tune( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.tune", params )
      end

    end
  end 
end