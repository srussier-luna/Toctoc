---
title: Keep finished bubbles
summary: la bulle Fini reste jusqu'au clic
size: quickwin
type: improvement
sprint:
blocked_by: []
status: done
wiki: [[sessions]]
note: « les tâches finies doivent rester affichées finalement »
created: 2026-11-16
---

## Context / Decisions

- La bulle « Fini · <titre> » ne part plus seule après 10 s : elle reste jusqu'au clic sur la bulle, au clic sur le trombone, ou au prompt suivant de la session.
- La bulle « Oups » garde son départ après 10 s. « On t'attend » inchangée.

## Acceptance criteria

- [ ] Une session finit → la bulle « Fini » est encore là après 10 s.
- [ ] Clic sur la bulle, clic sur le personnage ou prompt suivant de la session → elle part.
- [ ] « Oups » part toujours après 10 s.

## Implementation

- `SessionStore` : timer seulement pour `.failed` (`expiringMoods`) ; « Fini » reste jusqu'au clic ou au prompt. Tests adaptés.
- Build vert, 53 tests verts, SwiftLint 0 violation.

## Review

Round `validation` — 4 lenses ✓. 🟡 ordre des humeurs (vient de show-working-over-finished, accepté) · 🟡 `ForEach(indices)` → modèles `Hashable` (autofix, rendu identique au pixel) · 🟡 mot « Personnage » ajouté au glossaire. Menu de la barre non vu à l'écran : à vérifier à la main.

## Verification

## Feedback
