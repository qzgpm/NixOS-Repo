import sys
from urllib.parse import urlparse, parse_qsl, urlencode, urlunparse

# Read the URL passed from Qutebrowser
url = sys.argv[1]

# Define a list of common tracking parameters to remove
tracking_params = [
    'utm_source', 'utm_medium', 'utm_campaign', 'utm_term', 'utm_content', 'fbclid', 
    'gclid', 'ref', 'referrer', 'affid', 'aff_id', 'tduid', 'pid', 'clickid', 'tracking_id', 
    'product_id', 'redirect', 'sessionid', 'adurl', 'affiliate_id', 'source', 'clickref', 'ga'
]

# Parse the URL
parsed = urlparse(url)
query = parse_qsl(parsed.query)

# Remove the tracking parameters
clean_query = [(k, v) for k, v in query if k not in tracking_params]

# Rebuild the URL
clean_url = urlunparse(parsed._replace(query=urlencode(clean_query)))

# Output the cleaned URL
print(clean_url)
