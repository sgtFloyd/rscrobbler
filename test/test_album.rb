require 'test/unit'
load 'lib/rscrobbler.rb'

def check_attributes(model, attrs)
  attrs.each do |attr|
    assert_not_nil model.send(attr), "#{attr} expected to be set."
  end
end

class LastFM::AlbumTest < Test::Unit::TestCase

  def setup
    LastFM.api_key = 'b25b959554ed76058ac220b7b2e0a026'
    @artist = 'Cher'
    @album = 'Believe'
  end

  def test_search
    albums = LastFM::Album.search :album => @album, :limit => 1
    assert_equal 1, albums.size
    assert albums.first.is_a? LastFM::Album
    check_attributes albums.first, [:name, :artist, :id, :url, :images, :streamable, :mbid]
  end

  def test_get_info
    assert_raise LastFM::LastFMError do
      LastFM::Album.get_info :album => @album
    end
    album = LastFM::Album.get_info :artist => @artist, :album => @album
    assert_equal @artist, album.artist
    assert_equal @album, album.name
    assert album.wiki.is_a? LastFM::Wiki
    check_attributes album, [:artist, :id, :images, :listeners, :mbid, :name, :playcount, :release_date, :tags, :tracks, :url, :wiki]
  end

end