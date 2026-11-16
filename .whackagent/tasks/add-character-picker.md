---
title: Add character picker
summary: choisir son personnage dans la barre des menus
size: large
type: feature
sprint:
blocked_by: []
status: done
wiki: [[character]], [[overlay]]
note: « on en garde plusieurs, l'utilisateur pourra choisir sa forme dans la barre du haut à côté du wifi »
created: 2026-11-16
---

## Context / Decisions

- Personnages : Pépin (loutre, demandé le 16/11 : pas de rendu validé, à montrer avant clôture), Plume (chouette ronde), Noisette (tasse de café), Coton (nuage), Brindille (pousse, yeux sur les feuilles, petit pot), Rayure (tigre, ajouté le 16/11, pas de rendu validé), plus le trombone actuel.
- Dessins validés sur le rendu v2 du 16/11 (prototype : scratchpad `proto/Characters.swift`). Chaque personnage a les 5 humeurs : repos, travaille, fini, t'attend, oups, avec les mêmes yeux que le trombone.
- Détails par humeur : Pépin (loutre : coquillage sur le ventre quand fini, nage/pattes qui bougent quand travaille, s'ébroue penchée quand oups) ; Plume (ailes levées quand fini) ; Noisette (vapeur quand travaille, tasse vide quand t'attend, renversée quand oups) ; Coton (soleil quand fini, gris + pluie quand oups) ; Brindille (feuilles levées quand travaille, fleur quand fini, feuilles tombantes quand oups).
- Icône dans la barre des menus, à côté du Wi-Fi : menu avec la liste des personnages (coché = actuel) et « Quitter Toctoc ».
- Choix gardé après relance. Par défaut : le trombone, comme aujourd'hui.
- Animations existantes (balancement, saut, pulsation, clignement) gardées pour tous.

## Acceptance criteria

- [ ] Une icône apparaît dans la barre des menus ; son menu liste les 7 personnages, l'actuel coché.
- [ ] Choisir un personnage → il remplace le précédent à l'écran tout de suite, à la même place.
- [ ] Relance → le dernier personnage choisi revient.
- [ ] Chaque personnage montre les 5 humeurs comme sur le rendu validé.
- [ ] Glisser, clic et bulles marchent pareil avec chaque personnage.

## Implementation

- 7 personnages dans `UI/Views/Characters/<Nom>/` (trombone déplacé, loutre, chouette, tasse, nuage, pousse, tigre), `CharacterView` les choisit via `CharacterStore` (`CharacterKind`, `CharacterStorage`, clé UserDefaults `character`, trombone par défaut).
- `MenuBarExtra` (icône porte `door.left.hand.closed`) avec `CharacterMenuView` (liste cochée + « Quitter Toctoc »).
- Rendu des 7 × 5 humeurs vérifié ; boucles de dessin sur `TigerStripe` / `WaterDrop`.
- Build vert, 53 tests verts, SwiftLint 0 violation.

## Review

Round `validation` — 4 lenses ✓. 🟡 ordre des humeurs (vient de show-working-over-finished, accepté) · 🟡 `ForEach(indices)` → modèles `Hashable` (autofix, rendu identique au pixel) · 🟡 mot « Personnage » ajouté au glossaire. Menu de la barre non vu à l'écran : à vérifier à la main.

## Verification

## Feedback
