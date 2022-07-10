{-# LANGUAGE OverloadedStrings #-}

module Lib where

import Control.Monad
import Graphics.UI.Threepenny (Config (jsPort), defaultConfig, element, ffi, getBody, on, runFunction, set, startGUI, title, (#), (#+))
import qualified Graphics.UI.Threepenny as UI
import System.Environment (getArgs)
import System.IO (BufferMode (LineBuffering), hSetBuffering, stdout)

main :: IO ()
main = do
  hSetBuffering stdout LineBuffering
  [port] <- getArgs
  startGUI defaultConfig {jsPort = Just $ read port} $ \window -> do
    void $ pure window # set title "Buttons"
    button <- UI.button # set UI.text "Click me!"
    void $ getBody window #+ [element button]
    on UI.click button . const $ element button # set UI.text "I have been clicked!"

    button2 <- UI.button # set UI.text "electron"
    on UI.click button2 . const . runFunction $ ffi "require('electron').dialog.showOpenDialog({})"