module LastFM
  class Playlist
    class << self

      TYPE = 'playlist'

      # see: http://www.last.fm/api/show?service=337
      def add_track( playlist_id, artist, track )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addTrack", 'playlistID'=>playlist_id, 'artist'=>artist, 'track'=>track )
      end

      # see: http://www.last.fm/api/show?service=365
      def create( title = nil, description = nil )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.create", 'title'=>title, 'description'=>description )
      end

      # see: http://www.last.fm/api/show?service=271
      def fetch( playlist_url )
        LastFM.get( "#{TYPE}.fetch", !:secure, 'playlistURL'=>playlist_url )
      end

    end
  end 
end