#!/bin/sh
fields=$(/usr/bin/jq -r '
    "clippy://event?name=\(.hook_event_name // "" | @uri)&tool=\(.tool_name // "" | @uri)&session=\(.session_id // "" | @uri)&project=\(.cwd // "" | split("/") | last | @uri)&at=\(now)",
    if (.hook_event_name | IN("Stop", "StopFailure", "PermissionRequest")) or (.hook_event_name == "PreToolUse" and .tool_name == "AskUserQuestion")
    then .transcript_path // ""
    else ""
    end
' 2>/dev/null) || exit 0
{ IFS= read -r url; IFS= read -r transcript; } <<EOF
$fields
EOF
[ -n "$url" ] || exit 0
title=""
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
    title=$(/usr/bin/grep -F '"custom-title"' "$transcript" 2>/dev/null | /usr/bin/jq -Rrn '[inputs | fromjson? | select(.type? == "custom-title") | .customTitle // empty] | last // "" | @uri' 2>/dev/null)
fi
/usr/bin/open -g "$url&title=$title" >/dev/null 2>&1
exit 0
