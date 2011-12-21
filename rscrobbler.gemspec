require './lib/rscrobbler'

Gem::Specification.new do |s|
  s.name    = "rscrobbler"
  s.version = LastFM::VERSION
  s.summary = "Last.fm API wrapper"

  s.authors     = ["Gabe Smith"]
  s.email       = ["sgt.floydpepper@gmail.com"]
  s.date        = Time.now.strftime "%Y-%m-%d"
  s.homepage    = "https://github.com/sgtFloyd/rscrobbler"
  s.description = "rscrobbler is a Ruby gem for accessing Last.fm's API (http://www.last.fm/api)."

  s.require_paths = ["lib"]
  s.files         = Dir['lib/**/*.rb']
  s.test_files    = Dir['test/**/*.rb']
  s.executables   = Dir['bin/**/*'].map{|f| File.basename(f)}

  s.add_dependency "libxml-ruby"
end