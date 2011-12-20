module LastFM
  class Tasteometer
    class << self

      TYPE = 'tasteometer'

      # @see http://www.last.fm/api/show?service=258
      def compare( type_1, type_2, value_1, value_2, limit = nil )
        raise ArgumentError unless [ 'user', 'artists', 'myspace' ].include?(type_1) && [ 'user', 'artists', 'myspace' ].include?(type_2)
        LastFM.get( "#{TYPE}.compare", !:secure, 'type1'=>type_1, 'type2'=>type_2, 'value1'=>value_1, 'value2'=>value_2 )
      end

    end
  end 
end