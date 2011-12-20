module LastFM
  class Library
    class << self

      TYPE = 'library'

      # see: http://www.last.fm/api/show?service=370
      def add_album( artist, album )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addAlbum", 'artist'=>artist, 'album'=>album )
      end

      # see: http://www.last.fm/api/show?service=371
      def add_artist( artist )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addArtist", 'artist'=>artist )
      end

      # see: http://www.last.fm/api/show?service=372
      def add_track( track, artist )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addTrack", 'track'=>track, 'artist'=>artist )
      end

      # see: http://www.last.fm/api/show?service=321
      def get_albums( user, artist = nil, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getAlbums", !:secure, 'user'=>user, 'artist'=>artist, 'limit'=>limit, 'page'=>page )
      end

      # see: http://www.last.fm/api/show?service=322
      def get_artists( user, limit = nil, page = nil )
         LastFM.get( "#{TYPE}.getArtists", !:secure, 'user'=>user, 'limit'=>limit, 'page'=>page )
      end

      # see: http://www.last.fm/api/show?service=323
      def get_tracks( user, artist = nil, album = nil, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getTracks", !:secure, 'user'=>user, 'artist'=>artist, 'album'=>album, 'limit'=>limit, 'page'=>page )
      end

      # see: http://www.last.fm/api/show?service=523
      def remove_album( artist, album )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeAlbum", 'artist'=>artist, 'album'=>album )
      end

      # see: http://www.last.fm/api/show?service=524
      def remove_artist( artist )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeArtist", 'artist'=>artist )
      end

      # see: http://www.last.fm/api/show?service=525
      def remove_scrobble( track, artist, timestamp )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeScrobble", 'track'=>track, 'artist'=>artist, 'timestamp'=>timestamp )
      end

      # see: http://www.last.fm/api/show?service=526
      def remove_track( track, artist )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeTrack", 'track'=>track, 'artist'=>artist )
      end

    end
  end 
end