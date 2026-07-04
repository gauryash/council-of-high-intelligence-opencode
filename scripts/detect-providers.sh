#!/usr/bin/env bash
set -euo pipefail

# Council of High Intelligence — Provider Detection Script (opencode-go)
# Detects available LLM providers and outputs structured JSON to stdout.
# For opencode-go, the API is always used as the dispatch mechanism.
# Usage: ./scripts/detect-providers.sh

# --- Helper functions ---

json_provider() {
  local name="$1" available="$2" exec_method="$3" binary="$4" models="$5"
  printf '{"name":"%s","available":%s,"exec_method":"%s","binary":"%s","models":[%s]}' \
    "$name" "$available" "$exec_method" "$binary" "$models"
}

# --- opencode-go provider ---
# Always available — dispatch via OpenAI-compatible API at the configured endpoint.
# The coordinator reads OPENCODE_GO_API_KEY or OPENCODE_API_KEY from the environment.
# If neither is set, the provider is still listed as available; the coordinator
# will attempt to load .env automatically.
providers=()
providers+=("$(json_provider "opencode_go" "true" "opencode_api" "curl" '"deepseek-v4-flash","deepseek-v4-pro"')")

# --- Build JSON output ---

available_count=1
multi_provider=false

provider_json=""
for i in "${!providers[@]}"; do
  if [[ $i -gt 0 ]]; then
    provider_json+=","
  fi
  provider_json+="${providers[$i]}"
done

printf '{"providers":[%s],"provider_count":%d,"multi_provider":%s}\n' \
  "$provider_json" "$available_count" "$multi_provider"
