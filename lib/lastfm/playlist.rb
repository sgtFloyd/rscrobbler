module LastFM
  class Playlist
    class << self

      TYPE = 'playlist'

      # see: http://www.last.fm/api/show?service=337
      def add_track( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addTrack", params )
      end

      # see: http://www.last.fm/api/show?service=365
      def create( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.create", params )
      end

      # see: http://www.last.fm/api/show?service=271
      def fetch( params )
        LastFM.get( "#{TYPE}.fetch", !:secure, params )
      end

    end
  end 
end