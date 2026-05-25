#!/usr/bin/env bash
# PreToolUse(Bash) hook.
#
# Before any `flutter build ios` command, delete the cached tabataTimer
# provisioning profile so the build regenerates a fresh one. With a free
# Apple ID the auto-managed profile is only valid for 7 days; reusing the
# cached copy means the rebuilt app inherits the OLD expiry and can stop
# launching ("App 無法使用"). Forcing regeneration each build resets the
# 7-day window.
#
# No-op for every other Bash command. Always exits 0 so it never blocks the
# tool call.

set -euo pipefail

input="$(cat)"
cmd="$(printf '%s' "$input" | /usr/bin/jq -r '.tool_input.command // ""' 2>/dev/null || true)"

# Only act on iOS builds; pass through everything else untouched.
case "$cmd" in
  *"flutter build ios"*) ;;
  *) exit 0 ;;
esac

PROF_DIR="$HOME/Library/Developer/Xcode/UserData/Provisioning Profiles"
TARGET_APPID="com.keywei.tabataTimer"
[ -d "$PROF_DIR" ] || exit 0

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

deleted=0
shopt -s nullglob
for f in "$PROF_DIR"/*.mobileprovision; do
  # Decode the CMS-signed profile to plist, then read its app-identifier.
  security cms -D -i "$f" >"$tmp" 2>/dev/null || continue
  appid="$(/usr/libexec/PlistBuddy -c 'Print :Entitlements:application-identifier' "$tmp" 2>/dev/null || true)"
  # app-identifier is "<TeamID>.com.keywei.tabataTimer"; match the suffix so
  # other apps' profiles (e.g. ytOffline) are never touched.
  case "$appid" in
    *".$TARGET_APPID") rm -f "$f" && deleted=1 ;;
  esac
done

if [ "$deleted" = 1 ]; then
  echo '{"systemMessage": "Cleared cached iOS provisioning profile for com.keywei.tabataTimer; this build will regenerate a fresh 7-day profile."}'
fi

exit 0
