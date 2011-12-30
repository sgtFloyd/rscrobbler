module LastFM
  class Artist
    class << self

      TYPE = 'artist'

      # Tag an artist with one or more user supplied tags.
      #
      # @option params [String, required] :artist the artist name
      # @option params [Array, required]  :tags   up to 10 tags to apply to this artist
      # @see http://www.last.fm/api/show/?service=303
      def add_tags( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addTags", params )
      end

      # Check whether the supplied artist has a correction to a canonical artist
      #
      # @option params [String, required] :artist the artist name
      # @see http://www.last.fm/api/show/?service=446
      def get_correction( params )
        LastFM.get( "#{TYPE}.getCorrection", !:secure, params )
      end

      # Get a list of upcoming events for this artist.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the artist
      # @option params [Boolean, optional]              :festivalsonly  whether only festivals should be returned, or all events.
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page           the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit          the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show/?service=117
      def get_events( params )
        LastFM.get( "#{TYPE}.getEvents", !:secure, params )
      end

      # Get images for this artist in a variety of sizes
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the artist
      # @option params [Symbol,  optional]              :order        sort ordering can be either :popularity (default) or :dateadded
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page         the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit        the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show/?service=407
      def get_images( params )
        LastFM.get( "#{TYPE}.getImages", !:secure, params )
      end

      # Get the metadata for an artist. Includes biography.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the artist
      # @option params [String,  optional]              :lang         the language to return the biography in, expressed as an ISO 639 alpha-2 code
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @option params [String,  optional]              :username     username whose playcount for this artist is to be returned in the reponse
      # @see http://www.last.fm/api/show/?service=267
      def get_info( params )
        LastFM.get( "#{TYPE}.getInfo", !:secure, params )
      end

      # Get a paginated list of all the events this artist has played at in the past.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page         the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit        the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show/?service=428
      def get_past_events( params )
        LastFM.get( "#{TYPE}.getPastEvents", !:secure, params )
      end

      # Get a podcast of free mp3s based on an artist
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @see http://www.last.fm/api/show/?service=118
      def get_podcast( params )
        LastFM.get( "#{TYPE}.getPodcast", !:secure, params )
      end

      # Get shouts for this artist.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page         the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit        the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show/?service=397
      def get_shouts( params )
        LastFM.get( "#{TYPE}.getShouts", !:secure, params )
      end

      # Get all the artists similar to this artist.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :limit        limit the number of results to fetch
      # @see http://www.last.fm/api/show/?service=119
      def get_similar( params )
        LastFM.get( "#{TYPE}.getSimilar", !:secure, params )
      end

      # Get the tags applied by an individual user to an artist on Last.fm. If accessed as an authenticated service
      # and you don't supply a user parameter then this service will return tags for the authenticated user.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @option params [String,  optional]              :user         if called in non-authenticated mode you must specify the user to look up
      # @see http://www.last.fm/api/show/?service=318
      def get_tags( params )
        LastFM.requires_authentication
        secure = params.include?(:user)
        LastFM.get( "#{TYPE}.getTags", secure, params )
      end

      # Get the top albums for an artist, ordered by popularity.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page         the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit        the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show/?service=287
      def get_top_albums( params )
        LastFM.get( "#{TYPE}.getTopAlbums", !:secure, params )
      end

      # Get the top fans for an artist on Last.fm, based on listening data.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @see http://www.last.fm/api/show/?service=310
      def get_top_fans( params )
        LastFM.get( "#{TYPE}.getTopFans", !:secure, params )
      end

      # Get the top tags for an artist, ordered by popularity.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @see http://www.last.fm/api/show/?service=288
      def get_top_tags( params )
        LastFM.get( "#{TYPE}.getTopTags", !:secure, params )
      end

      # Get the top tracks by an artist, ordered by popularity.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page         the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit        the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show/?service=277
      def get_top_tracks( params )
        LastFM.get( "#{TYPE}.getTopTracks", !:secure, params )
      end

      # Remove a user's tag from an artist.
      #
      # @option params [String, required] :artist the artist name
      # @option params [String, required] :tag    a single user tag to remove from this artist
      # @see http://www.last.fm/api/show/?service=315
      def remove_tag( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeTag", params )
      end

      # Search for an artist by name. Returns artist matches sorted by relevance.
      #
      # @option params [Fixnum, optional] :page   the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit  the number of results to fetch per page. defaults to 50
      # @option params [String, required] :artist the artist name
      # @see http://www.last.fm/api/show/?service=272
      def search( params )
        LastFM.get( "#{TYPE}.search", !:secure, params )
      end

      # Share an artist with Last.fm users or other friends.
      #
      # @option params [String,  required] :artist    the artist name
      # @option params [Array,   required] :recipient a list of email addresses or Last.fm usernames. maximum is 10
      # @option params [String,  optional] :message   an optional message to send. if not supplied a default message will be used
      # @option params [Boolean, optional] :public    optionally show in the sharing users activity feed. defaults to false
      # @see http://www.last.fm/api/show/?service=306
      def share( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.share", params )
      end

      # Shout in this artist's shoutbox
      #
      # @option params [String, required] :artist   name of the artist to shout on
      # @option params [String, required] :message  message to post to the shoutbox
      # @see http://www.last.fm/api/show/?service=408
      def shout( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.shout", params )
      end

    end
  end
end