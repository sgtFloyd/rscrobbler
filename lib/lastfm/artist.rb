module LastFM

  # @attr [Hash] images
  # @attr [Fixnum] listeners
  # @attr [String] mbid
  # @attr [String] name
  # @attr [Fixnum] playcount
  # @attr [Array] similar
  # @attr [Boolean] streamable
  # @attr [Array] tags
  # @attr [String]  url
  # @attr [LastFM::Wiki] wiki
  class Artist < Struct.new(:images, :listeners, :match, :mbid, :name, :playcount, :similar, :streamable, :tags, :url, :wiki)

    # API Methods
    class << self

      # Tag an artist with one or more user supplied tags.
      #
      # @option params [String, required] :artist   the artist name
      # @option params [Array, required]  :tags     up to 10 tags to apply to this artist
      # @see http://www.last.fm/api/show/?service=303
      def add_tags( params )
        LastFM.requires_authentication
        LastFM.post( "artist.addTags", params )
      end

      # Check whether the supplied artist has a correction to a canonical artist.
      #
      # @option params [String, required] :artist   the artist name
      # @return [Array<LastFM::Artist>] list of suggestion corrections, in order of similarity
      # @see http://www.last.fm/api/show/?service=446
      def get_correction( params )
        xml = LastFM.get( "artist.getCorrection", params )
        xml.find('corrections/correction/artist').map do |correction|
          LastFM::Artist.from_xml( correction )
        end
      end

      # Get a list of upcoming events for this artist.
      #
      # @option params [String,  required unless :mbid] :artist           the artist name
      # @option params [String,  optional]              :mbid             the musicbrainz id for the artist
      # @option params [Boolean, optional]              :festivalsonly    whether only festivals should be returned, or all events
      # @option params [Boolean, optional]              :autocorrect      transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page             the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit            the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show/?service=117
      def get_events( params )
        xml = LastFM.get( "artist.getEvents", params )
        xml.find('events/event').map do |event|
          LastFM::Event.from_xml( event )
        end
      end

      # Get images for this artist in a variety of sizes.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the artist
      # @option params [Symbol,  optional]              :order          sort ordering can be either :popularity (default) or :dateadded
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page           the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit          the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show/?service=407
      def get_images( params )
        LastFM.get( "artist.getImages", params )
      end

      # Get the metadata for an artist. Includes biography.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the artist
      # @option params [String,  optional]              :lang           the language to return the biography in, expressed as an ISO 639 alpha-2 code
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [String,  optional]              :username       username whose playcount for this artist is to be returned in the reponse
      # @return [LastFM::Artist] artist constructed from the metadata contained in the response
      # @see http://www.last.fm/api/show/?service=267
      def get_info( params )
        xml = LastFM.get( "artist.getInfo", params )
        LastFM::Artist.from_xml( xml )
      end

      # Get a paginated list of all the events this artist has played at in the past.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page           the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit          the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show/?service=428
      def get_past_events( params )
        LastFM.get( "artist.getPastEvents", params )
      end

      # Get a podcast of free mp3s based on an artist.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @see http://www.last.fm/api/show/?service=118
      def get_podcast( params )
        LastFM.get( "artist.getPodcast", params )
      end

      # Get shouts for this artist.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page           the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit          the number of results to fetch per page. defaults to 50
      # @return [Array<LastFM::Shout>] collection of shouts
      # @see http://www.last.fm/api/show/?service=397
      def get_shouts( params )
        xml = LastFM.get( "artist.getShouts", params )
        xml.find('shouts/shout').map do |shout|
          LastFM::Shout.from_xml( shout )
        end
      end

      # Get all the artists similar to this artist.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :limit          limit the number of results to fetch
      # @return [Array<LastFM::Artist>] list of similar artists
      # @see http://www.last.fm/api/show/?service=119
      def get_similar( params )
        xml = LastFM.get( "artist.getSimilar", params )
        xml.find('similarartists/artist').map do |artist|
          LastFM::Artist.from_xml( artist )
        end
      end

      # Get the tags applied by an individual user to an artist on Last.fm. If accessed as an authenticated service
      # and you don't supply a user parameter then this service will return tags for the authenticated user.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [String,  optional]              :user           if called in non-authenticated mode you must specify the user to look up
      # @see http://www.last.fm/api/show/?service=318
      def get_tags( params )
        secure = !params.include?(:user)
        LastFM.requires_authentication if secure
        LastFM.get( "artist.getTags", params, secure )
      end

      # Get the top albums for an artist, ordered by popularity.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page           the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit          the number of results to fetch per page. defaults to 50
      # @return [Array<LastFM::Album>] top albums, ordered by popularity
      # @see http://www.last.fm/api/show/?service=287
      def get_top_albums( params )
        xml = LastFM.get( "artist.getTopAlbums", params )
        xml.find('topalbums/album').map do |album|
          LastFM::Album.from_xml( album )
        end
      end

      # Get the top fans for an artist on Last.fm, based on listening data.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @see http://www.last.fm/api/show/?service=310
      def get_top_fans( params )
        LastFM.get( "artist.getTopFans", params )
      end

      # Get the top tags for an artist, ordered by popularity.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @return [Array<LastFM::Tag>] list of tags ordered by popularity
      # @see http://www.last.fm/api/show/?service=288
      def get_top_tags( params )
        xml = LastFM.get( "artist.getTopTags", params )
        xml.find('toptags/tag').map do |tag|
          LastFM::Tag.from_xml( tag )
        end
      end

      # Get the top tracks by an artist, ordered by popularity.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the artist
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page           the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit          the number of results to fetch per page. defaults to 50
      # @return [Array<LastFM::Track>] top tracks, ordered by popularity
      # @see http://www.last.fm/api/show/?service=277
      def get_top_tracks( params )
        xml = LastFM.get( "artist.getTopTracks", params )
        xml.find('toptracks/track').map do |track|
          LastFM::Track.from_xml( track )
        end
      end

      # Remove a user's tag from an artist.
      #
      # @option params [String, required] :artist   the artist name
      # @option params [String, required] :tag      a single user tag to remove from this artist
      # @see http://www.last.fm/api/show/?service=315
      def remove_tag( params )
        LastFM.requires_authentication
        LastFM.post( "artist.removeTag", params )
      end

      # Search for an artist by name. Returns artist matches sorted by relevance.
      #
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @option params [String, required] :artist   the artist name
      # @return [Array<LastFM::Artist>] list of artists sorted by relevance
      # @see http://www.last.fm/api/show/?service=272
      def search( params )
        xml = LastFM.get( "artist.search", params )
        xml.find('results/artistmatches/artist').map do |artist|
          LastFM::Artist.from_xml( artist )
        end
      end

      # Share an artist with Last.fm users or other friends.
      #
      # @option params [String,  required] :artist      the artist name
      # @option params [Array,   required] :recipient   a list of email addresses or Last.fm usernames. maximum is 10
      # @option params [String,  optional] :message     an optional message to send. if not supplied a default message will be used
      # @option params [Boolean, optional] :public      optionally show in the sharing users activity feed. defaults to false
      # @see http://www.last.fm/api/show/?service=306
      def share( params )
        LastFM.requires_authentication
        LastFM.post( "artist.share", params )
      end

      # Shout in this artist's shoutbox.
      #
      # @option params [String, required] :artist     name of the artist to shout on
      # @option params [String, required] :message    message to post to the shoutbox
      # @see http://www.last.fm/api/show/?service=408
      def shout( params )
        LastFM.requires_authentication
        LastFM.post( "artist.shout", params )
      end

    end

  private

    # Compensate for discrepancies between XML response and model attributes
    alias :image= :images=
    alias :bio= :wiki=

    # node with nested listeners and playcount
    def stats=(node)
      node.find('*').each do |child|
        send(:"#{child.name}=", child)
      end
    end

    def parse_node(member, node)
      case member
      when :images
        (self.images || {}).merge(node['size'].to_sym => node.content)
      when :listeners, :playcount
        node.content.to_i
      when :name, :mbid, :url
        node.content
      when :similar
        node.find('artist').map do |artist|
          LastFM::Artist.from_xml(artist)
        end
      when :streamable
        node.content == '1'
      when :tags
        node.find('tag').map do |tag|
          LastFM::Tag.from_xml(tag)
        end
      when :wiki
        LastFM::Wiki.from_xml(node)
      end
    end

  end
end
