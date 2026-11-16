---
title: Fix missed Clippy alerts
summary: prévenir chaque fois qu'un agent finit ou attend
size: large
type: bug
sprint:
blocked_by: []
status: done
wiki: [[events]], [[sessions]], [[overlay]]
note: « clippy ne prévient pas toujours ni au bon moment » + « clippy fonctionne bien pour ce prompt mais pas pour les autres dans les autres agents qui sont dans des dossiers différents »
created: 2026-11-16
---

## Context / Decisions

- Constat : Claude a fini pendant que tu étais dans une autre app, et aucune bulle n'est apparue.
- Constat : une bulle apparaît parfois au mauvais moment, alors que Claude est devant ou bien plus tard.
- Constat : Clippy prévient pour la session en cours, pas pour les autres agents.
- Vérifié le 16/11 : les hooks des autres sessions tournent bien (le `Stop` d'une autre session a lancé `clippy-hook.sh` sans erreur). Les alertes se perdent dans Clippy : il se tait quand l'app Claude est devant, et la bulle affiche le dossier, le même pour tous les agents d'un projet.
- Cause probable des alertes au mauvais moment, à confirmer dans le code : les hooks sont `async` et chaque événement part dans son propre `open -g`. Un `PostToolUse` peut donc arriver après le `Stop` et effacer « fini » ; une attente peut rester figée et ressortir plus tard.
- Chaque événement porte l'heure du hook. Un événement plus ancien que le dernier reçu pour sa session est ignoré.
- Clippy prévient toujours, même quand l'app Claude est devant. La règle « pas de bulle si Claude est au premier plan » disparaît.
- La bulle nomme l'agent par le titre de sa session, lu dans le transcript (dernière ligne `custom-title`). Pas encore de titre → nom du dossier.
- Une bulle par agent, empilées, 3 au plus. La plus récente est la plus proche du trombone. Une 4e alerte fait partir la plus ancienne.
- La bulle « Fini » d'un agent reste jusqu'à ce que tu écrives dans cette session ou cliques le trombone.
- La bulle « On t'attend » s'affiche tout de suite, sans le délai de 5 s, et part quand tu réponds.
- La bulle « Oups » garde son comportement actuel : 5 s.
- Clic sur le trombone → Claude s'ouvre et toutes les bulles partent. L'expression « t'attend » reste jusqu'à la réponse.
- Remplace des choix faits plus tôt dans le grill : passer sur Claude ne cache plus les bulles et ne compte plus comme « vu ».

## Acceptance criteria

- [ ] Une session finit, quelle que soit l'app devant (Claude compris) → bulle « Coucou ! Fini · <titre de la session> ».
- [ ] La bulle « Fini » reste jusqu'à ce que tu écrives dans cette session ou cliques le trombone.
- [ ] Claude pose une question ou demande une autorisation → bulle « Coucou ! On t'attend · <titre> » tout de suite. Tu réponds → elle part.
- [ ] Deux sessions finissent → deux bulles empilées, la plus récente près du trombone.
- [ ] Une 4e alerte arrive → la plus ancienne bulle part, 3 bulles au plus.
- [ ] Session sans titre → la bulle affiche le nom du dossier.
- [ ] Clic sur le trombone → Claude s'ouvre et les bulles partent.
- [ ] Un `PostToolUse` daté avant le `Stop` mais reçu après → le trombone reste sur « fini ».
- [ ] Tests `SessionStore` : ordre des événements, empilement, départ des bulles.

## Implementation

- Script : ajoute `at` (heure du hook) et `title` (dernier `custom-title` du transcript, lu seulement pour Stop, StopFailure, PermissionRequest, AskUserQuestion). Testé à sec sur 9 entrées, exit 0. Transcript de 1,8 Mo lu en 0,03 s.
- `ClippyEvent` : `date` et `title` (titre vide → dossier), `project` retiré, `mock(...)` pour les tests.
- `SessionStore` : `bubbles` (3 max, une par session, plus récente en dernier), événement plus ancien que le dernier de sa session ignoré, plus de règle « Claude devant » ni de délai. `Session` = humeur + date du dernier événement ; une session vue passe en repos et garde sa date.
- UI : `BubbleStackView` (nouveau) affiche la pile ; `BubbleView` = une bulle ; panneau des bulles 320×144, bas inchangé.
- `ClaudeApplication.isFrontmost` supprimé.
- Cause confirmée dans l'ancien code : bulle coupée quand Claude était devant, une seule bulle partagée entre sessions (chaque événement annulait celle d'une autre), délai de 5 s annulable, nom du dossier pour tous les agents.
- Preuves : build vert, 23 tests verts, SwiftLint 0 violation.

## Review

Round `validation` — style ✓ · elegance ✓ · structure ✓ · correctness ✓
- 🟠 [style] `#Preview` ajoutés dans BubbleView et BubbleStackView → retirés (autofix).
- 🟡 [correctness] clic sur le trombone passait les sessions « travaille » au repos → seules fini et oups passent au repos (autofix).
- 🟡 [correctness] ligne `custom-title` tronquée faisait perdre le titre → lecture tolérante `fromjson?` (autofix).
- 🟡 [style] logs servant seulement à la vérification (AppDelegate, ClippyOverlay) → retirés (autofix).
- 🟡 [style] espace fine insécable avant « ! » de « Coucou » → corrigé (autofix).
- 🟡 [elegance] init membre à membre réécrit à la main → généré par Swift, `init?(url:)` en extension (autofix).
- 🟡 [style] `@Suite` manquant sur 3 suites → ajouté (autofix).
- 🟡 [correctness] accepté : tout `PostToolUse` de la session efface « On t'attend », même s'il ne s'agit pas de la réponse.
- Re-vérification : clean. Build vert, 36 tests verts, SwiftLint 0 violation, chaîne des hooks re-testée.

## Verification

- ✅ Fini avec Claude devant → bulle avec le titre de la session.
- ✅ Fini reste plus de 7 s, part au prompt suivant de la session.
- ✅ On t'attend affichée en moins de 0,8 s, part quand l'outil se termine.
- ✅ Deux sessions → deux bulles empilées, la plus récente en bas.
- ✅ 4e alerte → la plus ancienne part.
- ✅ Session sans titre → nom du dossier.
- ✅ Oups part après 5 s.
- ✅ PostToolUse plus ancien reçu après Stop → ignoré, « fini » reste.
- ⚠️ Clic sur le trombone : pas prouvable par l'agent, couvert par un test du store.

## Feedback
