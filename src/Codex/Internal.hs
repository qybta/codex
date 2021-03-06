module Codex.Internal where

import Control.Arrow
import Distribution.Package
import Distribution.Text
import Distribution.Verbosity
import System.FilePath

data Codex = Codex { tagsCmd :: String, hackagePath :: FilePath }

packagePath :: Codex -> PackageIdentifier -> FilePath
packagePath cx i = joinPath [hackagePath cx, relativePath i] where
  relativePath i = joinPath [name, version] where
    name = display $ pkgName i
    version = display $ pkgVersion i

packageArchive :: Codex -> PackageIdentifier -> FilePath
packageArchive cx i = joinPath [packagePath cx i, name] where
  name = concat [display $ pkgName i, "-", display $ pkgVersion i, ".tar.gz"]

packageSources :: Codex -> PackageIdentifier -> FilePath
packageSources cx i = joinPath [packagePath cx i, name] where
  name = concat [display $ pkgName i, "-", display $ pkgVersion i]

packageTags :: Codex -> PackageIdentifier -> FilePath
packageTags cx i = joinPath [packagePath cx i, "tags"]

packageUrl :: PackageIdentifier -> String
packageUrl i = concat ["http://hackage.haskell.org/package/", path] where
  path = concat [name, "/", name, ".tar.gz"]
  name = concat [display $ pkgName i, "-", display $ pkgVersion i]

