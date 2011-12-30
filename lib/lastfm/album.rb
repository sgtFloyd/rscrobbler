module LastFM
  class Album
    class << self

      TYPE = 'album'

      # Tag an album using a list of user supplied tags.
      #
      # @option params [String, required] :artist the artist name
      # @option params [String, required] :album  the album name
      # @option params [Array, required]  :tags   up to 10 tags to apply to this album
      # @see http://www.last.fm/api/show?service=302
      def add_tags( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addTags", params )
      end

      # Get a list of buy links for an album.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  required unless :mbid] :album        the album name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the album
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @option params [String,  optional]              :country      a country name, as defined by ISO 3166-1
      # @see http://www.last.fm/api/show?service=429
      def get_buylinks( params )
        LastFM.get( "#{TYPE}.getBuylinks", !:secure, params )
      end

      # Get the metadata for an album.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  required unless :mbid] :album        the album name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the album
      # @option params [String,  optional]              :lang         the language to return the biography in, expressed as an ISO 639 alpha-2 code
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @option params [String,  optional]              :username     username whose playcount for this album is to be returned in the reponse
      # @see http://www.last.fm/api/show?service=290
      def get_info( params )
        LastFM.get( "#{TYPE}.getInfo", !:secure, params )
      end

      # Get shouts for an album.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  required unless :mbid] :album        the album name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the album
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page         the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit        the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=450
      def get_shouts( params )
        LastFM.get( "#{TYPE}.getShouts", !:secure, params )
      end

      # Get the tags applied by an individual user to an album.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  required unless :mbid] :album        the album name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the album
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @option params [String,  optional]              :user         if called in non-authenticated mode you must specify the user to look up
      # @see http://www.last.fm/api/show?service=317
      def get_tags( params )
        LastFM.requires_authentication
        secure = params.include?(:user)
        LastFM.get( "#{TYPE}.getTags", secure, params )
      end

      # Get the top tags for an album, ordered by popularity.
      #
      # @option params [String,  required unless :mbid] :artist       the artist name
      # @option params [String,  required unless :mbid] :album        the album name
      # @option params [String,  optional]              :mbid         the musicbrainz id for the album
      # @option params [Boolean, optional]              :autocorrect  transform misspelled artist names into correct artist names to be returned in the response
      # @see http://www.last.fm/api/show?service=438
      def get_top_tags( params )
        LastFM.get( "#{TYPE}.getTopTags", !:secure, params )
      end

      # Remove a user's tag from an album.
      #
      # @option params [String, required] :artist the artist name
      # @option params [String, required] :album  the album name
      # @option params [String, required] :tag    a single user tag to remove from this album
      # @see http://www.last.fm/api/show?service=314
      def remove_tag( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeTag", params )
      end

      # Search for an album by name. Returns album matches sorted by relevance.
      #
      # @option params [String, required] :album  the album name
      # @option params [Fixnum, optional] :page   the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit  the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=357
      def search( params )
        LastFM.get( "#{TYPE}.search", !:secure, params )
      end

      # Share an album with one or more Last.fm users or other friends.
      #
      # @option params [String,  required] :artist    the artist name
      # @option params [String,  required] :album     the album name
      # @option params [Array,   required] :recipient a list of email addresses or Last.fm usernames. maximum is 10
      # @option params [String,  optional] :message   an optional message to send. if not supplied a default message will be used
      # @option params [Boolean, optional] :public    optionally show in the sharing users activity feed. defaults to false
      # @see http://www.last.fm/api/show?service=436
      def share( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.share", params )
      end

    end
  end
end