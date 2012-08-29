OAuth Token Generator
=====================

This command generate access token and secret access token for OAuth from consumer keys.

How to use
----------

exec command:

     % oauth-token-gen
    Input OAuthRequestURI: http://example.com/request_token
    Input OAuthAccessTokenURI: http://example.com/access_token
    Input OAuthAuthorizeURI: http://example.com/authorize
    Input ConsumerKey: xxxxxxxx
    Input ConsumerKeySecret: XXXXXXXXXXXXXXXX
    Manually authorize via URI:
    http://example.com/authorize?oauth_token=xxxxxxxxxxx
    After autorizing, Input oauth_verifier: xxxxx
    oauth_token: xxxxxxxxxxxx
    oauth_token_secret: xxxxxxxxxxxxxxxxxxx
