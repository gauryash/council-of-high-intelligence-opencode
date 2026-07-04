#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PI_DIR="${HOME}/.pi/agent"
OPENCODE_DIR="${HOME}/.config/opencode"
DRY_RUN=false
INSTALL_PI=true
INSTALL_OPENCODE=true

usage() {
  cat <<'EOF'
Usage: ./install.sh [--no-pi] [--no-opencode] [--pi-dir PATH] [--opencode-dir PATH] [--dry-run] [--help]

Install Council of High Intelligence skill and agents.
Default: installs to both ~/.pi/agent/skills/council/ and ~/.config/opencode/skills/council/.

Options:
  --no-pi             Skip installing for pi
  --no-opencode        Skip installing for opencode-go
  --pi-dir PATH        Target pi agent directory (default: ~/.pi/agent)
  --opencode-dir PATH  Target opencode config directory (default: ~/.config/opencode)
  --dry-run            Print actions without writing files
  --help               Show this help message
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --pi-dir)
      if [[ $# -lt 2 ]]; then echo "Error: --pi-dir requires a path argument" >&2; usage; exit 1; fi
      PI_DIR="$2"; shift 2 ;;
    --no-opencode)
      INSTALL_OPENCODE=false; shift ;;
    --opencode-dir)
      if [[ $# -lt 2 ]]; then echo "Error: --opencode-dir requires a path argument" >&2; usage; exit 1; fi
      OPENCODE_DIR="$2"; INSTALL_OPENCODE=true; shift 2 ;;
    --no-pi)
      INSTALL_PI=false; shift ;;
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

uninstall_old() {
  local target_dir="$1"
  local label="$2"
  if [[ -d "$target_dir" ]]; then
    echo "  Cleaning previous install at ${target_dir}..."
    # Remove old artifacts that are no longer shipped
    for old in ".env" ".env.example" "scripts" "configs"; do
      if [[ -e "${target_dir}/${old}" ]]; then
        run_cmd rm -rf "${target_dir}/${old}"
        echo "    Removed: ${old}"
      fi
    done
  fi
}

# Validations
[[ -d "${SCRIPT_DIR}/agents" ]] || { echo "Error: agents/ directory not found" >&2; exit 1; }
[[ -f "${SCRIPT_DIR}/SKILL.md" ]] || { echo "Error: SKILL.md not found" >&2; exit 1; }

shopt -s nullglob
agent_files=("${SCRIPT_DIR}"/agents/council-*.md)
shopt -u nullglob
[[ ${#agent_files[@]} -gt 0 ]] || { echo "Error: no council agent files found" >&2; exit 1; }

# ============================================================
# Install for pi (default)
# ============================================================

if [[ "${INSTALL_PI}" == true ]]; then
  PI_SKILL_DIR="${PI_DIR}/skills/council"
  uninstall_old "${PI_SKILL_DIR}" "pi"

  echo "Installing for pi..."
  echo "  Target: ${PI_SKILL_DIR}"

  run_cmd mkdir -p "${PI_SKILL_DIR}" "${PI_SKILL_DIR}/agents"

  run_cmd install -m 0644 "${SCRIPT_DIR}/SKILL.md" "${PI_SKILL_DIR}/SKILL.md"
  echo "  SKILL.md installed"

  for f in "${agent_files[@]}"; do run_cmd install -m 0644 "$f" "${PI_SKILL_DIR}/agents/"; done
  echo "  Agents: ${#agent_files[@]}"
fi

# ============================================================
# Install for opencode-go (optional, --no-opencode to skip)
# ============================================================
if [[ "${INSTALL_OPENCODE}" == true ]]; then
  OPENCODE_SKILL_DIR="${OPENCODE_DIR}/skills/council"
  uninstall_old "${OPENCODE_SKILL_DIR}" "opencode-go"

  echo ""
  echo "Installing for opencode-go..."
  echo "  Target: ${OPENCODE_SKILL_DIR}"

  run_cmd mkdir -p "${OPENCODE_SKILL_DIR}" "${OPENCODE_SKILL_DIR}/agents"

  run_cmd install -m 0644 "${SCRIPT_DIR}/SKILL.md" "${OPENCODE_SKILL_DIR}/SKILL.md"
  echo "  SKILL.md installed"

  for f in "${agent_files[@]}"; do run_cmd install -m 0644 "$f" "${OPENCODE_SKILL_DIR}/agents/"; done
  echo "  Agents: ${#agent_files[@]}"
fi

if [[ "$INSTALL_PI" == false ]] && [[ "$INSTALL_OPENCODE" == false ]]; then
  echo ""
  echo "Warning: both --no-pi and --no-opencode given — nothing to install."
  exit 1
fi

echo ""
echo "Targets enabled:"
[[ "$INSTALL_PI" == true ]] && echo "  - pi:        ${PI_DIR}/skills/council/"
[[ "$INSTALL_OPENCODE" == true ]] && echo "  - opencode:  ${OPENCODE_DIR}/skills/council/"
echo "Done. Restart your CLI client(s) and use /council to convene the council."
