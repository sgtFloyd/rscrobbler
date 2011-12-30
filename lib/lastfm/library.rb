module LastFM
  class Library
    class << self

      TYPE = 'library'

      # see: http://www.last.fm/api/show?service=370
      def add_album( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addAlbum", params )
      end

      # see: http://www.last.fm/api/show?service=371
      def add_artist( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addArtist", params )
      end

      # see: http://www.last.fm/api/show?service=372
      def add_track( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addTrack", params )
      end

      # see: http://www.last.fm/api/show?service=321
      def get_albums( params )
        LastFM.get( "#{TYPE}.getAlbums", params )
      end

      # see: http://www.last.fm/api/show?service=322
      def get_artists( params )
         LastFM.get( "#{TYPE}.getArtists", params )
      end

      # see: http://www.last.fm/api/show?service=323
      def get_tracks( params )
        LastFM.get( "#{TYPE}.getTracks", params )
      end

      # see: http://www.last.fm/api/show?service=523
      def remove_album( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeAlbum", params )
      end

      # see: http://www.last.fm/api/show?service=524
      def remove_artist( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeArtist", params )
      end

      # see: http://www.last.fm/api/show?service=525
      def remove_scrobble( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeScrobble", params )
      end

      # see: http://www.last.fm/api/show?service=526
      def remove_track( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeTrack", params )
      end

    end
  end 
end