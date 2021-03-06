module LastFM

  # @attr [LastFM::Artist, String] artist
  # @attr [Fixnum] id
  # @attr [Hash] images
  # @attr [Fixnum] listeners
  # @attr [String] mbid
  # @attr [String] name
  # @attr [Fixnum] playcount
  # @attr [Time] release_date
  # @attr [Boolean] streamable
  # @attr [Array<LastFM::Tag>] tags
  # @attr [Array<LastFM::Track>] tracks
  # @attr [String] url
  # @attr [LastFM::Wiki] wiki
  class Album < Struct.new(:artist, :id, :images, :listeners, :mbid, :name, :playcount, :release_date, :streamable, :tags, :tracks, :url, :wiki)

    # API Methods
    class << self

      # Tag an album using a list of user supplied tags.
      #
      # @option params [String, required] :artist the artist name
      # @option params [String, required] :album  the album name
      # @option params [Array, required]  :tags   up to 10 tags to apply to this album
      # @see http://www.last.fm/api/show?service=302
      def add_tags( params )
        LastFM.requires_authentication
        LastFM.post( "album.addTags", params )
      end

      # Get a list of buy links for an album.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :album          the album name
      # @option params [String,  required]              :country        a country name, as defined by ISO 3166-1
      # @option params [String,  optional]              :mbid           the musicbrainz id for the album
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @return [Array<LastFM::Buylink>] collection of links where this album can be bought or downloaded
      # @see http://www.last.fm/api/show?service=429
      def get_buylinks( params )
        xml = LastFM.get( "album.getBuylinks", params )
        [:physical, :download].each_with_object([]) do |type, buylinks|
          xml.find("affiliations/#{type}s/affiliation").each do |buylink|
            buylinks << LastFM::Buylink.from_xml( buylink, :type => type )
          end
        end
      end

      # Get the metadata for an album.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :album          the album name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the album
      # @option params [String,  optional]              :lang           the language to return the biography in, expressed as an ISO 639 alpha-2 code
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [String,  optional]              :username       username whose playcount for this album is to be returned in the reponse
      # @return [LastFM::Album] album constructed from the metadata contained in the response
      # @see http://www.last.fm/api/show?service=290
      def get_info( params )
        xml = LastFM.get( "album.getInfo", params )
        LastFM::Album.from_xml( xml )
      end

      # Get shouts for an album.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :album          the album name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the album
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page           the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit          the number of results to fetch per page. defaults to 50
      # @return [Array<LastFM::Shout>] collection of shouts
      # @see http://www.last.fm/api/show?service=450
      def get_shouts( params )
        xml = LastFM.get( "album.getShouts", params )
        xml.find('shouts/shout').map do |shout|
          LastFM::Shout.from_xml( shout )
        end
      end

      # Get the tags applied by an individual user to an album.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :album          the album name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the album
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [String,  optional]              :user           if called in non-authenticated mode you must specify the user to look up
      # @see http://www.last.fm/api/show?service=317
      def get_tags( params )
        secure = !params.include?(:user)
        LastFM.requires_authentication if secure
        xml = LastFM.get( "album.getTags", params, secure )
        xml.find('tags/tag').map do |tag|
          LastFM::Tag.from_xml( tag )
        end
      end

      # Get the top tags for an album, ordered by popularity.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :album          the album name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the album
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @return [Array<LastFM::Tag>] list of tags sorted by popularity
      # @see http://www.last.fm/api/show?service=438
      def get_top_tags( params )
        xml = LastFM.get( "album.getTopTags", params )
        xml.find('toptags/tag').map do |tag|
          LastFM::Tag.from_xml( tag )
        end
      end

      # Remove a user's tag from an album.
      #
      # @option params [String, required] :artist   the artist name
      # @option params [String, required] :album    the album name
      # @option params [String, required] :tag      a single user tag to remove from this album
      # @see http://www.last.fm/api/show?service=314
      def remove_tag( params )
        LastFM.requires_authentication
        LastFM.post( "album.removeTag", params )
      end

      # Search for an album by name. Returns album matches sorted by relevance.
      #
      # @option params [String, required] :album    the album name
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @return [Array<LastFM::Album>] list of albums sorted by relevance
      # @see http://www.last.fm/api/show?service=357
      def search( params )
        xml = LastFM.get( "album.search", params )
        xml.find('results/albummatches/album').map do |album|
          LastFM::Album.from_xml( album )
        end
      end

      # Share an album with one or more Last.fm users or other friends.
      #
      # @option params [String,  required] :artist      the artist name
      # @option params [String,  required] :album       the album name
      # @option params [Array,   required] :recipient   a list of email addresses or Last.fm usernames. maximum is 10
      # @option params [String,  optional] :message     an optional message to send. if not supplied a default message will be used
      # @option params [Boolean, optional] :public      optionally show in the sharing users activity feed. defaults to false
      # @see http://www.last.fm/api/show?service=436
      def share( params )
        LastFM.requires_authentication
        LastFM.post( "album.share", params )
      end

    end

  private

    # Compensate for discrepancies between XML response and model attributes
    alias :image= :images=
    alias :title= :name=
    alias :releasedate= :release_date=
    alias :toptags= :tags=

    def parse_node(member, node)
      case member
      when :artist
        if node.find('*').count == 0
          node.content
        else
          LastFM::Artist.from_xml(node)
        end
      when :id, :listeners, :playcount
        node.content.to_i
      when :images
        (self.images || {}).merge(node['size'].to_sym => node.content)
      when :mbid, :name, :url
        node.content
      when :release_date
        Time.parse(node.content) rescue nil
      when :streamable
        node.content == '1'
      when :tags
        node.find('tag').map do |tag|
          LastFM::Tag.from_xml(tag)
        end
      when :tracks
        node.find('track').map do |track|
          LastFM::Track.from_xml(track,
            :album => self.name,
            :position => track['rank'].to_i
          )
        end
      when :wiki
        LastFM::Wiki.from_xml(node)
      end
    end

  end
end
