module LastFM
  class Radio
    class << self

      TYPE = 'radio'

      # @see: http://www.last.fm/api/show?service=256
      def get_playlist( params )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getPlaylist", params, :secure )
      end

      # @see: http://www.last.fm/api/show?service=418
      def search( params )
        LastFM.get( "#{TYPE}.search", params )
      end

      # @see: http://www.last.fm/api/show?service=160
      def tune( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.tune", params )
      end

    end
  end 
end