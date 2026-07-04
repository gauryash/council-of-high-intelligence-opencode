#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PI_DIR="${HOME}/.pi/agent"
OPENCODE_DIR="${HOME}/.config/opencode"
DRY_RUN=false
COPY_CONFIGS=false
INSTALL_PI=true
INSTALL_OPENCODE=false

usage() {
  cat <<'EOF'
Usage: ./install.sh [--pi-dir PATH] [--opencode] [--opencode-dir PATH] [--copy-configs] [--dry-run] [--help]

Install Council of High Intelligence into pi and/or opencode-go skill directories.
Default: installs to pi only (~/.pi/agent/skills/council/).

Options:
  --pi-dir PATH        Target pi agent directory (default: ~/.pi/agent)
  --opencode           Also install for opencode-go
  --opencode-dir PATH  Target opencode config directory (default: ~/.config/opencode)
  --copy-configs       Also install repo configs/ into skill config folder
  --dry-run            Print actions without writing files
  --help               Show this help message
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --pi-dir)
      if [[ $# -lt 2 ]]; then echo "Error: --pi-dir requires a path argument" >&2; usage; exit 1; fi
      PI_DIR="$2"; shift 2 ;;
    --opencode)
      INSTALL_OPENCODE=true; shift ;;
    --opencode-dir)
      if [[ $# -lt 2 ]]; then echo "Error: --opencode-dir requires a path argument" >&2; usage; exit 1; fi
      OPENCODE_DIR="$2"; INSTALL_OPENCODE=true; shift 2 ;;
    --copy-configs)
      COPY_CONFIGS=true; shift ;;
    --dry-run)
      DRY_RUN=true; shift ;;
    --help|-h)
      usage; exit 0 ;;
    *)
      echo "Error: unknown argument '$1'" >&2; usage; exit 1 ;;
  esac
done

run_cmd() {
  if [[ "$DRY_RUN" == true ]]; then echo "[dry-run] $*"; else "$@"; fi
}

# Validations
[[ -d "${SCRIPT_DIR}/agents" ]] || { echo "Error: agents/ directory not found" >&2; exit 1; }
[[ -f "${SCRIPT_DIR}/SKILL.md" ]] || { echo "Error: SKILL.md not found" >&2; exit 1; }

shopt -s nullglob
agent_files=("${SCRIPT_DIR}"/agents/council-*.md)
shopt -u nullglob
[[ ${#agent_files[@]} -gt 0 ]] || { echo "Error: no council agent files found" >&2; exit 1; }

CONFIGS_SRC_DIR="${SCRIPT_DIR}/configs"
SCRIPTS_SRC_DIR="${SCRIPT_DIR}/scripts"

# ============================================================
# Install for pi (default)
# ============================================================
if [[ "${INSTALL_PI}" == true ]]; then
  PI_SKILL_DIR="${PI_DIR}/skills/council"

  echo "Installing for pi..."
  echo "  Target: ${PI_SKILL_DIR}"

  run_cmd mkdir -p "${PI_SKILL_DIR}" "${PI_SKILL_DIR}/agents" "${PI_SKILL_DIR}/scripts"
  run_cmd install -m 0644 "${SCRIPT_DIR}/SKILL.md" "${PI_SKILL_DIR}/SKILL.md"

  for f in "${agent_files[@]}"; do run_cmd install -m 0644 "$f" "${PI_SKILL_DIR}/agents/"; done
  echo "  Agents: ${#agent_files[@]}"

  for f in "${SCRIPTS_SRC_DIR}"/*.sh; do run_cmd install -m 0755 "$f" "${PI_SKILL_DIR}/scripts/"; done
  echo "  Scripts: $(ls "${SCRIPTS_SRC_DIR}"/*.sh 2>/dev/null | wc -l)"

  if [[ "$COPY_CONFIGS" == true ]] && [[ -d "${CONFIGS_SRC_DIR}" ]]; then
    run_cmd mkdir -p "${PI_SKILL_DIR}/configs"
    for f in "${CONFIGS_SRC_DIR}"/*; do [[ -f "$f" ]] && run_cmd install -m 0644 "$f" "${PI_SKILL_DIR}/configs/"; done
    echo "  Configs: installed"
  fi

  [[ -f "${SCRIPT_DIR}/.env.example" ]] && run_cmd install -m 0644 "${SCRIPT_DIR}/.env.example" "${PI_SKILL_DIR}/.env.example"
  echo "  .env.example installed"
fi

# ============================================================
# Install for opencode-go (optional, --opencode)
# ============================================================
if [[ "${INSTALL_OPENCODE}" == true ]]; then
  OPENCODE_SKILL_DIR="${OPENCODE_DIR}/skills/council"

  echo ""
  echo "Installing for opencode-go..."
  echo "  Target: ${OPENCODE_SKILL_DIR}"

  run_cmd mkdir -p "${OPENCODE_SKILL_DIR}" "${OPENCODE_SKILL_DIR}/agents" "${OPENCODE_SKILL_DIR}/scripts"
  run_cmd install -m 0644 "${SCRIPT_DIR}/SKILL.md" "${OPENCODE_SKILL_DIR}/SKILL.md"

  for f in "${agent_files[@]}"; do run_cmd install -m 0644 "$f" "${OPENCODE_SKILL_DIR}/agents/"; done
  echo "  Agents: ${#agent_files[@]}"

  for f in "${SCRIPTS_SRC_DIR}"/*.sh; do run_cmd install -m 0755 "$f" "${OPENCODE_SKILL_DIR}/scripts/"; done
  echo "  Scripts: $(ls "${SCRIPTS_SRC_DIR}"/*.sh 2>/dev/null | wc -l)"

  if [[ "$COPY_CONFIGS" == true ]] && [[ -d "${CONFIGS_SRC_DIR}" ]]; then
    run_cmd mkdir -p "${OPENCODE_SKILL_DIR}/configs"
    for f in "${CONFIGS_SRC_DIR}"/*; do [[ -f "$f" ]] && run_cmd install -m 0644 "$f" "${OPENCODE_SKILL_DIR}/configs/"; done
    echo "  Configs: installed"
  fi

  [[ -f "${SCRIPT_DIR}/.env.example" ]] && run_cmd install -m 0644 "${SCRIPT_DIR}/.env.example" "${OPENCODE_SKILL_DIR}/.env.example"
  echo "  .env.example installed"
fi

echo ""
echo "Done. Restart your CLI client(s) and use /council to convene the council."
