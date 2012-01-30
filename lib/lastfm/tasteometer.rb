module LastFM
  class Tasteometer
    class << self

      TYPE = 'tasteometer'

      # Get a Tasteometer score from two inputs, along with a list of shared
      # artists. If the input is a User some additional information is returned.
      #
      # @option params [Array,  required] :types    two types are required for comparison. accepted types are 'user' and 'artists'
      # @option params [Array,  required] :values   values for the corresponding types. accepted values are Last.fm usernames, or arrays of artist names (up to 100 artists)
      # @option params [Fixnum, optional] :limit    how many shared artists to display. default is 5
      # @see http://www.last.fm/api/show?service=258
      def compare( params )
        Array(params.delete(:types)).each_with_index{|val, i| params["type[#{i}]"] = val}
        Array(params.delete(:values)).each_with_index{|val, i| params["value[#{i}]"] = val}
        LastFM.get( "#{TYPE}.compare", params )
      end

      # Get the scores between every user in a group of users, plus shared artists.
      # Cuts off any similarities below a cutoff. Also returns a list of all users
      # in the comparison and a small amount of metadata about each. Can take the
      # list of users from a group, or a users friends.
      #
      # @option params [String, required] :source             what source we're using for the comparison. accepted sources are 'user' and 'group'
      # @option params [String, required] :value              name of the source we're using. should be either a Last.fm username or group name
      # @option params [Float,  optional] :cutoff             the minimum level over which comparisons should be returned. default is 0.2
      # @option params [Fixnum, optional] :connection_limit   the maximum number of connections each user should have. default is 6
      # @see http://www.last.fm/api/show?service=500
      # @deprecated This service has been deprecated and is no longer available
      def compare_group(params)
        LastFM.get( "#{TYPE}.compareGroup", params )
      end

    end
  end 
end