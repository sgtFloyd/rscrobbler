module LastFM
  class Library
    class << self

      TYPE = 'library'

      # Add an album or collection of albums to a user's Last.fm library.
      #
      # @option params [Array, required] :artists   the artist or collection of artists to add
      # @option params [Array, required] :albums    the album or collection of albums to add. the indices of the albums that you pass MUST correspond to those of the artists
      # see: http://www.last.fm/api/show?service=370
      def add_album( params )
        LastFM.requires_authentication
        # TODO: convert :artists and :albums to artists[i], albums[i]
        LastFM.post( "#{TYPE}.addAlbum", params )
      end

      # Add an artist or collection of artists to a user's Last.fm library.
      #
      # @option params [Array, required] :artists   the artist or collection of artists to add
      # see: http://www.last.fm/api/show?service=371
      def add_artist( params )
        LastFM.requires_authentication
        # TODO: convert :artists to artists[i]
        LastFM.post( "#{TYPE}.addArtist", params )
      end

      # Add a track or collection of tracks to a user's Last.fm library.
      #
      # @option params [Array, required] :artists   the artist or collection of artists to add
      # @option params [Array, required] :tracks    the track or collection of tracks to add. the indices of the tracks that you pass MUST correspond to those of the artists
      # see: http://www.last.fm/api/show?service=372
      def add_track( params )
        LastFM.requires_authentication
        # TODO: convert :artists and :tracks to artists[i], tracks[i]
        LastFM.post( "#{TYPE}.addTrack", params )
      end

      # A paginated list of all the albums in a user's library, with play counts and tag counts.
      #
      # @option params [String, requried] :user     the user whose library you want to fetch
      # @option params [String, optional] :artist   an artist by which to filter albums
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # see: http://www.last.fm/api/show?service=321
      def get_albums( params )
        LastFM.get( "#{TYPE}.getAlbums", params )
      end

      # A paginated list of all the artists in a user's library, with play counts and tag counts.
      #
      # @option params [String, requried] :user     the user whose library you want to fetch
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # see: http://www.last.fm/api/show?service=322
      def get_artists( params )
         LastFM.get( "#{TYPE}.getArtists", params )
      end

      # A paginated list of all the tracks in a user's library, with play counts and tag counts.
      #
      # @option params [String, requried] :user     the user whose library you want to fetch
      # @option params [String, optional] :artist   an artist by which to filter track
      # @option params [String, optional] :album    an album by which to filter tracks (requires an associated artist)
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # see: http://www.last.fm/api/show?service=323
      def get_tracks( params )
        LastFM.get( "#{TYPE}.getTracks", params )
      end

      # Remove an album from a user's Last.fm library.
      #
      # @option params [String, required] :artist   the artist that composed the album
      # @option params [String, required] :album    the name of the album to remove
      # see: http://www.last.fm/api/show?service=523
      def remove_album( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeAlbum", params )
      end

      # Remove an artist from a user's Last.fm library.
      #
      # @option params [String, required] :artist   the name of the artist to remove
      # see: http://www.last.fm/api/show?service=524
      def remove_artist( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeArtist", params )
      end

      # Remove a scrobble from a user's Last.fm library.
      #
      # @option params [String, required] :artist       the artist that composed the album
      # @option params [String, required] :track        the name of the track to remove
      # @option params [String, required] :timestamp    the unix timestamp of the scrobble to remove
      # see: http://www.last.fm/api/show?service=525
      def remove_scrobble( params )
        LastFM.requires_authentication
        # TODO: accept Time objects and convert to unix timestamp
        LastFM.post( "#{TYPE}.removeScrobble", params )
      end

      # Remove a track from a user's Last.fm library.
      #
      # @option params [String, required] :artist   the artist that composed the track
      # @option params [String, required] :track    the name of the track to remove
      # see: http://www.last.fm/api/show?service=526
      def remove_track( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeTrack", params )
      end

    end
  end 
end