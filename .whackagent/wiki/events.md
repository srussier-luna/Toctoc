# Events

## Hooks

- Declared in `~/.claude/settings.json` (user scope), all `async: true`: never block Claude, never answer a prompt.
- Fire in terminal sessions and in Claude desktop app sessions, every folder. Verified 16/11 on other sessions (`stop_hook_summary` in their transcripts, no error).
- `async` → each event is its own `open -g`: events can arrive out of order. Handled by `at` (see Parsing).

| Hook | Filter | `ClippyEvent.Kind` |
|---|---|---|
| `UserPromptSubmit` | — | `promptSubmitted` |
| `PostToolUse` | — | `toolFinished` |
| `PreToolUse` | `AskUserQuestion` | `questionAsked` |
| `PermissionRequest` | — | `permissionRequested` |
| `Stop` | — | `finished` |
| `StopFailure` | — | `failed` |
| `SessionEnd` | — | `sessionEnded` |

## Relay

- `Scripts/clippy-hook.sh`: `jq` reads the hook JSON on stdin → `clippy://event?name=&tool=&session=&project=&at=&title=` → `open -g`. Always exits 0.
- `project` = last path component of `cwd`. `at` = hook time (jq `now`, seconds since 1970).
- `title` = `customTitle` of the last `"type":"custom-title"` line of `transcript_path` (session title shown in the Claude app). Read only for `Stop`, `StopFailure`, `PermissionRequest`, `PreToolUse` `AskUserQuestion`; truncated lines skipped (`fromjson?`). ~0.03 s on a 1.8 MB transcript.
- `open -g` launches the app in background when it is not running.
- Live for every session: a broken script = no alert anywhere. Dry-run it (copy, `open` → `echo`) before shipping.
- Moving or renaming the script breaks the hooks: update `~/.claude/settings.json` with it.
- URL contract: add params only; older installed builds ignore unknown params.

## Parsing

- `ClippyEvent(url:)` (extension): scheme `clippy`, host `event`. Unknown hook, or `PreToolUse` of another tool → `nil`, logged `notice`.
- `date` from `at`, missing → arrival time. `title` empty or missing → `project`.
- Each received event logged `info`: kind + session id, public. Titles never logged.
