# rscrobbler
Ruby library for wrapping Last.fm API methods as documented: www.last.fm/api

**Getting Started**

Install the gem: https://rubygems.org/gems/rscrobbler

```gem install rscrobbler```

Configure the library with your LastFM credentials:

    include 'rscrobbler'
    LastFM.api_key    = (see: www.last.fm/api/account)
    LastFM.api_secret = (see: www.last.fm/api/account)
    LastFM.username   = (last.fm login username)
    LastFM.generate_auth_token  (last.fm login password)
    LastFM.authenticate!
*Authentication process will be simplified in a later version.*

Once authenticated, call API methods using the following syntax:

```LastFM::Track.scrobble('Bonfire', 'Childish Gambino', Time.now.to_i)```

See documentation for detailed parameter information.