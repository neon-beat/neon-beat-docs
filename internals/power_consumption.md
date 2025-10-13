# Buzzer power consumption and battery span

This file is an attempt to document the power consumption of Neon Beat
buzzers, and so the duration we can expect for a buzzer to work until
battery is depleted.

The buzzers are based on small wireless microcontrollers powered by a
lithium battery. To keep a buzzer's cost as low as possible, the batteries
are selected to allow the buzzers to support basic games needs.

# Requirements

- The buzzer must be able to stayed powered and usablefor at least a full game
  - The buzzer must be visible in the main and admin interface
  - the buzzer must allow players to buzz
- A full game is estimated to last at most 2 hours
- It is _accepted_ that buzzers need to be recharged between two games

# Buzzer v1 design

The buzzer used in the Neon Beat has an initial version (called v1) based
on a very simplistic design:
- the main button
- an on/off switch
- a XIAO ESP32C3 module ([1])
- a 320mAh battery ([2])

We assume that with this design, the power consumption of the whole buzzer
is fully due to the ESP32 nominal state, and that a push on the main button
does not increase the power consumption enough to make it considered.
Based on documentation provided by Seeed studio ([3]), we know that:
- the ESP32C3 pulls 74,7mA
- so the buzzer can remain powered during approximately 4h15
- based on initial hypotheses, this allows to play two full games without
  recharging

# Buzzer v2 design

The new revision of the buzzer (called v2) have the same base components,
except that it integrates LEDs to allow players to get feedback when they
buzz. The feedback received by players have different parameters:
- a color
- a pattern: fixed, sine wave, heartbeat, blinking...
- a duration

To cover this new need, the new buzzer integrates RGB leds.
- to last at least one game, considering the buzzer v1 power consumption,
  we have a current budget of 160mAh (half of the battery) for the user
  feedback, or ~80mAh for a two-hours game.
- we can assume that during the two hours:
  - a "very active" user will buzz each song
  - there will be one song per minute
  - lets assume that for each buzzed song:
      - we have one pattern that last around 10s when the song is buzzed
      - we have one pattern that last around 5s when the game admin
        validates/reject the answer
  - the buzzer is then alight 1/4 of the time (15s/1min)
  - we can then consume around 320mA during the alight time, if no current
    leak is observed during the idle time
- We can then select our RGB led configuration:
  - a single color pin can pull between 20mA (nominal) and 10mA (with
    higher resistance to reduce power consumption, to be confirmed that it
    is enough)
  - a RGB LED set white with a fixed pattern then pulls between 40 and 80mA
  - We can then use up to 4 LEDs for high luminosity, or 8 LEDs with lower
    luminosity.

Those computations _heavily_ approximate the current consumption, and
ignores for example the consumption of other components involved in the
LEDs management, depending on the chosen design (LED IC, bare transistors,
esp32 gpio lines...). It is probably safer to use a more pessimistic
design, eg 4 low luminosity LEDs.


[1] https://www.seeedstudio.com/Seeed-XIAO-ESP32C3-p-5431.html
[2] https://www.amazon.fr/dp/B08HD1N273
[3] https://files.seeedstudio.com/wiki/Seeed-Studio-XIAO-ESP32/Low_Power_Consumption.pdf
