# Ninjah

This is the PC release of my [XBLIG](https://en.wikipedia.org/wiki/Xbox_Live_Indie_Games) game Ninjah (which is itself a remake of a 2007 freeware version).

## Acknowledgements

- [Monkey-X](https://github.com/blitz-research/monkey) - the programming language used to create the BlitzMax build of this app (and the Xbox version!)
- [JungleIDE](https://lemonbytes.com/legacy/) - the IDE used
- Whoever made the BlitzMax target for Monkey-X, sorry I can't rememberwho that was!

## Notes

I've removed the the sound and music files as the music was licensed and I can't remember which sound effects were licensed as well (you know.. in case anyone actually tries to build this thing)

## Change Log

### 25/10/2012 - v1.1.4

- Music playback now uses memory based streaming of oggs
- which should result no more 2 second pauses between tracks!

### 23/10/2012 - v1.1.3

- Arrow keys can be used for movement (instead of just WASD)
- Credits screen behaving badly

### 18/10/2012 - v1.1.2

- Slightly changed a few levels
- Fixed pause menu button locations
- Swapped Select Level and Play Level button locations
- Added indicator as to the players start position

### 14/10/2012 - v1.1.1

- Made BlitzMax target find the best resolution based on GraphicsModes() available

### 13/10/2012 - v1.1.0

- Added extra particle effects
- Fixed Level Select Back Button Alpha
- Added in game pause menu
- Options screen Back button now saves
- Added gravestones (show where you've died when attempting a level)
- Added subtle coin and level exit animations
- Fixed all mouse references to be VMouseX()/VMouseY()
- Fixed all Resolution references to be VDeviceWidth() and VDeviceHeight()

### 06/10/2012 - v1.0.0

- Initial Beta Release
