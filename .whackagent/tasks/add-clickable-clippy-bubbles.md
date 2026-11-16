---
title: Add clickable Clippy bubbles
summary: ouvrir la conversation d'un agent depuis sa bulle
size: medium
type: feature
sprint:
blocked_by: []
status: done
wiki: [[sessions]], [[overlay]], [[events]]
note: « impossible d'enlever les bulles, ajoute un délai de 10 s ; au clic sur la bulle, ouvrir la bonne conversation »
created: 2026-11-16
---

## Context / Decisions

- Constat : les bulles « Fini » ne partent qu'au prompt suivant de la session ou au clic sur le trombone ; en pratique impossible de les enlever.
- Les bulles « Fini » et « Oups » partent seules après 10 s. « Oups » passe donc de 5 s à 10 s.
- La bulle « On t'attend » reste jusqu'à ta réponse, ou jusqu'à un clic.
- Clic sur une bulle → Claude s'ouvre sur la conversation de cet agent, et la bulle part.
- Lien de la conversation : l'app Claude garde un fichier `~/Library/Application Support/Claude/claude-code-sessions/<…>/<…>/local_<id>.json` dont `cliSessionId` vaut le `session_id` des hooks. Lien à ouvrir : `claude://claude.ai/epitaxy/local_<id>`. Format interne non documenté : il peut changer avec une mise à jour de Claude.
- Conversation introuvable → Claude s'ouvre simplement, la bulle part.
- Seules les bulles prennent le clic ; le reste du panneau des bulles laisse passer les clics vers les fenêtres dessous.
- Clic sur le trombone : inchangé.
- Texte : « Coucou » retiré de la bulle « Fini » → « Fini · <titre> ». « Oups · <titre> » inchangé, « Coucou ! On t'attend · <titre> » inchangé.

## Acceptance criteria

- [ ] Une session finit → bulle « Fini · <titre> », sans « Coucou », qui part seule après 10 s.
- [ ] Une session échoue → la bulle « Oups » part seule après 10 s.
- [ ] La bulle « On t'attend » ne part pas seule ; elle part quand tu réponds ou cliques.
- [ ] Clic sur une bulle → Claude s'ouvre sur la conversation de cet agent, la bulle part.
- [ ] Conversation introuvable → Claude s'ouvre, la bulle part.
- [ ] Clic dans le panneau des bulles hors d'une bulle → le clic passe à la fenêtre dessous.
- [ ] Tests : départ après 10 s, recherche du lien de conversation (trouvé, absent, fichier illisible).

## Implementation

- `SessionStore` : « Fini » et « Oups » partent après `bubbleDuration` (10 s) ; la minuterie ne retire que sa propre bulle (`id`) ; « On t'attend » sans minuterie ; `dismiss(sessionID:)` retire la bulle seule.
- `ClaudeSessionLinkFinder` (+ `ClaudeSessionFile`) : cherche hors du fil principal le `local_*.json` dont `cliSessionId` = session ; `ClaudeApplication.open(sessionID:)` ouvre `claude://claude.ai/epitaxy/local_<id>`, sinon `activate()`.
- Panneau des bulles : `FirstClickHostingView`, `ignoresMouseEvents` basculé selon le curseur (moniteurs souris + `BubbleHitRegion`) ; seules les bulles prennent le clic.
- Texte : « Fini · <titre> », sans « Coucou ».
- Preuves : build vert, 46 tests verts, SwiftLint 0 violation ; départ à 10 s vu à l'écran ; installé dans /Applications le 16/11.

## Review

Round `validation` — style ✓ · elegance ✓ · structure ✓ · correctness ✓
- 🟡 [style] dossiers temporaires des tests jamais supprimés → `defer` + nettoyage (autofix).
- 🟡 [elegance] chaîne `map ?? false guard` → `if let …, open(link)` (autofix).
- Non prouvé : clic sur une bulle, clic hors bulle qui passe dessous (cas Clippy actif). À tester à la main.

## Verification

## Feedback
