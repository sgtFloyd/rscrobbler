module LastFM
  class Album
    class << self

      TYPE = 'album'

      # @see http://www.last.fm/api/show?service=302
      def add_tags( artist, album, tags )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.addTags", 'artist'=>artist, 'album'=>album, 'tags'=>tags )
      end

      # @see http://www.last.fm/api/show?service=429
      def get_buylinks( country, artist = nil, album = nil, mbid = nil, autocorrect = nil )
        raise ArgumentError unless artist && album || mbid
        LastFM.get( "#{TYPE}.getBuylinks", !:secure, 'country'=>country, 'artist'=>artist, 'album'=>album, 'mbid'=>mbid, 'autocorrect'=>autocorrect  )
      end

      # @see http://www.last.fm/api/show?service=290
      def get_info( artist = nil, album = nil, mbid = nil, lang = nil, autocorrect = nil, username = nil )
        raise ArgumentError unless artist && album || mbid
        LastFM.get( "#{TYPE}.getInfo", !:secure, 'artist'=>artist, 'album'=>album, 'mbid'=>mbid, 'lang'=>lang, 'autocorrect'=>autocorrect, 'username'=>username )
      end

      # @see http://www.last.fm/api/show?service=450
      def get_shouts( artist = nil, album = nil, mbid = nil, autocorrect = nil, limit = nil, page = nil )
        raise ArgumentError unless artist && album || mbid
        LastFM.get( "#{TYPE}.getShouts", !:secure, 'artist'=>artist, 'album'=>album, 'mbid'=>mbid, 'autocorrect'=>autocorrect, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=317
      def get_tags( artist = nil, album = nil, mbid = nil, autocorrect = nil )
        raise ArgumentError unless artist && album || mbid
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getTags", :secure, 'artist'=>artist, 'album'=>album, 'mbid'=>mbid, 'autocorrect'=>autocorrect )
      end

      # @see http://www.last.fm/api/show?service=438
      def get_top_tags( artist = nil, album = nil, mbid = nil, autocorrect = nil )
        raise ArgumentError unless artist && album || mbid
        LastFM.get( "#{TYPE}.getTopTags", !:secure, 'artist'=>artist, 'album'=>album, 'mbid'=>mbid, 'autocorrect'=>autocorrect )
      end

      # @see http://www.last.fm/api/show?service=314
      def remove_tag( artist, album, tag )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.removeTag", 'artist'=>artist, 'album'=>album, 'tag'=>tag )
      end

      # @see http://www.last.fm/api/show?service=357
      def search( album, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.search", !:secure, 'album'=>album, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=436
      def share( artist, album, recipient, message = nil, public = nil )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.share", 'artist'=>artist, 'album'=>album, 'recipient'=>recipient, 'message'=>message, 'public'=>public )
      end

    end
  end
end