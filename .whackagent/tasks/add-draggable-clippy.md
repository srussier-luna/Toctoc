---
title: Add draggable Clippy
summary: déplacer le trombone n'importe où à l'écran
size: medium
type: feature
sprint:
blocked_by: []
status: done
wiki: [[overlay]]
note: « clippy ne peut pas bouger dans l'écran »
created: 2026-11-16
---

## Context / Decisions

- Constat : le trombone est fixé en bas à droite de l'écran principal.
- Glisser le trombone à la souris le déplace, sur n'importe quel écran.
- Un clic simple, sans glisser, ouvre toujours Claude. Le clic droit ne change pas.
- La position est gardée après une relance de Clippy.
- La bulle suit le trombone, du côté où il y a la place : à gauche par défaut, à droite quand le trombone est près du bord gauche.
- Le trombone reste entier dans la zone visible de l'écran, jamais sous la barre des menus ni sous le Dock.
- Écran débranché → le trombone garde la même position relative, sur l'écran principal.
- Hors scope : revenir au coin depuis le menu, aimanter aux bords.

## Acceptance criteria

- [ ] Glisser le trombone → il suit la souris et reste où on le lâche.
- [ ] Clic simple → Claude s'ouvre. Glisser → Claude ne s'ouvre pas.
- [ ] Quitter puis relancer Clippy → le trombone est à la même place.
- [ ] Trombone près du bord gauche → la bulle s'affiche à sa droite, entière à l'écran.
- [ ] Glisser vers un bord → le trombone ne sort pas de l'écran.
- [ ] Trombone sur un 2e écran, écran débranché → même position relative sur l'écran principal.

## Implementation

- Calcul de placement dans `Core/Overlay/Models/` : `OverlayLayout` (limites de la zone visible, position relative ↔ absolue, côté de la bulle), `OverlayPlacement`, `OverlayScreen`, `ClippyPosition`, `ClippyDrag`, `BubbleSide`.
- Position gardée dans UserDefaults (`ClippyPositionStorage`, clé `clippyPosition`) : écran + point relatif à sa zone visible.
- `ClippyView` : `DragGesture` (seuil 3 pt) en priorité haute sur le `Button` ; le clic ouvre toujours Claude.
- `ClippyOverlay` : restaure, suit le glissé, enregistre au lâcher ; la pile de bulles passe à droite près du bord gauche (`BubbleStackView.side(_:)`).
- Preuves : build vert, 35 tests verts (12 nouveaux), SwiftLint 0 violation.

## Review

Round `validation` — style ✓ · elegance ✓ · structure ✓ · correctness ✓
- 🟡 [style] logs de placement servant seulement à la vérification (`ClippyOverlay.log`) → retirés (autofix).
- Risque noté : `Button` + `highPriorityGesture(DragGesture(minimumDistance: 3))`, seul un test à la souris prouve qu'un glissé n'ouvre pas Claude.
- Re-vérification : clean.

## Verification

- ✅ Relance → même place (position enregistrée relue au lancement).
- ✅ Près du bord gauche → bulle à droite, entière.
- ✅ Position hors limites → trombone et bulle ramenés dans la zone visible.
- ✅ Écran inconnu → même position relative sur l'écran principal.
- ✅ Rien d'enregistré → coin bas droit comme avant.
- ⚠️ Glisser à la souris, clic vs glissé : pas prouvables par l'agent. À tester par toi ; si Claude s'ouvre après un glissé, il faudra un indicateur « en train de glisser ».

## Feedback
