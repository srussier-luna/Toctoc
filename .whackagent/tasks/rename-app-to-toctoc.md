---
title: Rename app to Toctoc
summary: l'app s'appelle Toctoc partout où on la voit
size: quickwin
type: improvement
sprint:
blocked_by: [add-character-picker]
status: done
wiki: [[architecture]]
note: « l'app doit aussi être renommée » → Toctoc
created: 2026-11-16
---

## Context / Decisions

- Nom visible : `Toctoc.app`, nom affiché « Toctoc », menus « Quitter Toctoc » / « Ouvrir Claude ».
- Pour ne rien casser, restent tels quels : identifiant `com.srussier.Clippy` (la position enregistrée est gardée), schéma `clippy://`, script `Scripts/clippy-hook.sh` et ses hooks, dossier `~/Repos/Clippy`, noms de cible et de types dans le code. Renommage technique complet = tâche à part si besoin.
- Installation : `Toctoc.app` remplace `Clippy.app` dans Applications.

## Acceptance criteria

- [ ] L'app installée s'appelle Toctoc.app dans Applications et dans le Finder.
- [ ] Le menu (clic droit et barre des menus) dit « Quitter Toctoc ».
- [ ] Les hooks réveillent toujours l'app (schéma `clippy://` inchangé).

## Implementation

- `PRODUCT_NAME: Toctoc`, `CFBundleDisplayName: Toctoc`, `PRODUCT_MODULE_NAME: Clippy` ; « Quitter Toctoc » (`QuitButton`). Bundle id, schéma `clippy`, script inchangés. Toctoc.app remplace Clippy.app dans /Applications (16/11).
- Build vert, 53 tests verts, SwiftLint 0 violation.

## Review

Round `validation` — 4 lenses ✓. 🟡 ordre des humeurs (vient de show-working-over-finished, accepté) · 🟡 `ForEach(indices)` → modèles `Hashable` (autofix, rendu identique au pixel) · 🟡 mot « Personnage » ajouté au glossaire. Menu de la barre non vu à l'écran : à vérifier à la main.

## Verification

## Feedback
