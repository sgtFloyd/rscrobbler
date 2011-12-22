# rscrobbler
Ruby library for wrapping Last.fm API methods as documented: www.last.fm/api

**Getting Started**

Install the gem: https://rubygems.org/gems/rscrobbler

``` gem install rscrobbler ```

Generate your Last.fm auth token:

``` generate_lastfm_auth_token ```


Configure the library with your LastFM credentials:

    include 'rscrobbler'
    LastFM.api_key    = (see: www.last.fm/api/account)
    LastFM.api_secret = (see: www.last.fm/api/account)
    LastFM.username   = (last.fm username)
    LastFM.auth_token = (generated auth token)
    LastFM.authenticate!
*Authentication process will be simplified in a later version.*

Once authenticated, call API methods using the following syntax:

```LastFM::Track.scrobble('Bonfire', 'Childish Gambino', Time.now.to_i)```

See [documentation](http://rubydoc.info/gems/rscrobbler) for detailed parameter information.