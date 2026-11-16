# Sessions

- `SessionStore` (`@MainActor @Observable`): one `Session` (mood, `lastEventDate`) per Claude `session_id`.
- Event older than its session's `lastEventDate` → ignored entirely (out-of-order async hooks), logged `Ignored stale …`.
- Shown `mood` = highest priority among sessions: `waiting` > `failed` > `working` > `finished`, else `idle`.
- A seen or ended session goes `idle` but keeps its date: a late event can't bring it back. Entries never purged (one small entry per session).

## Bubbles

- Always shown, whatever app is in front (Claude included). No delay.
- `bubbles: [Bubble]`, oldest first, max 3, one per session: a new bubble for a session replaces its old one and becomes newest; a 4th drops the oldest.
- Bubble names the session by its title (`ClippyEvent.title`).

| Event | Session mood | Bubble of that session |
|---|---|---|
| prompt submitted | working | removed |
| tool finished | working | removed, except « Fini » |
| question, permission | waiting | « On t'attend », at once |
| finished | finished | « Fini · <title> », until click or prompt |
| failed | failed | « Oups · <title> », 10 s |
| session ended | idle | removed |

- Accepted limit: any `PostToolUse` of the session clears « On t'attend », even when it is not the answer.
- Click on the paperclip → `acknowledge()`: all bubbles leave, finished/failed sessions go idle, working/waiting kept; opens Claude.
- State in memory only: a relaunch forgets every session.
- Only « Oups » has a timer (`bubbleDuration`, 10 s, `expiringMoods`); it removes its own bubble (`id`).
- Click on a bubble → `dismiss(sessionID:)` (bubble only, mood kept) + `ClaudeApplication.open(sessionID:)`: `ClaudeSessionLinkFinder` finds the Claude app file `claude-code-sessions/*/*/local_<id>.json` whose `cliSessionId` = session → opens `claude://claude.ai/epitaxy/local_<id>`; not found → opens Claude. Undocumented Claude app format: may break on update.
- `bubbleDuration` injected through `init`: tests pass `.zero`.
