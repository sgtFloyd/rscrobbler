module LastFM

  # @attr [String]  name
  # @attr [Fixnum]  count
  # @attr [String]  url
  # @attr [Fixnum]  reach
  # @attr [Fixnum]  taggings
  # @attr [Boolean] streamable
  # @attr [Wiki]    wiki
  class Tag < Struct.new(:name, :count, :url, :reach, :taggings, :streamable, :wiki)
    class << self

      # Rules on identifying XML nodes as belonging to an attribute, and
      # how to convert its contents to meaningful data.
      #
      # @param [LibXML::XML::Node] node   XML node to inspect and convert
      # @return [Hash]  hash containing the associated attribute, and the node's converted contents
      def attr_from_node(node)
        attr = node.name.to_sym
        case attr
          when :name, :url
            { attr => node.content.to_s }
          when :count, :reach, :taggings
            { attr => node.content.to_i }
          when :streamable
            { attr => (node.content.to_s == '1')}
          when :wiki
            { attr => LastFM::Wiki.from_node(node) }
          else
            {}
        end
      end

      # Get the metadata for a tag.
      #
      # @option params [String, required] :tag    the tag name
      # @option params [String, optional] :lang   the language to return the summary in, expressed as an ISO 639 alpha-2 code
      # @see http://www.last.fm/api/show?service=452
      def get_info( params )
        xml = LastFM.get( "#{package}.getInfo", params )
        LastFM::Tag.from_xml(xml)
      end

      # Search for tags similar to this one. Returns tags ranked by similarity, based on listening data.
      #
      # @option params [String, required] tag   the tag name
      # @see http://www.last.fm/api/show?service=311
      def get_similar( params )
        LastFM.get( "#{package}.getSimilar", params )
      end

      # Get the top albums tagged with a tag, ordered by tag count.
      #
      # @option params [String, required] :tag      the tag name
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=283
      def get_top_albums( params )
        LastFM.get( "#{package}.getTopAlbums", params )
      end

      # Get the top artists tagged with a tag, ordered by tag count.
      #
      # @option params [String, required] :tag      the tag name
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=284
      def get_top_artists( params )
        LastFM.get( "#{package}.getTopArtists", params )
      end

      # Fetches the top global tags on Last.fm, sorted by popularity (number of times used).
      #
      # @see http://www.last.fm/api/show?service=276
      def get_top_tags
        LastFM.get( "#{package}.getTopTags" )
      end

      # Get the top tracks tagged with a tag, ordered by tag count.
      #
      # @option params [String, required] :tag      the tag name
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=285
      def get_top_tracks( params )
        LastFM.get( "#{package}.getTopTracks", params )
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
        LastFM.get( "#{package}.getWeeklyArtistChart", params )
      end

      # Get a list of available charts for this tag, expressed as date
      # ranges which can be sent to the chart services.
      #
      # @option params [String, required] :tag    the tag name
      # @see http://www.last.fm/api/show?service=359
      def get_weekly_chart_list( params )
        LastFM.get( "#{package}.getWeeklyChartList", params )
      end

      # Search for a tag by name. Returns matches sorted by relevance.
      #
      # @option params [String, required] :tag      the tag name
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=273
      def search( params )
        LastFM.get( "#{package}.search", params )
      end

    end
  end 
end