#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPENCODE_DIR="${HOME}/.config/opencode"
DRY_RUN=false
COPY_CONFIGS=false

usage() {
  cat <<'EOF'
Usage: ./install.sh [--opencode-dir PATH] [--copy-configs] [--dry-run] [--help]

Install Council of High Intelligence into opencode-go skill directory.

Options:
  --opencode-dir PATH  Target opencode config directory (default: ~/.config/opencode)
  --copy-configs       Also install repo configs/ into skill config folder
  --dry-run            Print actions without writing files
  --help               Show this help message
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --opencode-dir)
      if [[ $# -lt 2 ]]; then
        echo "Error: --opencode-dir requires a path argument" >&2
        usage
        exit 1
      fi
      OPENCODE_DIR="$2"
      shift 2
      ;;
    --copy-configs)
      COPY_CONFIGS=true
      shift
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Error: unknown argument '$1'" >&2
      usage
      exit 1
      ;;
  esac
done

run_cmd() {
  if [[ "$DRY_RUN" == true ]]; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

if [[ ! -d "${SCRIPT_DIR}/agents" ]]; then
  echo "Error: agents directory not found at ${SCRIPT_DIR}/agents" >&2
  exit 1
fi

if [[ ! -f "${SCRIPT_DIR}/SKILL.md" ]]; then
  echo "Error: SKILL.md not found at ${SCRIPT_DIR}/SKILL.md" >&2
  exit 1
fi

shopt -s nullglob
agent_files=("${SCRIPT_DIR}"/agents/council-*.md)
shopt -u nullglob

if [[ ${#agent_files[@]} -eq 0 ]]; then
  echo "Error: no council agent files found under ${SCRIPT_DIR}/agents" >&2
  exit 1
fi

CONFIGS_SRC_DIR="${SCRIPT_DIR}/configs"
SCRIPTS_SRC_DIR="${SCRIPT_DIR}/scripts"

# --- Installation targets ---
SKILL_DEST_DIR="${OPENCODE_DIR}/skills/council"
SKILL_DEST="${SKILL_DEST_DIR}/SKILL.md"
AGENTS_DEST_DIR="${SKILL_DEST_DIR}/agents"
SCRIPTS_DEST_DIR="${SKILL_DEST_DIR}/scripts"
CONFIGS_DEST_DIR="${SKILL_DEST_DIR}/configs"

echo "Installing Council of High Intelligence for opencode-go..."
echo "Target directory: ${OPENCODE_DIR}"

echo "Creating destination directories..."
run_cmd mkdir -p "${SKILL_DEST_DIR}" "${AGENTS_DEST_DIR}" "${SCRIPTS_DEST_DIR}"

echo "Installing council skill..."
run_cmd install -m 0644 "${SCRIPT_DIR}/SKILL.md" "${SKILL_DEST}"

echo "Installing council agents..."
installed_agents=0
for agent_file in "${agent_files[@]}"; do
  run_cmd install -m 0644 "${agent_file}" "${AGENTS_DEST_DIR}/"
  ((installed_agents+=1))
done

echo "Installing council scripts..."
installed_scripts=0
shopt -s nullglob
script_files=("${SCRIPTS_SRC_DIR}"/*.sh)
shopt -u nullglob
for script_file in "${script_files[@]}"; do
  run_cmd install -m 0755 "${script_file}" "${SCRIPTS_DEST_DIR}/"
  ((installed_scripts+=1))
done

installed_configs=0
if [[ "$COPY_CONFIGS" == true ]]; then
  if [[ -d "${CONFIGS_SRC_DIR}" ]]; then
    run_cmd mkdir -p "${CONFIGS_DEST_DIR}"
    shopt -s nullglob
    config_files=("${CONFIGS_SRC_DIR}"/*)
    shopt -u nullglob
    for config_file in "${config_files[@]}"; do
      if [[ -f "${config_file}" ]]; then
        run_cmd install -m 0644 "${config_file}" "${CONFIGS_DEST_DIR}/"
        ((installed_configs+=1))
      fi
    done
  else
    echo "Warning: --copy-configs was set but ${CONFIGS_SRC_DIR} does not exist."
  fi
fi

# Create .env.example if it exists
if [[ -f "${SCRIPT_DIR}/.env.example" ]]; then
  run_cmd install -m 0644 "${SCRIPT_DIR}/.env.example" "${SKILL_DEST_DIR}/.env.example"
  echo "  Installed .env.example (copy to .env and configure your API key)"
fi

echo
echo "Done."
echo "  Installed skill to ${SKILL_DEST}"
echo "  Installed ${installed_agents} council agents to ${AGENTS_DEST_DIR}"
echo "  Installed ${installed_scripts} scripts to ${SCRIPTS_DEST_DIR}"
if [[ "$COPY_CONFIGS" == true ]]; then
  echo "  Installed ${installed_configs} config files to ${CONFIGS_DEST_DIR}"
fi

echo ""
echo "Next steps:"
echo "  1. Copy .env.example to .env and set your OPENCODE_GO_API_KEY:"
echo "     cp ${SKILL_DEST_DIR}/.env.example ${SKILL_DEST_DIR}/.env"
echo "  2. Edit ${SKILL_DEST_DIR}/.env with your API key"
echo "  3. Run /council in opencode-go to convene the council"
