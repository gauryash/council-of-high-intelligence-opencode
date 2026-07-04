#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${REPO_DIR}"

echo "== Council Simulation Checklist (opencode-go) =="

pass() { echo "[PASS] $1"; }
fail() { echo "[FAIL] $1"; exit 1; }
warn() { echo "[WARN] $1"; }

# --- File existence checks ---

[[ -f "SKILL.md" ]] || fail "SKILL.md is missing"
pass "SKILL.md exists"

if compgen -G "agents/council-*.md" >/dev/null; then
  agent_count=$(python3 -c "import glob; print(len(glob.glob('agents/council-*.md')))" 2>/dev/null || echo "unknown")
  pass "Agent definitions found (count=${agent_count})"
else
  fail "No agent definitions found under agents/council-*.md"
fi

[[ -f "configs/provider-model-slots.example.yaml" ]] || fail "configs/provider-model-slots.example.yaml is missing"
pass "Provider/model slot template exists"

[[ -f ".env.example" ]] || fail ".env.example is missing"
pass ".env.example exists"

# --- SKILL.md content checks ---

grep -q "exploration-orthogonal" SKILL.md || fail "exploration-orthogonal profile missing in SKILL.md"
pass "exploration-orthogonal profile documented in SKILL.md"

grep -q "execution-lean" SKILL.md || fail "execution-lean profile missing in SKILL.md"
pass "execution-lean profile documented in SKILL.md"

grep -q -- "--models" SKILL.md || fail "--models flag missing in SKILL.md"
pass "--models flag documented in SKILL.md"

grep -q -- "--quick" SKILL.md || fail "--quick flag missing in SKILL.md"
pass "--quick mode documented in SKILL.md"

grep -q -- "--duo" SKILL.md || fail "--duo flag missing in SKILL.md"
pass "--duo mode documented in SKILL.md"

grep -q "CHECKPOINT" SKILL.md || fail "Execution checkpoints missing in SKILL.md"
pass "Execution checkpoints present in SKILL.md"

grep -q "VERIFY" SKILL.md || fail "Verification steps missing in SKILL.md"
pass "Verification steps present in SKILL.md"

# Round 2 anonymization (issue #17) — protect against silent regression
grep -q "Member A" SKILL.md || fail "Member-label vocabulary missing in SKILL.md (issue #17)"
pass "Round 2 anonymization wired in SKILL.md"

# Anti-conformity directive (issue #19) — must be in Round 2 prompts
ac_count_skill=$(grep -c "Anti-conformity directive" SKILL.md || true)
if [[ "$ac_count_skill" -lt 2 ]]; then
  fail "Anti-conformity directive missing from one or more Round 2 prompts in SKILL.md (issue #19; expected ≥2 occurrences, found ${ac_count_skill})"
fi
pass "Anti-conformity directive present in Round 2 prompts in SKILL.md"

# Chairman role (issue #18)
grep -q "STEP 3: Chairman Selection" SKILL.md || fail "Chairman selection step missing in SKILL.md (issue #18)"
grep -q "STEP 9: Synthesize Verdict" SKILL.md || fail "Chairman synthesis step missing in SKILL.md (issue #18)"
pass "Chairman role wired in SKILL.md"

grep -q "chairman_defaults" configs/auto-route-defaults.yaml || fail "chairman_defaults block missing in auto-route-defaults.yaml (issue #18)"
pass "Chairman defaults configured in auto-route-defaults.yaml"

# Verdict actionability sections (issue #21)
grep -q "Acceptable Compromises" SKILL.md || fail "Acceptable Compromises section missing in SKILL.md (issue #21)"
grep -q "Kill Criteria" SKILL.md || fail "Kill Criteria section missing in SKILL.md (issue #21)"
grep -q "Concrete Next Step" SKILL.md || fail "Concrete Next Step section missing in SKILL.md (issue #21)"
pass "Verdict actionability sections present in SKILL.md"

# opencode-go API archetype — must be wired in dispatch + routing
grep -q "opencode_api" SKILL.md || fail "opencode_api dispatch archetype missing in SKILL.md"
grep -q "OPENCODE_GO_API_KEY\|OPENCODE_GO_KEY\|opencode.*key" SKILL.md || fail "opencode-go API key handling missing in SKILL.md"
grep -q "chat/completions" SKILL.md || fail "chat/completions endpoint missing in SKILL.md dispatch"
pass "opencode-go API archetype wired in SKILL.md"

