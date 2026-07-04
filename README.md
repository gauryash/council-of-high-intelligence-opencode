# Council of High Intelligence

<p align="center">
  18 AI personas deliberate your hardest decisions. One command.
  Works with <b>pi</b> and <b>opencode-go</b>.
</p>

<p align="center">
  <a href="https://github.com/gauryash/council-of-high-intelligence-opencode/releases"><img src="https://img.shields.io/github/v/release/gauryash/council-of-high-intelligence-opencode" alt="Release"></a>
  <a href="https://github.com/gauryash/council-of-high-intelligence-opencode/stargazers"><img src="https://img.shields.io/github/stars/gauryash/council-of-high-intelligence-opencode" alt="Stars"></a>
  <img src="https://img.shields.io/badge/pi-skill-teal" alt="pi Skill">
  <img src="https://img.shields.io/badge/opencode--go-skill-purple" alt="opencode-go Skill">
  <img src="https://img.shields.io/badge/members-18-orange" alt="18 Members">
  <a href="https://creativecommons.org/publicdomain/zero/1.0/"><img src="https://img.shields.io/badge/license-CC0-blue" alt="License"></a>
</p>

## Quickstart

```bash
git clone https://github.com/gauryash/council-of-high-intelligence-opencode.git
cd council-of-high-intelligence-opencode
cp .env.example .env   # edit .env → set OPENCODE_GO_API_KEY
./install.sh           # installs to both pi and opencode-go by default
```

Then ask the council:

```
/council Should we open-source our agent framework?
/council --quick Should we add caching here?
/council --duo Should we use microservices or monolith?
```

## The 18 Council Members

| Agent | Figure | Domain | Tier |
|-------|--------|--------|------|
| `council-aristotle` | Aristotle | Categorization & structure | pro |
| `council-socrates` | Socrates | Assumption destruction | pro |
| `council-sun-tzu` | Sun Tzu | Adversarial strategy | flash |
| `council-ada` | Ada Lovelace | Formal systems & abstraction | flash |
| `council-aurelius` | Marcus Aurelius | Resilience & moral clarity | pro |
| `council-machiavelli` | Machiavelli | Power dynamics & realpolitik | flash |
| `council-lao-tzu` | Lao Tzu | Non-action & emergence | pro |
| `council-feynman` | Feynman | First-principles debugging | flash |
| `council-torvalds` | Linus Torvalds | Pragmatic engineering | flash |
| `council-musashi` | Miyamoto Musashi | Strategic timing | flash |
| `council-watts` | Alan Watts | Perspective & reframing | pro |
| `council-karpathy` | Andrej Karpathy | Neural network intuition | flash |
| `council-sutskever` | Ilya Sutskever | Scaling frontier & AI safety | pro |
| `council-kahneman` | Daniel Kahneman | Cognitive bias & decision science | pro |
| `council-meadows` | Donella Meadows | Systems thinking & feedback loops | flash |
| `council-munger` | Charlie Munger | Multi-model reasoning & economics | flash |
| `council-taleb` | Nassim Taleb | Antifragility & tail risk | pro |
| `council-rams` | Dieter Rams | User-centered design | flash |

## Installation

By default `./install.sh` installs for **both** pi (`~/.pi/agent/skills/council/`) and opencode-go (`~/.config/opencode/skills/council/`).

```bash
./install.sh                          # both pi + opencode-go (default)
./install.sh --no-pi                  # opencode-go only
./install.sh --no-opencode            # pi only
./install.sh --copy-configs           # also install model routing configs/
./install.sh --dry-run                # preview without changes
./install.sh --pi-dir PATH            # custom pi directory
./install.sh --opencode-dir PATH      # custom opencode directory
```

Validate with `./scripts/council-simulation-checklist.sh`, then restart your client.

## Requirements

- **pi** or **opencode-go** CLI installed
- `OPENCODE_GO_API_KEY` set in `.env`

## Star History

[![Star History Chart](https://api.star-history.com/chart?repos=gauryash/council-of-high-intelligence-opencode&type=date&legend=top-left)](https://www.star-history.com/?repos=gauryash%2Fcouncil-of-high-intelligence-opencode&type=date&legend=top-left)