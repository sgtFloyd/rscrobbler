module LastFM
  class Track
    class << self

      TYPE = 'track'

      # @see http://www.last.fm/api/show?service=304
      def add_tags( track, artist, tags )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addTags", 'track'=>track, 'artist'=>artist, 'tags'=>tags )
      end

      # @see http://www.last.fm/api/show?service=261
      def ban( track, artist )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.ban", 'track'=>track, 'artist'=>artist )
      end

      # @see http://www.last.fm/api/show?service=431
      def get_buylinks( track = nil, artist = nil, mbid = nil, autocorrect = nil, country = nil )
        raise ArgumentError unless artist && track || mbid
        LastFM.get( "#{TYPE}.getBuylinks", !:secure, 'track'=>track, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect, 'country'=>country )
      end

      # @see http://www.last.fm/api/show?service=447
      def get_correction( track, artist )
        LastFM.get( "#{TYPE}.getCorrection", !:secure, 'track'=>track, 'artist'=>artist )
      end

      # @see http://www.last.fm/api/show?service=441
      def get_fingerprint_metadata( fingerprint_id )
        LastFM.get( "#{TYPE}.getFingerPrintMetadata", !:secure, 'fingerprintid'=>fingerprint_id )
      end

      # @see http://www.last.fm/api/show?service=356
      def get_info( track = nil, artist = nil, mbid = nil, autocorrect = nil, username = nil )
        raise ArgumentError unless artist && track || mbid
        LastFM.get( "#{TYPE}.getInfo", !:secure, 'track'=>track, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect, 'username'=>username )
      end

      # @see http://www.last.fm/api/show?service=453
      def get_shouts( track = nil, artist = nil, mbid = nil, autocorrect = nil, limit = nil, page = nil )
        raise ArgumentError unless artist && track || mbid
        LastFM.get( "#{TYPE}.getShouts", !:secure, 'track'=>track, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=319
      def get_similar( track = nil, artist = nil, mbid = nil, autocorrect = nil, limit = nil )
        raise ArgumentError unless artist && track || mbid
        LastFM.get( "#{TYPE}.getSimilar", !:secure, 'track'=>track, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect, 'limit'=>limit )
      end

      # @see http://www.last.fm/api/show?service=320
      def get_tags( track = nil, artist = nil, mbid = nil, autocorrect = nil )
        raise ArgumentError unless artist && track || mbid
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.getTags", 'track'=>track, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect )
      end

      # @see http://www.last.fm/api/show?service=312
      def get_top_fans( track = nil, artist = nil, mbid = nil, autocorrect = nil )
        raise ArgumentError unless artist && track || mbid
        LastFM.get( "#{TYPE}.getTopFans", !:secure, 'track'=>track, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect )
      end

      # @see http://www.last.fm/api/show?service=289
      def get_top_tags( track = nil, artist = nil, mbid = nil, autocorrect = nil )
        raise ArgumentError unless artist && track || mbid
        LastFM.get( "#{TYPE}.getTopTags", !:secure, 'track'=>track, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect )
      end

      # @see http://www.last.fm/api/show?service=260
      def love( track, artist )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.love", 'track'=>track, 'artist'=>artist )
      end

      # @see http://www.last.fm/api/show?service=316
      def remove_tag( track, artist, tag )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeTag", 'track'=>track, 'artist'=>artist, 'tag'=>tag )
      end

      # @see http://www.last.fm/api/show?service=443
      def scrobble( tracks, artists, timestamps, albums = nil, album_artists = nil, contexts = nil, stream_ids = nil, track_numbers = nil, mbids = nil, durations = nil )
        LastFM.requires_authentication
        # Requires complicated logic & HTTP POST
      end

      # @see http://www.last.fm/api/show?service=286
      def search( track, artist = nil, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.search", !:secure, 'track'=>track, 'artist'=>artist, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=305
      def share( track, artist, recipient, message = nil, public = nil )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.share", 'track'=>track, 'artist'=>artist, 'recipient'=>recipient, 'message'=>message, 'public'=>public )
      end

      # @see http://www.last.fm/api/show?service=449
      def unban( track, artist )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.unban", 'track'=>track, 'artist'=>artist )
      end

      # @see http://www.last.fm/api/show?service=440
      def unlove( track, artist )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.unlove", 'track'=>track, 'artist'=>artist )
      end

      # @see http://www.last.fm/api/show?service=454
      def update_now_playing( track, artist, album = nil, album_artist = nil, context = nil, track_number = nil, mbid = nil, duration = nil )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.updateNowPlaying", 'track'=>track, 'artist'=>artist, 'album'=>album, 'albumArtist'=>album_artist, 'context'=>context, 'trackNumber'=>track_number, 'mbid'=>mbid, 'duration'=>duration )
      end

    end
  end 
end