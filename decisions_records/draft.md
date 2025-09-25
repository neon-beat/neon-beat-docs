# Neon Beat architecture decision records

## Brief
This document lists the initial decisions for Neon Beat overall features and architectures

## Decisions record

### Features

- The basic songs medium for Neon Beat is based on Youtube Playlist
- Neon Beat manipulates two data entities: Neon Beat playlists, and Youtube
  Playlists.
  - The Neon Beat playlist is the basic data entity
  - The Youtube playlist is a "data backend" of the Neon Beat playlist
  - future versions of Neon Beat may supports different data backends
- One main feature of Neon Beat admin interface is to "import a playlist"
  - as an admin, I can create "a Neon Beat playlist" from the idle admin interface
  - the default way of creating a playlist is to import a Youtube Playlist
  - the "import Youtube playlist" is a "oneshot" process converting a
    youtube playlist URL into a Neon Beat playlist 
  - once a "Neon Beat playlist" is created, I can use it to create a "game"
  - a "game" groups a list of players, a Neon Beat playlist, and a game
    state
- The admin can, during the idle state, modify the attributes of a playlist
  - each song of a Neon Beat playlist has some basic properties
  - those properties must not depend on the data backend used to created
    the playlist
  - the list of basic properties needed for each song is the following
    - some fields appear on the user interface and allow to "give points"
      to a team when they find the relevant field
    - song name (point field)
    - song artist (point field)
    - timestamp at which the song should start
    - metadata 
      - it is a "free field" that is filled by the game master
      - the metadata field is a macro field grouping multiple fields
      - each subfield of the metadata will appear as an extra data on the
        user interface, as "bonus point fields" that can be gained
- The admin can, during the idle state, create a "game"
  -  a "game" state is frequently saved in database
    - if there is a power cut, the whole game can be restored
  - the game contains a list of players
    - players have a unique buzzer, and a name
  - the game contains a playlist
  - the game contains a playlist state
    - the playlist state remembers whether a song has been played or not
- Through the admin interface, admin has basic controls on the game:
  - pause the current song
  - resume the current song
  - add/remove points to a team
  - mark a field as "found"
  - reveal the current song
  - validate/invalidate an answer (mostly to trigger animations and sounds)
- The admin user does not actually need to run the Neon Beat admin
  interface to create a playlist: he can run a Neon Beat Playlist Creator
  app (NBPC)
  - NBPC is a native application running on Windows, with a simple
    graphical interface
  - the interface allows taking a Youtube playlist link
  - it _may_ also allow to list songs to be included to a playlist
    - in this case, the admin must provide at least a song title and song
      artist
    - NBPC selects, in a best-effort mode, the most relevant Youtube video
      to include
  - NBPC allows to save this playlist in a specific file format (eg:
    my_playlist.nbpc)
  - the admin can then open the admin interface in Neon Beat and import
    my_playlist.nbpc to create a new Neon Beat playlist.
  - NBPC allows to reload a .nbpc file
  - NBPC allows to modify basic properties of each song in a Neon Beat
    playlist (cf song properties above)
- While the game is playing, Neon Beat maintains a basic user interface.
  This interface shows at least:
  - all teams
  - each team score
  - a countdown about the remaining time to identify a song
  - the song video clip, once revealed

### Internal details

- Neon Beat internals is centralized in a single hardware platform that
  acts as "Neon Beat Controller"
- The controller hosts all services needed to run Neon Beat games
- Neon Beat controller includes at least the following services
  - a frontend that displays the game state to players, and the admin
    interface
  - a data base that remembers the different components state (game,
    playlist, etc) at any moment
    - the database is a NoSQL DB (MongoDB)
  - a backend that drives the whole Neon Beat state
    - the backend is in Rust
    - it communicates with the frontend
    - it communicates with the buzzers
    - it drives the whole game state
- all Neon Beat controller services are orchestrated as dedicated docker
  containers
- Each team/player uses an actual buzzer to play
- When a player "buzzes", his buzzer lights on
  - the light remains on as long as the game is paused
  - the light goes off whenever the game master hits "next" or "continue"
    in the game interface
- The buzzer may expose a small screen showing the team score
