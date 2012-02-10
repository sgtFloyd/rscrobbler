module LastFM

  # @attr [LastFM::Artist] artist  Album artist metadata
  # @attr [Fixnum] id  Last.fm ID
  # @attr [Hash] images  Album images in :small, :medium, :large, :extralarge, and :mega sizes
  # @attr [Fixnum] listeners  Listener count at the time of creation
  # @attr [String] mbid  MusicBrainz ID
  # @attr [String] name  Album title
  # @attr [Fixnum] playcount  Total album playcount at the time of creation
  # @attr [Time] release_date  Album release date
  # @attr [Boolean] streamable
  # @attr [Array] tags  Album's top tags as a collection of LastFM::Tag objects
  # @attr [Array] tracks  Album tracks as a collection of LastFM::Track objects
  # @attr [String] url  Last.fm album url
  # @attr [LastFM::Wiki] wiki  Album information as a LastFM::Wiki object
  class Album < Struct.new(:artist, :id, :images, :listeners, :mbid, :name, :playcount, :release_date, :streamable, :tags, :tracks, :url, :wiki)

    def update_from_node(node)
      case node.name.to_sym
        when :name, :title
          self.name = node.content
        when :artist
          self.artist = node.content
        when :id
          self.id = node.content.to_i
        when :mbid
          self.mbid = node.content
        when :url
          self.url = node.content
        when :releasedate
          self.release_date = Time.parse(node.content)
        when :image
          self.images ||= {}
          self.images.merge!({node['size'].to_sym => node.content})
        when :listeners
          self.listeners = node.content.to_i
        when :playcount
          self.playcount = node.content.to_i
        when :streamable
          self.streamable = (node.content == '1')
        when :tracks
          self.tracks = node.find('track').map do |track|
            LastFM::Track.from_xml(track, :position => track['rank'].to_i)
          end
        when :toptags
          self.tags = node.find('tag').map do |tag|
            LastFM::Tag.from_xml(tag)
          end
        when :wiki
          self.wiki = LastFM::Wiki.from_xml(node)
      end
    end

    class << self

      # Tag an album using a list of user supplied tags.
      #
      # @option params [String, required] :artist the artist name
      # @option params [String, required] :album  the album name
      # @option params [Array, required]  :tags   up to 10 tags to apply to this album
      # @see http://www.last.fm/api/show?service=302
      def add_tags( params )
        LastFM.requires_authentication
        LastFM.post( "#{package}.addTags", params )
      end

      # Get a list of buy links for an album.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :album          the album name
      # @option params [String,  required]              :country        a country name, as defined by ISO 3166-1
      # @option params [String,  optional]              :mbid           the musicbrainz id for the album
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @see http://www.last.fm/api/show?service=429
      def get_buylinks( params )
        LastFM.get( "#{package}.getBuylinks", params )
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
        xml = LastFM.get( "#{package}.getInfo", params )
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
      # @see http://www.last.fm/api/show?service=450
      def get_shouts( params )
        LastFM.get( "#{package}.getShouts", params )
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
        LastFM.get( "#{package}.getTags", params, secure )
      end

      # Get the top tags for an album, ordered by popularity.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :album          the album name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the album
      # @option params [Boolean, optional]              :autocorrect    transform misspelled artist names into correct artist names to be returned in the response
      # @see http://www.last.fm/api/show?service=438
      def get_top_tags( params )
        LastFM.get( "#{package}.getTopTags", params )
      end

      # Remove a user's tag from an album.
      #
      # @option params [String, required] :artist   the artist name
      # @option params [String, required] :album    the album name
      # @option params [String, required] :tag      a single user tag to remove from this album
      # @see http://www.last.fm/api/show?service=314
      def remove_tag( params )
        LastFM.requires_authentication
        LastFM.post( "#{package}.removeTag", params )
      end

      # Search for an album by name. Returns album matches sorted by relevance.
      #
      # @option params [String, required] :album    the album name
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=357
      def search( params )
        xml = LastFM.get( "#{package}.search", params )
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
        LastFM.post( "#{package}.share", params )
      end

    end
  end
end