module LastFM
  module Api
    class Playlist
      class << self

        # Add a track to a Last.fm user's playlist
        #
        # @option params [String, required] :playlist_id    the id of the playlist (see: User.get_playlists)
        # @option params [String, required] :track          the track name to add to the playlist
        # @option params [String, required] :artist         the artist that corresponds to the track to be added
        # @see http://www.last.fm/api/show?service=337
        def add_track( params )
          LastFM.requires_authentication
          LastFM.post( "playlist.addTrack", params )
        end

        # Create a Last.fm playlist on behalf of a user.
        #
        # @option params [String, optional] :title          title for the playlist
        # @option params [String, optional] :description    description for the playlist
        # @see http://www.last.fm/api/show?service=365
        def create( params )
          LastFM.requires_authentication
          LastFM.post( "playlist.create", params )
        end

        # Fetch XSPF playlists using a lastfm playlist url.
        #
        # @option params [String,  required] :playlist_url    lastfm protocol playlist url (lastfm://playlist/...)
        # @option params [Boolean, optional] :steaming        whether to return mp3 links for song previews
        # @see http://www.last.fm/api/show?service=271
        # @deprecated documentation removed from last.fm/api, but method calls still work
        def fetch( params )
          LastFM.get( "playlist.fetch", params )
        end

      end
    end
  end 
end