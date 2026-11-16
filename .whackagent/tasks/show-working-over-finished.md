---
title: Show working over finished
summary: le trombone travaille tant qu'un agent travaille
size: quickwin
type: improvement
sprint:
blocked_by: []
status: done
wiki: [[sessions]]
note: « clippy ferme les yeux même quand claude travaille »
created: 2026-11-16
---

## Context / Decisions

- Constat : un agent a fini (yeux en arc « ^ ^ ») pendant qu'un autre travaille ; le trombone garde l'expression « fini ».
- Cause : priorité des humeurs `waiting` > `failed` > `finished` > `working`.
- Nouvelle priorité : `waiting` > `failed` > `working` > `finished`. Tant qu'un agent travaille, le trombone travaille.
- Bulles inchangées : la bulle « Fini · <titre> » s'affiche quand même.

## Acceptance criteria

- [ ] Un agent a fini, un autre travaille → le trombone a l'expression « travaille ».
- [ ] Plus aucun agent ne travaille → le trombone repasse à « fini ».
- [ ] Test `SessionStore` de la nouvelle priorité.

## Implementation

- `SessionStore` : `Constants.priority` = `[.waiting, .failed, .working, .finished]`.
- Test `a working session shows over a finished one`. Build vert, 47 tests verts, SwiftLint 0 violation. Installé dans /Applications le 16/11.

## Review

- Quick win d'une ligne : pas de relecture séparée, couvert par le test.

## Verification

## Feedback
