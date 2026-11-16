# Glossary

> whackagent convention module. One word per thing, same word everywhere: UI strings, conversation, tasks, reports, PRs, wiki, code. Yours to edit — every skill and both agents read it. Rules below are plugin text, refreshed by `/wa-update`.

## Rules

- **One thing, one term.** Listed → use it. Never a word from `Never`.
- **Also** = words people say for it. Understand them, never write them.
- **Code** = its name in source. New type, file, variable for it → that name. Existing code named otherwise → never rename unasked.
- **Means** = one line, ≤ 12 words. Detail → `→ [[wiki page]]`.
- **Missing term** → propose the row, add on yes. Never coin a second word for a listed thing.
- Short: what users see or the team argues about. Not a dictionary.
- Review: UI string with a `Never` word → `correctness`. New type or variable off `Code`, or a `Never` word in code → `style`.

## Concepts

Product objects and notions, their states, roles, plans. Users see these: one column per UI language, source first.

| fr | Also | Never | Code | Means |
|---|---|---|---|---|
| Session | conversation | | `Session` | une conversation Claude dans un projet |
| Humeur | état | | `Mood` | état du trombone : repos, travaille, fini, t'attend, oups |
| Événement | hook | | `ClippyEvent` | signal d'un hook Claude vers l'app |
| Personnage | perso, forme | | `CharacterKind` | figure à l'écran : Trombone, Pépin (loutre), Plume (chouette), Noisette (tasse), Coton (nuage), Brindille (pousse), Rayure (tigre) |
| Accessoire | | | `AccessoryKind` | ce que porte le personnage : casquette T, lunettes, nœud papillon, casque audio, bonnet, écharpe, moustache, fleur, cuillère (Noisette) |
| Toctoc | Clippy (ancien nom) | Clippy | `Toctoc.app` | l'app ; code et bundle gardent `Clippy` |
<!-- | Inbox | mailbox | Messages | `Inbox` | received mail, not archived, all accounts | -->
<!-- | Message | mail | Email | `Message` | one mail. States: Draft, Sent, Pending | -->

## Screens

One precise screen. Team names, in the discussion language. UI projects only.

| Name | Also | Code | Means |
|---|---|---|---|
<!-- | Login screen | login page | `LoginView` | email + password, forgot-password link | -->

## Parts

A named piece of UI, reused or talked about on its own. UI projects only.

| Name | Also | Code | On | Means |
|---|---|---|---|---|
| Personnage à l'écran | trombone | `ClippyView` | où on le pose (bas droit par défaut) | le personnage choisi, déplaçable |
| Menu Toctoc | icône porte | `CharacterMenuView` | barre des menus | choix du personnage, sous-menu Accessoire, Quitter Toctoc |
| Bulle | | `BubbleView` | à côté du trombone, jusqu'à 3 empilées | message court d'une session |
<!-- | Composer | editor | `ComposerView` | Inbox, Thread | writes or replies to a message | -->

## Flows

Screens chained for one goal. Steps name **Screens**. UI projects only.

| Name | Also | Steps | Means |
|---|---|---|---|
<!-- | Login flow | sign-in | Welcome → Login screen → 2FA → Inbox | first sign-in, until Inbox | -->
