module LastFM
  class Tasteometer
    class << self

      TYPE = 'tasteometer'

      # @see http://www.last.fm/api/show?service=258
      def compare( params )
        LastFM.get( "#{TYPE}.compare", !:secure, params )
      end

    end
  end 
end