# Session Metadata schema (issue #7)
grep -q "Session Metadata" SKILL.md || fail "Session Metadata block missing in SKILL.md (issue #7)"
grep -q "schema_version: 1" SKILL.md || fail "schema_version: 1 marker missing in SKILL.md Session Metadata (issue #7)"
pass "Session Metadata schema wired in SKILL.md"

# --- Agent structure checks ---

required_sections=("Identity" "Grounding Protocol" "Analytical Method" "What You See" "What You Tend to Miss" "When Deliberating" "Output Format (Council Round 2)" "Output Format (Standalone)")

agent_structure_ok=true
for agent_file in agents/council-*.md; do
  agent_name=$(basename "${agent_file}" .md)
  for section in "${required_sections[@]}"; do
    if ! grep -q "## ${section}" "${agent_file}" 2>/dev/null; then
      section_word=$(echo "${section}" | awk '{print $1}')
      if ! grep -qi "${section_word}" "${agent_file}" 2>/dev/null; then
        warn "${agent_name}: missing section '${section}'"
        agent_structure_ok=false
      fi
    fi
  done
done

if [[ "${agent_structure_ok}" == true ]]; then
  pass "All agents have consistent section structure"
else
  warn "Some agents have inconsistent section structure (see warnings above)"
fi

# --- Grounding protocol placement check ---

grounding_early=true
for agent_file in agents/council-*.md; do
  agent_name=$(basename "${agent_file}" .md)
  grounding_line=$(grep -n "## Grounding Protocol" "${agent_file}" 2>/dev/null | head -1 | cut -d: -f1 || echo "999")
  method_line=$(grep -n "## Analytical Method" "${agent_file}" 2>/dev/null | head -1 | cut -d: -f1 || echo "0")
  if [[ "${grounding_line}" -gt "${method_line}" ]] && [[ "${method_line}" -gt 0 ]]; then
    warn "${agent_name}: Grounding Protocol appears after Analytical Method (should be before)"
    grounding_early=false
  fi
done

if [[ "${grounding_early}" == true ]]; then
  pass "Grounding protocols placed before Analytical Method in all agents"
fi

# --- Triad member validation ---

for member_name in aristotle socrates feynman ada sun-tzu machiavelli aurelius lao-tzu torvalds musashi watts karpathy sutskever kahneman meadows munger taleb rams; do
  if [[ ! -f "agents/council-${member_name}.md" ]]; then
    fail "Missing agent file for triad member: council-${member_name}.md"
  fi
done
pass "All triad member agent files present"

# --- Auto-routing checks ---

[[ -f "scripts/detect-providers.sh" ]] || fail "scripts/detect-providers.sh is missing"
[[ -x "scripts/detect-providers.sh" ]] || fail "scripts/detect-providers.sh is not executable"
pass "detect-providers.sh exists and is executable"

if detect_output="$(bash scripts/detect-providers.sh 2>/dev/null)"; then
  if echo "$detect_output" | grep -q '"provider_count"'; then
    pass "detect-providers.sh produces valid JSON"
  else
    fail "detect-providers.sh output missing provider_count field"
  fi
else
  fail "detect-providers.sh exited with error"
fi

[[ -f "configs/auto-route-defaults.yaml" ]] || fail "configs/auto-route-defaults.yaml is missing"
pass "Auto-route defaults config exists"

# --- Install script checks ---

if command -v shellcheck >/dev/null 2>&1; then
  shellcheck install.sh
  pass "shellcheck passed for install.sh"
else
  warn "shellcheck not installed; skipped"
fi

./install.sh --dry-run >/tmp/council-install-dry-run.log
pass "install.sh --dry-run completed"

grep -q "Installed .* council agents" /tmp/council-install-dry-run.log || fail "install dry-run output missing agent install summary"
pass "Install summary output present"

./install.sh --dry-run --copy-configs >/tmp/council-install-dry-run-configs.log
pass "install.sh --dry-run --copy-configs completed"

grep -q "Installed .* config files" /tmp/council-install-dry-run-configs.log || fail "copy-configs dry-run output missing config install summary"
pass "Config summary output present"

echo
echo "Checklist complete."
