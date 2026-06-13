#!/usr/bin/env bash
# Smoke tests for asdf-cangjie plugin scripts.
set -euo pipefail

BIN_DIR="$(cd "$(dirname "$0")/../bin" && pwd)"
PASS=0
FAIL=0

pass() { echo "  PASS $1"; PASS=$((PASS + 1)); }
fail() { echo "  FAIL $1: $2"; FAIL=$((FAIL + 1)); }

echo "=== asdf-cangjie smoke tests ==="
echo ""

# ── Scripts exist and are executable ───────────────────────
echo "[bin] All required scripts present"
for script in download install list-all latest-stable exec-env list-bin-paths; do
  if [ -x "$BIN_DIR/$script" ]; then
    pass "$script exists and is executable"
  else
    fail "$script" "missing or not executable"
  fi
done

# ── list-all ───────────────────────────────────────────────
echo "[list-all] Returns non-empty version list"
output="$(bash "$BIN_DIR/list-all" 2>/dev/null || true)"
if echo "$output" | grep -qE '[0-9]+\.[0-9]+\.[0-9]+'; then
  pass "list-all: $output"
else
  fail "list-all" "no version found in: $output"
fi

# ── latest-stable ─────────────────────────────────────────
echo "[latest-stable] Returns a valid version"
output="$(bash "$BIN_DIR/latest-stable" 2>/dev/null || true)"
if [[ "$output" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  pass "latest-stable: $output"
else
  fail "latest-stable" "unexpected: $output"
fi

# ── exec-env ──────────────────────────────────────────────
echo "[exec-env] Exports expected variables"
# Source it in a subshell and check vars
vars="$(ASDF_INSTALL_PATH=/tmp/test-cj \
  bash -c 'set -a; . "$1" 2>/dev/null; echo "HOME=$CANGJIE_HOME"' _ "$BIN_DIR/exec-env")"
if echo "$vars" | grep -q "HOME=/tmp/test-cj"; then
  pass "exec-env sets CANGJIE_HOME correctly"
else
  fail "exec-env" "expected HOME=/tmp/test-cj, got: $vars"
fi

# Check that exec-env does NOT echo export statements (must use direct export)
output="$(ASDF_INSTALL_PATH=/tmp/test-cj bash "$BIN_DIR/exec-env" 2>/dev/null || true)"
if echo "$output" | grep -q "export"; then
  fail "exec-env" "uses echo export (broken for asdf >=0.16), got: $output"
else
  pass "exec-env uses direct export (correct for asdf >=0.16)"
fi

# ── download: missing version error ────────────────────────
echo "[download] Graceful error on missing version"
output="$(ASDF_INSTALL_TYPE=version ASDF_INSTALL_VERSION=9.9.9 ASDF_DOWNLOAD_PATH=/tmp/nonexist \
  bash "$BIN_DIR/download" 2>&1 || true)"
if echo "$output" | grep -q "Not Found"; then
  pass "download: reports 'Not Found' for version 9.9.9"
else
  fail "download" "expected 'Not Found', got: $(echo "$output" | head -1)"
fi

# ── install: missing download path ─────────────────────────
echo "[install] Fails gracefully without download"
output="$(ASDF_INSTALL_TYPE=version ASDF_INSTALL_VERSION=1.1.3 \
  ASDF_INSTALL_PATH=/tmp/test-install ASDF_DOWNLOAD_PATH=/tmp/no-such-file \
  bash "$BIN_DIR/install" 2>&1 || true)"
if echo "$output" | grep -q "download not found"; then
  pass "install: reports missing download correctly"
else
  fail "install" "expected 'download not found', got: $(echo "$output" | head -1)"
fi

# ── Results ────────────────────────────────────────────────
echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
[ "$FAIL" -eq 0 ] || exit 1
