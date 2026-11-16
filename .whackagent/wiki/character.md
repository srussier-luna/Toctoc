# Characters

- `CharacterView` draws the chosen `CharacterKind` (`CharacterStore`, saved in UserDefaults key `character`, default paperclip) and applies shadow, `MoodMotionModifier` and the finished hop to all.
- Seven characters, one folder each in `UI/Views/Characters/`: Trombone (paperclip), Pépin (otter), Plume (owl), Noisette (cup), Coton (cloud), Brindille (sprout, eyes on leaves), Rayure (tiger). Names from `CharacterName`.
- Shared eyes: `EyePairView` / `EyeView` + `EyeStyle(mood:side:)`, `HappyEyeShape`; muzzle `MuzzleView` (otter, tiger).
- Each fits the 64×136 character panel, motions included (render-checked).
- Chosen from the menu bar (door icon, `CharacterMenuView`): change applies at once, same place.

| Mood | Shared | Extras |
|---|---|---|
| idle | blink | — |
| working | look around, sway | steam (cup), paddling paws + water (otter), tail swish (tiger), leaves up (sprout) |
| finished | happy eyes, hop | shell (otter), wings up (owl), sun (cloud), flower (sprout), smile (tiger) |
| waiting | brows raised, pulse | empty cup |
| failed | sad brows | tilted (otter, cup), grey + rain (cloud), drooping leaves, ears down (tiger) |

- Paperclip: `PaperclipShape` (`Path.addTurn`, cubic quarter circles). Stripes/drops iterate `TigerStripe` / `WaterDrop` models.
- Drawn in code: no Microsoft Clippy art, no Disney Tigrou.

## Accessories

- `AccessoryKind?` (nil = none), saved in UserDefaults key `accessory`; one for all characters. Spoon offered only for the cup (`CharacterStore`); leaving the cup drops it.
- Drawings in `UI/Views/Accessories/<Name>/`; spot per character in `AccessoryLayout`, applied by `PlacedAccessoryView` (`AccessoryPlacement`, nil → nothing drawn).
- Cup, otter and sprout draw the accessory inside their own moving group (accessory slot), so it follows their tilt; others get a plain overlay in `CharacterView`. All before shadow, motion and hop.
- Menu: `AccessoryMenu` submenu « Accessoire » between the divider and « Quitter Toctoc ».
