module LastFM
  class Artist
    class << self

      TYPE = 'artist'

      # @see http://www.last.fm/api/show/?service=303
      def add_tags( artist, tags )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addTags", 'artist'=>artist, 'tags'=>tags )
      end

      # @see http://www.last.fm/api/show/?service=446
      def get_correction( artist )
        LastFM.get( "#{TYPE}.getCorrection", !:secure, 'artist'=>artist )
      end

      # @see http://www.last.fm/api/show/?service=117
      def get_events( artist = nil, mbid = nil, autocorrect = nil, festivals_only = nil, limit = nil, page = nil)
        raise ArgumentError unless artist || mbid
        LastFM.get( "#{TYPE}.getEvents", !:secure, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect, 'festivalsonly'=>festivals_only, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show/?service=407
      def get_images( artist = nil, mbid = nil, autocorrect = nil, order = nil, limit = nil, page = nil )
        raise ArgumentError unless artist || mbid
        LastFM.get( "#{TYPE}.getImages", !:secure, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect, 'order'=>order, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show/?service=267
      def get_info( artist = nil, mbid = nil, lang = nil, autocorrect = nil, username = nil )
        raise ArgumentError unless artist || mbid
        LastFM.get( "#{TYPE}.getInfo", !:secure, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect, 'lang'=>lang, 'username'=>username )
      end

      # @see http://www.last.fm/api/show/?service=428
      def get_past_events( artist = nil, mbid = nil, autocorrect = nil, limit = nil, page = nil )
        raise ArgumentError unless artist || mbid
        LastFM.get( "#{TYPE}.getPastEvents", !:secure, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show/?service=118
      def get_podcast( artist = nil, mbid = nil, autocorrect = nil )
        raise ArgumentError unless artist || mbid
        LastFM.get( "#{TYPE}.getPodcast", !:secure, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect )
      end

      # @see http://www.last.fm/api/show/?service=397
      def get_shouts( artist = nil, mbid = nil, autocorrect = nil, limit = nil, page = nil )
        raise ArgumentError unless artist || mbid
        LastFM.get( "#{TYPE}.getShouts", !:secure, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show/?service=119
      def get_similar( artist = nil, mbid = nil, autocorrect = nil, limit = nil )
        raise ArgumentError unless artist || mbid
        LastFM.get( "#{TYPE}.getSimilar", !:secure, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect, 'limit'=>limit )
      end

      # @see http://www.last.fm/api/show/?service=318
      def get_tags( artist = nil, mbid = nil, autocorrect = nil )
        raise ArgumentError unless artist || mbid
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getTags", :secure, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect )
      end

      # @see http://www.last.fm/api/show/?service=287
      def get_top_albums( artist = nil, mbid = nil, autocorrect = nil, limit = nil, page = nil )
        raise ArgumentError unless artist || mbid
        LastFM.get( "#{TYPE}.getTopAlbums", !:secure, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show/?service=310
      def get_top_fans( artist = nil, mbid = nil, autocorrect = nil )
        raise ArgumentError unless artist || mbid
        LastFM.get( "#{TYPE}.getTopFans", !:secure, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect )
      end

      # @see http://www.last.fm/api/show/?service=288
      def get_top_tags( artist = nil, mbid = nil, autocorrect = nil )
        raise ArgumentError unless artist || mbid
        LastFM.get( "#{TYPE}.getTopTags", !:secure, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect )
      end

      # @see http://www.last.fm/api/show/?service=277
      def get_top_tracks( artist = nil, mbid = nil, autocorrect = nil, limit = nil, page = nil )
        raise ArgumentError unless artist || mbid
        LastFM.get( "#{TYPE}.getTopTracks", !:secure, 'artist'=>artist, 'mbid'=>mbid, 'autocorrect'=>autocorrect, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show/?service=315
      def remove_tag( artist, tag )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeTag", 'artist'=>artist, 'tag'=>tag )
      end

      # @see http://www.last.fm/api/show/?service=272
      def search( artist, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.search", !:secure, 'artist'=>artist, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show/?service=306
      def share( artist, recipient, message = nil, public = nil )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.share", 'artist'=>artist, 'recipient'=>recipient, 'message'=>message, 'public'=>public )
      end

      # @see http://www.last.fm/api/show/?service=408
      def shout( artist, message )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.shout", 'artist'=>artist, 'message'=>message )
      end

    end
  end
end