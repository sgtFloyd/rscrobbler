module LastFM

  # @attr [LastFM::Album] album
  # @attr [LastFM::Artist, String] artist
  # @attr [Fixnum] duration
  # @attr [Fixnum] id
  # @attr [Hash] images
  # @attr [Fixnum] listeners
  # @attr [String] mbid
  # @attr [String] name
  # @attr [Fixnum] playcount
  # @attr [Fixnum] position
  # @attr [Boolean] streamable
  # @attr [Boolean] streamable_fulltrack
  # @attr [Array] tags
  # @attr [String] url
  # @attr [LastFM::Wii] wiki
  class Track < Struct.new(:album, :artist, :duration, :id, :images, :listeners, :mbid, :name, :playcount, :position, :streamable, :streamable_fulltrack, :tags, :url, :wiki)

    def update_from_node(node)
      case node.name.to_sym
        when :name
          self.name = node.content
        when :id
          self.id = node.content.to_i
        when :duration
          self.duration = node.content.to_i
        when :mbid
          self.mbid = node.content
        when :url
          self.url = node.content
        when :listeners
          self.listeners = node.content.to_i
        when :playcount
          self.playcount = node.content.to_i
        when :streamable
          self.streamable = (node.content == '1')
          self.streamable_fulltrack = (node['fulltrack'] == '1')
        when :image
          self.images ||= {}
          self.images.merge!({node['size'].to_sym => node.content})
        when :artist
          self.artist = (node.find('*').count == 0) ? node.content : LastFM::Artist.from_xml(node)
        when :album
          self.position = node['position'].to_i
          self.album = LastFM::Album.from_xml(node)
        when :toptags
          self.tags = node.find('tag').map do |tag|
            LastFM::Tag.from_xml(tag)
          end
        when :wiki
          self.wiki = LastFM::Wiki.from_xml(node)
      end
    end

    # API Methods
    class << self

      # Add a list of user supplied tags to a track.
      #
      # @option params [String, required] :artist   the artist name
      # @option params [String, required] :track    the track name
      # @option params [Array,  required] :tags     array of tags to apply to this track. accepts a maximum of 10.
      # @see http://www.last.fm/api/show?service=304
      def add_tags( params )
        LastFM.requires_authentication
        LastFM.post( "track.addTags", params )
      end

      # Ban a track for the current user.
      #
      # @option params [String, required] :artist   the artist name
      # @option params [String, required] :track    the track name
      # @see http://www.last.fm/api/show?service=261
      def ban( params )
        LastFM.requires_authentication
        LastFM.post( "track.ban", params )
      end

      # Get a list of buy Links for a track.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :track          the track name
      # @option params [String,  required]              :country        a country name, as defined by ISO 3166-1
      # @option params [String,  optional]              :mbid           the musicbrainz id for the track
      # @option params [Boolean, optional]              :autocorrect    correct misspelled artist and track names to be returned in the response
      # @return [Array<LastFM::Buylink>] collection of links where this track can be bought or downloaded
      # @see http://www.last.fm/api/show?service=431
      def get_buylinks( params )
        xml = LastFM.get( "track.getBuylinks", params )
        [:physical, :download].each_with_object([]) do |type, buylinks|
          xml.find("affiliations/#{type}s/affiliation").each do |buylink|
            buylinks << LastFM::Buylink.from_xml( buylink, :type => type )
          end
        end
      end

      # Use the last.fm corrections data to check whether the supplied track has a correction to a canonical track
      #
      # @option params [String, required] :artist   the artist name to correct
      # @option params [String, required] :track    the track name to correct
      # @see http://www.last.fm/api/show?service=447
      def get_correction( params )
        LastFM.get( "track.getCorrection", params )
      end

      # Retrieve track metadata associated with a fingerprint id generated by the Last.fm Fingerprinter.
      # Returns track elements, along with a 'rank' value between 0 and 1 reflecting the confidence for
      # each match.
      #
      # @option params [String, required] :fingerprint_id   the fingerprint id to look up
      # @see http://www.last.fm/api/show?service=441
      # @see https://github.com/lastfm/Fingerprinter
      # @see http://blog.last.fm/2010/07/09/fingerprint-api-and-app-updated
      def get_fingerprint_metadata( params )
        LastFM.get( "track.getFingerPrintMetadata", params )
      end

      # Get the metadata for a track.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :track          the track name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the track
      # @option params [Boolean, optional]              :autocorrect    correct misspelled artist and track names to be returned in the response
      # @option params [String,  optional]              :username       username whose playcount for, and whether they've loved, this track is to be returned in the reponse
      # @return [LastFM::Track] track constructed from the metadata contained in the response
      # @see http://www.last.fm/api/show?service=356
      def get_info( params )
        xml = LastFM.get( "track.getInfo", params )
        LastFM::Track.from_xml( xml )
      end

      # Get shouts for a track.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :track          the track name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the track
      # @option params [Boolean, optional]              :autocorrect    correct misspelled artist and track names to be returned in the response
      # @option params [Fixnum,  optional]              :page           the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional]              :limit          the number of results to fetch per page. defaults to 50
      # @return [Array<LastFM::Shout>] collection of shouts
      # @see http://www.last.fm/api/show?service=453
      def get_shouts( params )
        xml = LastFM.get( "track.getShouts", params )
        xml.find('shouts/shout').map do |shout|
          LastFM::Shout.from_xml( shout )
        end
      end

      # Get similar tracks for a track on Last.fm, based on listening data.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :track          the track name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the track
      # @option params [Boolean, optional]              :autocorrect    correct misspelled artist and track names to be returned in the response
      # @option params [Fixnum,  optional]              :limit          the number of results to fetch. defaults to 50
      # @return [Array<LastFM::Track>] similar tracks, ordered by similarity
      # @see http://www.last.fm/api/show?service=319
      def get_similar( params )
        xml = LastFM.get( "track.getSimilar", params )
        xml.find('similartracks/track').map do |track|
          LastFM::Track.from_xml( track )
        end
      end

      # Get the tags on a track.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :track          the track name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the track
      # @option params [Boolean, optional]              :autocorrect    correct misspelled artist and track names to be returned in the response
      # @option params [String,  optional]              :user           if called in non-authenticated mode you must specify the user to look up
      # @see http://www.last.fm/api/show?service=320
      def get_tags( params )
        secure = !params.include?(:user)
        LastFM.requires_authentication if secure
        LastFM.post( "track.getTags", params, secure )
      end

      # Get the top fans for a track, based on listening data.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :track          the track name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the track
      # @option params [Boolean, optional]              :autocorrect    correct misspelled artist and track names to be returned in the response
      # @see http://www.last.fm/api/show?service=312
      def get_top_fans( params )
        LastFM.get( "track.getTopFans", params )
      end

      # Get the top fans for a track, ordered by tag count.
      #
      # @option params [String,  required unless :mbid] :artist         the artist name
      # @option params [String,  required unless :mbid] :track          the track name
      # @option params [String,  optional]              :mbid           the musicbrainz id for the track
      # @option params [Boolean, optional]              :autocorrect    correct misspelled artist and track names to be returned in the response
      # @return [Array<LastFM::Tag>] list of tags ordered by popularity
      # @see http://www.last.fm/api/show?service=289
      def get_top_tags( params )
        xml = LastFM.get( "track.getTopTags", params )
        xml.find('toptags/tag').map do |tag|
          LastFM::Tag.from_xml( tag )
        end
      end

      # Love a track for the current user.
      #
      # @option params [String, required] :artist   the artist name
      # @option params [String, required] :track    the track name
      # @see http://www.last.fm/api/show?service=260
      def love( params )
        LastFM.requires_authentication
        LastFM.post( "track.love", params )
      end

      # Remove a user's tag from a track.
      #
      # @option params [String, required] :artist   the artist name
      # @option params [String, required] :track    the track name
      # @option params [String, required] :tag      a single user tag to remove from this track
      # @see http://www.last.fm/api/show?service=316
      def remove_tag( params )
        LastFM.requires_authentication
        LastFM.post( "track.removeTag", params )
      end

      # Used to add a track-play to a user's profile. Scrobble a track, or a batch of tracks.
      # Single tracks may be passed using the Object types listed, batches of tracks must be
      # passed in as Arrays of each Object type. Allows up to a maximum of 50 scrobbles per
      # batch. For batch scrobbles, Array indices of optional parameters must line up with
      # the indicies of their corresponding tracks.
      #
      # @option params [String,  required unless :mbid] :artist           artist name
      # @option params [String,  required unless :mbid] :track            track name
      # @option params [String,  optional]              :mbid             the musicbrainz id for the track
      # @option params [Time,    optional]              :timestamp        time the track started playing
      # @option params [String,  optional]              :album            album name
      # @option params [String,  optional]              :album_artist     album artist, if this differend from the track artist
      # @option params [Fixnum,  optional]              :track_number     track number of the track on the album
      # @option params [Fixnum,  optional]              :duration         track length, in seconds
      # @option params [String,  optional]              :stream_id        track stream id, received from the radio.getPlaylist service
      # @option params [Boolean, optional]              :chosen_by_user   whether or not the user chose the track
      # @option params [String,  optional]              :context          sub-client version (not public, only enabled for certain api keys)
      # @see http://www.last.fm/api/show?service=443
      def scrobble( params )
        LastFM.requires_authentication
        # Tracks are passed to the service using array notation for each of the above params
        array_params = {}
        params.each do |hkey, hval|
          hval = hval.to_i if hval.is_a?(Time)
          Array(hval).each_with_index do |aval, index|
            array_params["#{hkey}[#{index}]"] = aval
          end
        end
        LastFM.post( "track.scrobble", array_params )
      end

      # Search for a track by track name. Returns track matches sorted by relevance.
      #
      # @option params [String, required] :track    the track name
      # @option params [String, optional] :artist   narrow results based on an artist
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @return [Array<LastFM::Track>] list of tracks sorted by relevance
      # @see http://www.last.fm/api/show?service=286
      def search( params )
        xml = LastFM.get( "track.search", params )
        xml.find('results/trackmatches/track').map do |track|
          LastFM::Track.from_xml( track )
        end
      end

      # Share a track twith one or more Last.fm users or other friends.
      #
      # @option params [String,  required] :artist      the artist name
      # @option params [String,  required] :track       the track name
      # @option params [Array,   required] :recipient   a list of email addresses or Last.fm usernames. maximum is 10
      # @option params [String,  optional] :message     an optional message to send. if not supplied a default message will be used
      # @option params [Boolean, optional] :public      optionally show in the sharing users activity feed. defaults to false
      # @see http://www.last.fm/api/show?service=305
      def share( params )
        LastFM.requires_authentication
        LastFM.post( "track.share", params )
      end

      # Unban a track for the current user.
      #
      # @option params [String, required] :artist   the artist name
      # @option params [String, required] :track    the track name
      # @see http://www.last.fm/api/show?service=449
      def unban( params )
        LastFM.requires_authentication
        LastFM.post( "track.unban", params )
      end

      # Unlove a track for the current user.
      #
      # @option params [String, required] :artist   the artist name
      # @option params [String, required] :track    the track name
      # @see http://www.last.fm/api/show?service=440
      def unlove( params )
        LastFM.requires_authentication
        LastFM.post( "track.unlove", params )
      end

      # Used to notify Last.fm that a user has started listening to a track.
      #
      # @option params [String,  required unless :mbid] :artist           artist name
      # @option params [String,  required unless :mbid] :track            track name
      # @option params [String,  optional]              :mbid             the musicbrainz id for the track
      # @option params [String,  optional]              :album            album name
      # @option params [String,  optional]              :album_artist     album artist, if this differend from the track artist
      # @option params [Fixnum,  optional]              :track_number     track number of the track on the album
      # @option params [Fixnum,  optional]              :duration         track length, in seconds
      # @option params [String,  optional]              :context          sub-client version (not public, only enabled for certain api keys)
      # @see http://www.last.fm/api/show?service=454
      def update_now_playing( params )
        LastFM.requires_authentication
        LastFM.post( "track.updateNowPlaying", params )
      end

    end
  end
end
