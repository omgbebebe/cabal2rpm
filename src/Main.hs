module Main where

import Data.Maybe
import Data.List (intercalate)
import Distribution.Compiler
import Distribution.PackageDescription.PrettyPrint
import Distribution.PackageDescription.Parsec
import Distribution.Pretty
import Distribution.Types.BuildInfo
import Distribution.Types.CondTree
import Distribution.Types.Dependency
import Distribution.Types.GenericPackageDescription
import Distribution.Types.Library
import Distribution.Types.PackageDescription
import Distribution.Types.PackageName
import Distribution.Types.Version
import Distribution.Types.VersionRange
import Distribution.System
import Distribution.Verbosity
import System.Environment (getArgs)

data PkgInfo = PI { ver :: String
                  , descr :: String
                  , deps :: [String]
                  , pkgconf :: [String]
                  , libs :: [String]
                  }
  deriving (Eq, Show)

defOS = Linux
defArch = X86_64
defComp :: (CompilerFlavor, Version)
defComp = (GHC, mkVersion [8,6,3])

main :: IO ()
main = do
  [mode, fname] <- getArgs
  d <- readGenericPackageDescription normal fname
  let pinfo = parseDeps d
  case mode of
    "name" -> putStrLn $ ver pinfo
    "descr" -> putStrLn $ descr pinfo
    "deps"  -> putStrLn $ intercalate "\n" $ deps pinfo
    "pkgconf" -> putStrLn $ intercalate "\n" $ pkgconf pinfo
    "libs" -> putStrLn $ intercalate "\n" $ libs pinfo

defTree :: (Monoid d, Monoid a) => CondTree ConfVar d a -> [Flag] -> (d, a)
defTree t fs = simplifyCondTree toDef t
  where toDef cv = case cv of
                     OS x -> Right $ x == defOS
                     Arch x -> Right $ x == defArch
                     Flag x -> Right $ defFlag x
                     Impl c v -> Right $ (c == (fst defComp)) && withinRange (snd defComp) v
        defFlag x = fromMaybe False $ lookup x $ map (\f -> (flagName f, flagDefault f)) fs

parseDeps :: GenericPackageDescription -> PkgInfo
parseDeps d =
  let pd = packageDescription d
      flags = genPackageFlags d
      dt = defTree (fromJust . condLibrary $ d) flags
      deps' = map prettyShow $ fst dt
      pkgconf' = map prettyShow $ pkgconfigDepends . libBuildInfo . snd $ dt
      libs' = extraLibs . libBuildInfo . snd $ dt
  in
  PI {ver = prettyShow (package pd)
     ,descr = description pd
     ,deps = deps'
     ,pkgconf = pkgconf'
     ,libs = libs'
     }
