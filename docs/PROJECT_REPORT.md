# Project Report

## Project name

Tank Battle

## Project goal

This project is a small HarmonyOS application made with DevEco Studio. It is designed as a simple open source course final work. The app shows a tiny tank battle game and keeps the code easy to understand.

## Main features

The game page contains a 9 x 9 map.

1. The player tank starts at the bottom of the map.
2. The enemy tank starts at the top of the map.
3. Some cells are walls and cannot be crossed.
4. The player can move in four directions.
5. The player can fire in the current facing direction.
6. Hitting the enemy adds 1 score.
7. The player wins when the score reaches 5.
8. The player loses life when the enemy gets close.
9. The game ends when life reaches 0.

## Implementation

The project uses the HarmonyOS Stage model. `EntryAbility` loads the main page, and most game code is written in `Index.ets`.

The page uses several `@State` variables to save the player position, enemy position, direction, score, life, message text and game status. When a button is clicked, the state changes and ArkUI refreshes the screen.

The map is rendered with nested `ForEach` loops. Each cell decides its own text and background color according to the current game state.

## Important files

- `entry/src/main/ets/entryability/EntryAbility.ets`: application entry ability.
- `entry/src/main/ets/pages/Index.ets`: tank battle page, including UI and logic.
- `AppScope/app.json5`: app level configuration.
- `README.md`: basic usage guide.

## Summary

This app is not a large game, but it includes a complete small interaction loop: moving, shooting, scoring, losing life, winning and restarting. It is easy to run and easy to explain in a course demo.
