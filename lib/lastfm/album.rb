module LastFM

  # @attr [String] name         Album title
  # @attr [String] artist       Album artist name
  # @attr [Fixnum] id           Last.fm ID
  # @attr [String] mbid         MusicBrainz ID
  # @attr [String] url          Last.fm album url
  # @attr [Time]   releasedate  Album release date
  # @attr [Hash]   images       Album images in :small, :medium, :large, :extralarge, and :mega sizes
  # @attr [Fixnum] listeners    Listener count at the time of creation
  # @attr [Fixnum] playcount    Total album playcount at the time of creation
  # @attr [Array]  tracks       Album tracks as a collection of LastFM::Track objects
  # @attr [Array]  tags         Album tags as a collection of LastFM::Tag objects
  # @attr [Wiki]   wiki         Album information as a LastFM::Wiki object
  class Album < Struct.new(:name, :artist, :id, :mbid, :url, :releasedate, :images, :listeners, :playcount, :tracks, :tags, :wiki)
    class << self
      TYPE = 'album'

      # Construct a LastFM::Album object from given XML, using as many attributes as possible.
      #
      # @param [LibXML::XML::Document] xml  XML obtained from a Last.fm API call
      # @return [LastFM::Album] object contructed from attributes contained in XML
      def from_xml(xml)
        attributes = {}

        # String attributes don't need to be modified
        [:name, :artist, :mbid, :url].each{ |field|
          node = xml.find_first("#{TYPE}/#{field}")
          attributes[field] = node.content if node
        }

        # Fixnum attributes need to be explicitly cast
        [:id, :listeners, :playcount].each{ |field|
          node = xml.find_first("#{TYPE}/#{field}")
          attributes[field] = node.content.to_i if node
        }

        # Parse releasedate with Time
        date_node = xml.find_first("#{TYPE}/releasedate")
        attributes[:releasedate] = Time.parse(date_node.content) if date_node

        # Collect images with their sizes
        images = {}
        xml.find("#{TYPE}/image").each{ |image|
          size = image.attributes[:size]
          images[size.to_sym] = image.content
        }
        attributes[:images] = images

        wiki_node = xml.find_first("#{TYPE}/wiki")
        attributes[:wiki] = LastFM::Wiki.from_node(wiki_node) if wiki_node

        self.new(attributes)
      end

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
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :album          the album name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the album
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [String,  optional]              :country        a country name, as defined by ISO 3166-1
      # @see http://www.last.fm/api/show?service=429
      def get_buylinks( params )
        LastFM.get( "#{TYPE}.getBuylinks", params )
      end

      # Get the metadata for an album.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :album          the album name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the album
      # @option params [String,  optional]              :lang           the language to return the biography in, expressed as an ISO 639 alpha-2 code
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [String,  optional]              :username       username whose playcount for this album is to be returned in the reponse
      # @see http://www.last.fm/api/show?service=290
      def get_info( params )
        xml = LastFM.get( "#{TYPE}.getInfo", params )
        LastFM::Album.from_xml(xml)
      end

      # Get shouts for an album.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :album          the album name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the album
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @option params [Fixnum,  optional]              :page           the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit          the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=450
      def get_shouts( params )
        LastFM.get( "#{TYPE}.getShouts", params )
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
        LastFM.get( "#{TYPE}.getTags", params, secure )
      end

      # Get the top tags for an album, ordered by popularity.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :album          the album name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the album
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @see http://www.last.fm/api/show?service=438
      def get_top_tags( params )
        LastFM.get( "#{TYPE}.getTopTags", params )
      end

      # Remove a user's tag from an album.
      #
      # @option params [String, required] :artist   the artist name
      # @option params [String, required] :album    the album name
      # @option params [String, required] :tag      a single user tag to remove from this album
      # @see http://www.last.fm/api/show?service=314
      def remove_tag( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeTag", params )
      end

      # Search for an album by name. Returns album matches sorted by relevance.
      #
      # @option params [String, required] :album    the album name
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=357
      def search( params )
        LastFM.get( "#{TYPE}.search", params )
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
        LastFM.post( "#{TYPE}.share", params )
      end

    end
  end
end