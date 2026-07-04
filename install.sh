#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OPENCODE_DIR="${HOME}/.config/opencode"
PI_DIR="${HOME}/.pi/agent"
DRY_RUN=false
COPY_CONFIGS=false
INSTALL_OPENCODE=true
INSTALL_PI=false

usage() {
  cat <<'EOF'
Usage: ./install.sh [--opencode-dir PATH] [--pi] [--pi-dir PATH] [--copy-configs] [--dry-run] [--help]

Install Council of High Intelligence into opencode-go and/or pi skill directories.

Options:
  --opencode-dir PATH  Target opencode config directory (default: ~/.config/opencode)
  --pi                 Also install the pi skill
  --pi-dir PATH        Target pi agent directory (default: ~/.pi/agent)
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
    --pi)
      INSTALL_PI=true
      shift
      ;;
    --pi-dir)
      if [[ $# -lt 2 ]]; then
        echo "Error: --pi-dir requires a path argument" >&2
        usage
        exit 1
      fi
      PI_DIR="$2"
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

# ============================================================
# Install for opencode-go (default)
# ============================================================
if [[ "${INSTALL_OPENCODE}" == true ]]; then
  OPENCODE_SKILL_DIR="${OPENCODE_DIR}/skills/council"
  OPENCODE_SKILL_DEST="${OPENCODE_SKILL_DIR}/SKILL.md"
  OPENCODE_AGENTS_DEST_DIR="${OPENCODE_SKILL_DIR}/agents"
  OPENCODE_SCRIPTS_DEST_DIR="${OPENCODE_SKILL_DIR}/scripts"
  OPENCODE_CONFIGS_DEST_DIR="${OPENCODE_SKILL_DIR}/configs"

  echo "Installing Council of High Intelligence for opencode-go..."
  echo "  Target: ${OPENCODE_DIR}"

  run_cmd mkdir -p "${OPENCODE_SKILL_DIR}" "${OPENCODE_AGENTS_DEST_DIR}" "${OPENCODE_SCRIPTS_DEST_DIR}"

  echo "  Installing council skill..."
  run_cmd install -m 0644 "${SCRIPT_DIR}/SKILL.md" "${OPENCODE_SKILL_DEST}"

  echo "  Installing council agents..."
  opencode_agents=0
  for agent_file in "${agent_files[@]}"; do
    run_cmd install -m 0644 "${agent_file}" "${OPENCODE_AGENTS_DEST_DIR}/"
    ((opencode_agents+=1))
  done

  echo "  Installing council scripts..."
  opencode_scripts=0
  shopt -s nullglob
  script_files=("${SCRIPTS_SRC_DIR}"/*.sh)
  shopt -u nullglob
  for script_file in "${script_files[@]}"; do
    run_cmd install -m 0755 "${script_file}" "${OPENCODE_SCRIPTS_DEST_DIR}/"
    ((opencode_scripts+=1))
  done

  opencode_configs=0
  if [[ "$COPY_CONFIGS" == true ]]; then
    if [[ -d "${CONFIGS_SRC_DIR}" ]]; then
      run_cmd mkdir -p "${OPENCODE_CONFIGS_DEST_DIR}"
      for config_file in "${CONFIGS_SRC_DIR}"/*; do
        if [[ -f "${config_file}" ]]; then
          run_cmd install -m 0644 "${config_file}" "${OPENCODE_CONFIGS_DEST_DIR}/"
          ((opencode_configs+=1))
        fi
      done
    fi
  fi

  # .env.example
  if [[ -f "${SCRIPT_DIR}/.env.example" ]]; then
    run_cmd install -m 0644 "${SCRIPT_DIR}/.env.example" "${OPENCODE_SKILL_DIR}/.env.example"
  fi

  echo ""
  echo "  opencode-go install complete:"
  echo "    Skill: ${OPENCODE_SKILL_DEST}"
  echo "    Agents: ${opencode_agents} installed"
  echo "    Scripts: ${opencode_scripts} installed"
  if [[ "$COPY_CONFIGS" == true ]]; then
    echo "    Configs: ${opencode_configs} installed"
  fi
  echo "    .env.example installed"
  echo "    Next: cp ${OPENCODE_SKILL_DIR}/.env.example ${OPENCODE_SKILL_DIR}/.env"
  echo "          and set your OPENCODE_GO_API_KEY"
fi

# ============================================================
# Install for pi (optional)
# ============================================================
if [[ "${INSTALL_PI}" == true ]]; then
  PI_SKILL_DIR="${PI_DIR}/skills/council"
  PI_SKILL_DEST="${PI_SKILL_DIR}/SKILL.md"
  PI_AGENTS_DEST_DIR="${PI_SKILL_DIR}/agents"
  PI_SCRIPTS_DEST_DIR="${PI_SKILL_DIR}/scripts"
  PI_CONFIGS_DEST_DIR="${PI_SKILL_DIR}/configs"

  echo ""
  echo "Installing Council of High Intelligence for pi..."
  echo "  Target: ${PI_DIR}"

  run_cmd mkdir -p "${PI_SKILL_DIR}" "${PI_AGENTS_DEST_DIR}" "${PI_SCRIPTS_DEST_DIR}"

  echo "  Installing council skill..."
  run_cmd install -m 0644 "${SCRIPT_DIR}/SKILL.md" "${PI_SKILL_DEST}"

  echo "  Installing council agents..."
  pi_agents=0
  for agent_file in "${agent_files[@]}"; do
    run_cmd install -m 0644 "${agent_file}" "${PI_AGENTS_DEST_DIR}/"
    ((pi_agents+=1))
  done

  echo "  Installing council scripts..."
  pi_scripts=0
  shopt -s nullglob
  pi_script_files=("${SCRIPTS_SRC_DIR}"/*.sh)
  shopt -u nullglob
  for script_file in "${pi_script_files[@]}"; do
    run_cmd install -m 0755 "${script_file}" "${PI_SCRIPTS_DEST_DIR}/"
    ((pi_scripts+=1))
  done

  pi_configs=0
  if [[ "$COPY_CONFIGS" == true ]]; then
    if [[ -d "${CONFIGS_SRC_DIR}" ]]; then
      run_cmd mkdir -p "${PI_CONFIGS_DEST_DIR}"
      for config_file in "${CONFIGS_SRC_DIR}"/*; do
        if [[ -f "${config_file}" ]]; then
          run_cmd install -m 0644 "${config_file}" "${PI_CONFIGS_DEST_DIR}/"
          ((pi_configs+=1))
        fi
      done
    fi
  fi

  # .env.example for pi
  if [[ -f "${SCRIPT_DIR}/.env.example" ]]; then
    run_cmd install -m 0644 "${SCRIPT_DIR}/.env.example" "${PI_SKILL_DIR}/.env.example"
  fi

  echo ""
  echo "  pi install complete:"
  echo "    Skill: ${PI_SKILL_DEST}"
  echo "    Agents: ${pi_agents} installed"
  echo "    Scripts: ${pi_scripts} installed"
  if [[ "$COPY_CONFIGS" == true ]]; then
    echo "    Configs: ${pi_configs} installed"
  fi
  echo "    .env.example installed"
  echo "    Next: cp ${PI_SKILL_DIR}/.env.example ${PI_SKILL_DIR}/.env"
  echo "          and set your OPENCODE_GO_API_KEY"
fi

echo ""
echo "Done."
echo "Restart your CLI client(s) and use /council to convene the council."
