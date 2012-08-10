module LastFM

  # @attr [String] name
  # @attr [Fixnum] count
  # @attr [String] url
  # @attr [Fixnum] reach
  # @attr [Boolean] streamable
  # @attr [LastFM::Wiki] wiki
  class Tag < Struct.new(:name, :count, :url, :reach, :streamable, :wiki)

    def update_from_node(node)
      case node.name.to_sym
        when :name
          self.name = node.content
        when :url
          self.url = node.content
        when :reach
          self.reach = node.content.to_i
        when :count, :taggings
          self.count = node.content.to_i
        when :streamable
          self.streamable = (node.content == '1')
        when :wiki
          self.wiki = LastFM::Wiki.from_xml(node)
      end
    end

    # API Methods
    class << self

      # Get the metadata for a tag.
      #
      # @option params [String, required] :tag    the tag name
      # @option params [String, optional] :lang   the language to return the summary in, expressed as an ISO 639 alpha-2 code
      # @return [LastFM::Tag] tag constructed from the metadata contained in the response
      # @see http://www.last.fm/api/show?service=452
      def get_info( params )
        xml = LastFM.get( "tag.getInfo", params )
        LastFM::Tag.from_xml( xml )
      end

      # Search for tags similar to this one. Returns tags ranked by similarity, based on listening data.
      #
      # @option params [String, required] tag   the tag name
      # @return [Array<LastFM::Tag>] similar tags, ordered by similarity
      # @see http://www.last.fm/api/show?service=311
      def get_similar( params )
        xml = LastFM.get( "tag.getSimilar", params )
        xml.find('similartags/tag').map do |tag|
          LastFM::Tag.from_xml( tag )
        end
      end

      # Get the top albums tagged with a tag, ordered by tag count.
      #
      # @option params [String, required] :tag      the tag name
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @return [Array[LastFM::Album]] list of albums, ordered by tag count
      # @see http://www.last.fm/api/show?service=283
      def get_top_albums( params )
        xml = LastFM.get( "tag.getTopAlbums", params )
        xml.find('topalbums/album').map do |album|
          LastFM::Album.from_xml( album )
        end
      end

      # Get the top artists tagged with a tag, ordered by tag count.
      #
      # @option params [String, required] :tag      the tag name
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @return [Array[LastFM::Artist]] list of artists, ordered by tag count
      # @see http://www.last.fm/api/show?service=284
      def get_top_artists( params )
        xml = LastFM.get( "tag.getTopArtists", params )
        xml.find('topartists/artist').map do |artist|
          LastFM::Artist.from_xml( artist )
        end
      end

      # Fetches the top global tags on Last.fm, sorted by popularity (number of times used).
      #
      # @return [Array<LastFM::Tag>] list of tags ordered by popularity
      # @see http://www.last.fm/api/show?service=276
      def get_top_tags
        xml = LastFM.get( "tag.getTopTags" )
        xml.find('toptags/tag').map do |tag|
          LastFM::Tag.from_xml( tag )
        end
      end

      # Get the top tracks tagged with a tag, ordered by tag count.
      #
      # @option params [String, required] :tag      the tag name
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @return [Array[LastFM::Track]] list of tracks, ordered by tag count
      # @see http://www.last.fm/api/show?service=285
      def get_top_tracks( params )
        xml = LastFM.get( "tag.getTopTracks", params )
        xml.find('toptracks/track').map do |track|
          LastFM::Track.from_xml( track )
        end
      end

      # Get an artist chart for a tag, for a given date range. If no date range is
      # supplied, it will return the most recent artist chart for this tag.
      #
      # @option params [String, required] :tag      the tag name
      # @option params [String, optional] :from     date at which the chart should start from (see: Tag.get_weekly_chart_list)
      # @option params [String, optional] :to       date at which the chart should end on (see: Tag.get_weekly_chart_list)
      # @option params [Fixnum, optional] :limit    the number of results to fetch. defaults to 50
      # @see http://www.last.fm/api/show?service=358
      def get_weekly_artist_chart( params )
        LastFM.get( "tag.getWeeklyArtistChart", params )
      end

      # Get a list of available charts for this tag, expressed as date
      # ranges which can be sent to the chart services.
      #
      # @option params [String, required] :tag    the tag name
      # @see http://www.last.fm/api/show?service=359
      def get_weekly_chart_list( params )
        LastFM.get( "tag.getWeeklyChartList", params )
      end

      # Search for a tag by name. Returns matches sorted by relevance.
      #
      # @option params [String, required] :tag      the tag name
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @return [Array<LastFM::Tag>] list of tags sorted by relevance
      # @see http://www.last.fm/api/show?service=273
      def search( params )
        xml = LastFM.get( "tag.search", params )
        xml.find('results/tagmatches/tag').map do |tag|
          LastFM::Tag.from_xml( tag )
        end
      end

    end
  end
end
