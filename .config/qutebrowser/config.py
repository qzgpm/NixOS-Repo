# Load autoconfig settings
config.load_autoconfig()

# ----------------------------------------------
# Dark mode setup
# ----------------------------------------------
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'never'
config.set('colors.webpage.darkmode.enabled', False, 'file://*')

# ----------------------------------------------
# Search engines
# ----------------------------------------------
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',  
    '@br': 'https://search.brave.com/search?q={}&source=web',
    '@gg': 'https://www.google.com/search?q={}',
    '@lb': 'https://letterboxd.com/search/?hidden=&q={}',  
    '@yt': 'https://www.youtube.com/results?search_query={}',  
    '@un': 'https://unsplash.com/s?searchKeyword={}',  
    '@op': 'https://www.opensubtitles.org/en/search2?MovieName={}&id=8&action=search&Season=&Episode=&SubSumCD=&Genre=&MovieByteSize=&MovieLanguage=&MovieImdbRatingSign=1&MovieImdbRating=&MovieCountry=&MovieYearSign=1&MovieYear=&MovieFPS=&SubFormat=&SubAddDate=&Uploader=&IDUser=&Translator=&IMDBID=&MovieHash=&IDMovie=',
    '@nix': 'https://search.nixos.org/packages?query={}',
}

# ----------------------------------------------
# Cookies: allow only trusted sites
# ----------------------------------------------
c.content.cookies.accept = 'no-3rdparty'  
for domain in [
    'chatgpt.com',
    'docs.google.com',
    'drive.google.com',
    'github.com',
    'google.com',
    'instagram.com',
    'leetcode.com',
    'letterboxd.com',
    'linkedin.com',
    'mail.google.com',
    'meet.google.com',
    'messages.google.com',
    'myanimelist.net',
    'onlinecourses.nptel.ac.in',
    'open.spotify.com',
    'orteil.dashnet.org',
    'play.picoctf.org',
    'reddit.com',
    'store.epicgames.com',
    'theposterdb.com',
    'web.whatsapp.com',
    'x.com',
    'youtube.com',
]:
    config.set('content.cookies.accept', 'all', f'*://{domain}/*')

# ----------------------------------------------
# Adblocking & privacy
# ----------------------------------------------
c.content.blocking.enabled = True
c.content.blocking.method = 'both'
c.content.blocking.adblock.lists = [
    'https://easylist.to/easylist/easylist.txt',
    'https://easylist.to/easylist/easyprivacy.txt'
]

c.content.dns_prefetch = False
c.content.autoplay = False
c.content.webrtc_ip_handling_policy = 'disable-non-proxied-udp'


# ----------------------------------------------
# Userscripts keybindings
# ----------------------------------------------
# Bitwarden
#config.bind(',p', 'spawn --userscript qute-bitwarden')
