# 25307186-opensource-final-work

This is a small HarmonyOS app made with DevEco Studio. The app is a simple **Tank Battle** mini game.

## What it does

The game is intentionally simple and suitable for a course final project demo:

- A 9 x 9 map is shown on the screen.
- `P` means the player tank.
- `E` means the enemy tank.
- `#` means a wall block.
- Use the buttons to move up, down, left and right.
- Press `FIRE` to shoot in the current direction.
- Hit the enemy tank to gain 1 point. Reach 5 points to win.
- If the enemy tank gets too close, the player loses 1 life.
- The game is over when life becomes 0.

## Tech stack

- DevEco Studio
- HarmonyOS Stage model
- ArkTS
- ArkUI declarative UI

## Project structure

```text
.
|-- AppScope/                         # app level config and resources
|-- entry/                            # main module
|   |-- src/main/ets/entryability/    # ability entry
|   |-- src/main/ets/pages/           # game page
|   `-- src/main/resources/           # module resources
|-- build-profile.json5
|-- hvigorfile.ts
`-- oh-package.json5
```

## How to run

1. Open this folder in DevEco Studio.
2. Wait for project sync to finish.
3. Select the `entry` module.
4. Choose an emulator or a real HarmonyOS device.
5. Click Run.

## Main files

- `entry/src/main/ets/pages/Index.ets`: game UI and game logic.
- `entry/src/main/ets/entryability/EntryAbility.ets`: main ability.
- `AppScope/app.json5`: app information.
- `docs/PROJECT_REPORT.md`: short project report.

## Repository

GitHub: <https://github.com/OSSD-Course-SYSU-2/25307186-opensource-final-work.git>

## License

MIT License
