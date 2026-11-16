# Toctoc

Toctoc, c'est un petit personnage posé dans un coin de ton écran. Il suit tes sessions Claude Code, dans le terminal comme dans l'app Claude : il bosse quand Claude bosse, et il te fait signe par une bulle quand un agent a fini, se plante ou t'attend. Tu peux laisser Claude tourner et faire autre chose.

## Installation

Il te faut macOS 26, Xcode et [XcodeGen](https://github.com/yonaskolb/XcodeGen).

1. Génère le projet :

   ```sh
   cd <chemin du dépôt>
   xcodegen generate
   ```

2. Ouvre `Clippy.xcodeproj` et builde le schéma `Clippy`. Au premier build, Xcode demande de faire confiance au plugin SwiftLint : clique « Trust & Enable », une fois pour toutes.
3. Copie `Toctoc.app` (dans les produits du build) dans `/Applications`, puis lance-la.

## Brancher Claude

Toctoc écoute les hooks de Claude Code. Ajoute ce bloc dans `~/.claude/settings.json`, en remplaçant `<chemin du dépôt>` par le chemin absolu de ce dépôt. Si tu as déjà une clé `hooks`, fusionne les entrées.

```json
{
  "hooks": {
    "UserPromptSubmit": [
      { "hooks": [{ "type": "command", "command": "<chemin du dépôt>/Scripts/clippy-hook.sh", "async": true }] }
    ],
    "PostToolUse": [
      { "hooks": [{ "type": "command", "command": "<chemin du dépôt>/Scripts/clippy-hook.sh", "async": true }] }
    ],
    "PreToolUse": [
      { "matcher": "AskUserQuestion", "hooks": [{ "type": "command", "command": "<chemin du dépôt>/Scripts/clippy-hook.sh", "async": true }] }
    ],
    "PermissionRequest": [
      { "hooks": [{ "type": "command", "command": "<chemin du dépôt>/Scripts/clippy-hook.sh", "async": true }] }
    ],
    "Stop": [
      { "hooks": [{ "type": "command", "command": "<chemin du dépôt>/Scripts/clippy-hook.sh", "async": true }] }
    ],
    "StopFailure": [
      { "hooks": [{ "type": "command", "command": "<chemin du dépôt>/Scripts/clippy-hook.sh", "async": true }] }
    ],
    "SessionEnd": [
      { "hooks": [{ "type": "command", "command": "<chemin du dépôt>/Scripts/clippy-hook.sh", "async": true }] }
    ]
  }
}
```

- `async: true` : les hooks ne bloquent jamais Claude.
- Le script utilise `/usr/bin/jq`, livré avec macOS 15 et plus.
- Tu déplaces le dépôt ? Mets à jour les chemins, sinon plus aucune bulle.

## Menu

L'icône porte, dans la barre des menus :

- **Personnage** : choisis ta tête (Trombone, Pépin, Plume, Noisette, Coton, Brindille, Rayure).
- **Accessoire** : casquette, lunettes, bonnet, moustache…
- **Quitter Toctoc**.

## Bulles

- Jusqu'à 3 bulles à la fois, une par session, avec le titre de la conversation.
- « Fini » reste jusqu'à ce que tu cliques, « On t'attend » jusqu'à ta réponse, « Oups » part après 10 s.
- Clique une bulle : la conversation s'ouvre dans l'app Claude.
- Clique le personnage : les bulles partent et Claude s'ouvre. Glisse-le pour le déplacer.
