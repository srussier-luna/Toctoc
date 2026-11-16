---
title: Add character accessories
summary: habiller le personnage depuis le menu porte
size: large
type: feature
sprint:
blocked_by: []
status: done
wiki: [[character]]
note: « accessoires possibles pour chacune des formes de Toctoc »
created: 2026-11-16
---

## Context / Decisions

- Accessoires : casquette rouge avec un T blanc dans un rond (pas le dessin Nintendo), lunettes, cuillère, nœud papillon, casque audio, bonnet à pompon, écharpe rayée, moustache en guidon, fleur sur la tête.
- La cuillère n'existe que pour Noisette : plantée dans la tasse. Elle n'apparaît dans le menu que quand Noisette est le personnage actif ; changer de personnage alors qu'elle est choisie remet « Aucun ».
- Menu porte : sous le séparateur, au-dessus de « Quitter Toctoc », un sous-menu « Accessoire » à choix unique : « Aucun » + les accessoires disponibles, l'actuel coché.
- L'accessoire se pose sur le personnage actif, placé et dimensionné pour chacun des 7 personnages (tête, cou ou visage selon l'accessoire).
- Un seul accessoire à la fois, gardé après relance. Par défaut : aucun.
- L'accessoire suit les animations du personnage (balancement, saut, pulsation) et reste dans le panneau 64×136.

## Acceptance criteria

- [ ] Le menu porte a un sous-menu « Accessoire » sous le séparateur, au-dessus de « Quitter Toctoc », avec « Aucun » et un seul choix coché.
- [ ] Choisir un accessoire → il apparaît tout de suite sur le personnage actif.
- [ ] Chaque accessoire est bien placé sur chacun des 7 personnages (rendu 7 × accessoires).
- [ ] La cuillère n'est proposée que pour Noisette ; passer à un autre personnage avec la cuillère remet « Aucun ».
- [ ] Relance → l'accessoire choisi revient.
- [ ] Glisser, clic et bulles marchent pareil avec un accessoire.

## Implementation

- `AccessoryKind` (9 cas, « Aucun » = nil), choix gardé dans UserDefaults (clé `accessory`) via `CharacterStore` ; la cuillère n'est proposée qu'à la tasse, changer de personnage la retire.
- Dessins dans `UI/Views/Accessories/<Nom>/`, placement par personnage (`AccessoryLayout`, `AccessoryPlacement`, `PlacedAccessoryView`) ; tasse, loutre et pousse dessinent l'accessoire dans leur groupe qui bouge.
- Menu porte : sous-menu « Accessoire » (`AccessoryMenu`) sous le séparateur, au-dessus de « Quitter Toctoc ».
- Build vert, 65 tests verts, SwiftLint 0 violation ; rendu 7 × 9 vérifié ; installé dans /Applications le 16/11.

## Review

Round `validation` — 4 lenses ✓. 🟠 valeurs de bascule recopiées (`CharacterTilt`) → accessoire dessiné dans le groupe qui bouge, fichier supprimé (autofix) · 🟡 cuillère posée à la place de la moustache hors tasse → placement optionnel (autofix). Non vérifié : sous-menu à l'écran, clic sur la partie de l'accessoire qui dépasse.

## Verification

## Feedback
