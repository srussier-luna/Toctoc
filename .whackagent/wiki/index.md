# Wiki — Index

Living knowledge base for this project. Pages link to each other and to tasks
with `[[wikilink]]` syntax (Obsidian-compatible). Keep it current via `/wa-wiki`.

## Pages

- [glossary](../conventions/glossary.md) — one word per thing: concepts, screens, parts, flows
- [[architecture]] — targets, folders, build, runtime check, path of an event to the screen
- [[events]] — Claude hooks → `clippy-hook.sh` → `clippy://` URL → `ClippyEvent`
- [[sessions]] — `SessionStore`: mood per session, priority, bubble timing
- [[overlay]] — two `NSPanel`s: placement, click-through, first click
- [[character]] — paperclip drawing, eyes, mood animations

## How to read

- A page describes a domain, decision, or subsystem — the *why* and the *shape*, not a copy of the code.
- Tasks reference wiki pages in their `wiki:` frontmatter; wiki pages can link back to tasks.
- The code is the structural truth; the wiki is the human narrative on top — it explains what reading the source can't tell you.
