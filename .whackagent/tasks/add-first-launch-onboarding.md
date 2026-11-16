---
title: Add first launch onboarding
summary: Toctoc se présente à la première ouverture
size: medium
type: feature
sprint:
blocked_by: []
status: done
wiki: [[sessions]], [[overlay]]
note: « ajoute un texte d'onboarding à la première ouverture de Toctoc »
created: 2026-11-16
---

## Context / Decisions

- À la première ouverture, le personnage se présente en 5 bulles affichées en même temps, empilées les unes sous les autres, à la place habituelle des bulles :
  1. « Coucou ! Moi c'est Toctoc. »
  2. « Je te préviens quand un agent Claude a fini ou t'attend. »
  3. « Glisse-moi où tu veux. Clique une bulle pour ouvrir sa conversation. »
  4. « Mon menu est en haut, derrière la porte : change de tête ou d'accessoire. »
  5. « Branche-moi à Claude : clique ici pour le guide. »
- Les bulles ne partent jamais seules : chacune reste jusqu'au clic, hooks branchés ou non (feedback : 30 s trop facile à rater).
- Clic sur une bulle → seule cette bulle part. Clic sur la 5e → ouvre aussi le guide `https://github.com/srussier-luna/Toctoc#readme`. La présentation est finie quand sa dernière bulle est partie.
- Le panneau des bulles s'agrandit vers le haut le temps de la présentation pour tenir les 5.
- Présentation vue une seule fois (gardée après relance). Pendant la présentation, les alertes des agents attendent ; elles s'affichent normalement une fois la présentation finie.
- Le guide = un `README.md` à la racine du dépôt : ce que fait Toctoc, installation (build, copie dans Applications), branchement des hooks Claude dans `~/.claude/settings.json` vers `Scripts/clippy-hook.sh` (exemple JSON des 7 hooks, `async: true`), menu (personnage, accessoire). Ton complice, tutoiement, français.
- Espace fine insécable avant « ! » et « : » (wording).

## Acceptance criteria

- [ ] Première ouverture → bulle « Coucou ! Moi c'est Toctoc. » à côté du personnage.
- [ ] Les 5 bulles s'affichent ensemble, empilées.
- [ ] Sans clic, les bulles restent.
- [ ] Clic sur une bulle → seule cette bulle part ; clic sur la 5e → le README s'ouvre aussi.
- [ ] Relance → plus de présentation.
- [ ] Une alerte arrivée pendant la présentation s'affiche après la fin.
- [ ] `README.md` explique installation et hooks, avec un exemple copiable.

## Implementation

- `OnboardingStore` (+ `OnboardingStorage`, clé `onboardingDone`, `OnboardingStep`) : 5 bulles empilées, restent jusqu'au clic, clic = cette bulle seule, la 5e ouvre le README.
- Panneau des bulles 320×300 pendant la présentation ; bulles des agents en attente, minuteur « Oups » lancé seulement une fois affichées (`areBubblesShown`).
- `README.md` : installation, branchement des 7 hooks, menu, bulles.
- Build vert, 73 tests verts, SwiftLint 0 violation ; installé dans /Applications le 16/11.

## Review

Round `validation` — 4 lenses ✓. 🟡 minuteur « Oups » qui tourne pendant la présentation → lancé à l'affichage (autofix, test ajouté) · 🟡 README sans espaces fines insécables → corrigé. Non vérifié : présentation à l'écran après installation.

## Verification

## Feedback

- Round 1 : présentation ratée (partie seule après 30 s, hooks branchés) → bulles jusqu'au clic ; `ClaudeHooks` et ses modèles supprimés. Vu à l'écran le 16/11 : 5 bulles empilées à côté du personnage.
