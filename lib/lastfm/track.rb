module LastFM
  class Track
    class << self

      TYPE = 'track'

      # @see http://www.last.fm/api/show?service=304
      def add_tags( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addTags", params )
      end

      # @see http://www.last.fm/api/show?service=261
      def ban( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.ban", params )
      end

      # @see http://www.last.fm/api/show?service=431
      def get_buylinks( params )
        LastFM.get( "#{TYPE}.getBuylinks", params )
      end

      # @see http://www.last.fm/api/show?service=447
      def get_correction( params )
        LastFM.get( "#{TYPE}.getCorrection", params )
      end

      # @see http://www.last.fm/api/show?service=441
      def get_fingerprint_metadata( params )
        LastFM.get( "#{TYPE}.getFingerPrintMetadata", params )
      end

      # @see http://www.last.fm/api/show?service=356
      def get_info( params )
        LastFM.get( "#{TYPE}.getInfo", params )
      end

      # @see http://www.last.fm/api/show?service=453
      def get_shouts( params )
        LastFM.get( "#{TYPE}.getShouts", params )
      end

      # @see http://www.last.fm/api/show?service=319
      def get_similar( params )
        LastFM.get( "#{TYPE}.getSimilar", params )
      end

      # @see http://www.last.fm/api/show?service=320
      def get_tags( params )
        secure = !params.include?(:user)
        LastFM.requires_authentication if secure
        LastFM.post( "#{TYPE}.getTags", params )
      end

      # @see http://www.last.fm/api/show?service=312
      def get_top_fans( params )
        LastFM.get( "#{TYPE}.getTopFans", params )
      end

      # @see http://www.last.fm/api/show?service=289
      def get_top_tags( params )
        LastFM.get( "#{TYPE}.getTopTags", params )
      end

      # @see http://www.last.fm/api/show?service=260
      def love( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.love", params )
      end

      # @see http://www.last.fm/api/show?service=316
      def remove_tag( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeTag", params )
      end

      # @see http://www.last.fm/api/show?service=443
      def scrobble( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.scrobble", params )
      end

      # @see http://www.last.fm/api/show?service=286
      def search( params )
        LastFM.get( "#{TYPE}.search", params )
      end

      # @see http://www.last.fm/api/show?service=305
      def share( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.share", params )
      end

      # @see http://www.last.fm/api/show?service=449
      def unban( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.unban", params )
      end

      # @see http://www.last.fm/api/show?service=440
      def unlove( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.unlove", params )
      end

      # @see http://www.last.fm/api/show?service=454
      def update_now_playing( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.updateNowPlaying", params )
      end

    end
  end 
end