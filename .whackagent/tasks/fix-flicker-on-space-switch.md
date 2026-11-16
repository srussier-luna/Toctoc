---
title: Fix flicker on Space switch
summary: trombone stable quand on change de bureau
size: medium
type: bug
sprint:
blocked_by: []
status: done
wiki: [[overlay]], [[character]]
note: « clippy clignote quand je change de bureau »
created: 2026-11-16
---

## Context / Decisions

- Constat : au changement de bureau, le trombone disparaît puis revient, comme un flash pendant l'animation.
- Le trombone reste affiché, à la même place, pendant tout le changement de bureau.
- Il reste visible au-dessus d'une app en plein écran, comme aujourd'hui.
- Piste à confirmer dans le code : les panneaux sont en `canJoinAllSpaces` + `stationary` ; vérifier aussi si SwiftUI relance ses animations au retour de la fenêtre.

## Acceptance criteria

- [ ] Changer de bureau (balayage à trois doigts ou ctrl + flèche) → le trombone reste visible, sans flash, à la même place.
- [ ] Passer sur une app en plein écran → même résultat.
- [ ] Une bulle affichée reste aussi en place pendant le changement.

## Implementation

- `NSPanelExtension.swift` : les deux panneaux ajoutent `.canJoinAllApplications` à leur `collectionBehavior`. Seul fichier touché.
- Cause probable, non prouvée : Clippy est une app `LSUIElement`, ses panneaux n'appartiennent qu'à son ensemble de fenêtres ; l'app active change à chaque changement de bureau et macOS retire puis remet ces fenêtres. Le SDK recommande `canJoinAllApplications` pour les fenêtres flottantes et les overlays système.
- Plan B si le flash reste : niveau `.screenSaver` au lieu de `.statusBar` (passe aussi au-dessus des menus et alertes).
- Preuves : build vert, 23 tests verts, SwiftLint 0 violation ; réglage relu au runtime (lldb), clics inchangés.

## Review

Round `validation` — style ✓ · elegance ✓ · structure ✓ · correctness ✓
- ✅ review clean. L'absence de flash reste à vérifier à l'œil.

## Verification

- ✅ Les deux panneaux tournent avec le nouveau réglage, même place, trombone cliquable, bulles traversables.
- ⚠️ Changement de bureau sans flash, plein écran, bulle en place : pas vérifiables par l'agent (piloter les bureaux demande la permission Accessibilité). À tester par toi.

## Feedback
