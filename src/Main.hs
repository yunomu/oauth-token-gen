{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad.IO.Class (liftIO)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BC
import Data.Conduit
import Data.Maybe
import Network.HTTP.Conduit
import Web.Authenticate.OAuth
import System.IO

main :: IO ()
main = runResourceT $ do
    requestUri <- getStr "Input OAuthRequestURI: "
    accessTokenUri <- getStr "Input OAuthAccessTokenUIR: "
    authorizeUri <- getStr "Input OAuthAuthorizeURI: "
    consumerKey <- getStr "Input ConsumerKey: "
    consumerSecret <- getStr "Input ConsumerSecret: "
    let oauth = newOAuth {
            oauthRequestUri = BC.unpack requestUri,
            oauthAccessTokenUri = BC.unpack accessTokenUri,
            oauthAuthorizeUri = BC.unpack authorizeUri,
            oauthConsumerKey = consumerKey,
            oauthConsumerSecret = consumerSecret,
            oauthSignatureMethod = PLAINTEXT}

    manager <- liftIO $ newManager def
    tmpCred <- getTemporaryCredential oauth manager

    liftIO $ putStrLn "Manually authorize via URL: "
    liftIO $ putStrLn $ authorizeUrl oauth tmpCred

    oauthVerifier <- getStr "After authorizing, Input oauth_verifier: "

    let tmpCred' = insert "oauth_verifier" oauthVerifier tmpCred
    credential <- getAccessToken oauth tmpCred' manager

    let unc = unCredential credential
    liftIO $ print $ mkMsg unc "oauth_token"
    liftIO $ print $ mkMsg unc "oauth_token_secret"
  where
    getStr msg = liftIO $ do
        putStr msg
        hFlush stdout
        BS.getLine

    mkMsg unc key = key `BC.append` ": " `BC.append` (fromJust $ lookup key unc)

