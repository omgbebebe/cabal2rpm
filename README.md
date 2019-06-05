# Usage
```sh
cabal2info <name | descr | deps | pkgconf > PATH_TO_CABAL_FILE
```

# Examples
```sh
$ cabal get alsa-core
Unpacking to alsa-core-0.5.0.1/

$ ./cabal2info name alsa-core-0.5.0.1/alsa-core.cabal 
alsa-core-0.5.0.1

$ ./cabal2info descr alsa-core-0.5.0.1/alsa-core.cabal 
This package provides access to ALSA infrastructure,
that is needed by both alsa-seq and alsa-pcm.

$ ./cabal2info deps alsa-core-0.5.0.1/alsa-core.cabal 
extensible-exceptions >=0.1.1 && <0.2
base >=3 && <5

$ ./cabal2info pkgconf alsa-core-0.5.0.1/alsa-core.cabal 
alsa >=1.0.14

$ cabal get xmonad
Unpacking to xmonad-0.15/

$ ./cabal2info name xmonad-0.15/xmonad.cabal 
xmonad-0.15

$ ./cabal2info descr xmonad-0.15/xmonad.cabal 
xmonad is a tiling window manager for X. Windows are arranged
automatically to tile the screen without gaps or overlap, maximising
screen use. All features of the window manager are accessible from the
keyboard: a mouse is strictly optional. xmonad is written and
extensible in Haskell. Custom layout algorithms, and other extensions,
may be written by the user in config files. Layouts are applied
dynamically, and different layouts may be used on each workspace.
Xinerama is fully supported, allowing windows to be tiled on several
screens.

$ ./cabal2info deps xmonad-0.15/xmonad.cabal 
base >=4.9 && <5
X11 >=1.8 && <1.10
containers -any
data-default -any
directory -any
extensible-exceptions -any
filepath -any
mtl -any
process -any
setlocale -any
unix -any
utf8-string >=0.3 && <1.1

$ ./cabal2info pkgconf xmonad-0.15/xmonad.cabal 

```
