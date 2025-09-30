```mermaid
stateDiagram-v2
    [*] --> idle

    note right of [*]
        GM: Game Master
    end note
    note left of idle
        Playlist and players management. Visible in admin front
    end note

    idle --> game_running: start_game
    state game_running {
        prep --> playing_game: game_configured
        playing_game --> pause: GM_triggers_pause
        playing_game --> pause: buzz
        pause --> reveal: game_master_triggers_reveal
        pause --> playing_game: game_master_triggers_continue
        reveal --> playing_game: GM_triggers_next
        playing_game --> reveal: GM_triggers_reveal
    }
    game_running --> show_scores: playlist_end_or_GM_stops
    show_scores --> idle: GM_ends_game
```