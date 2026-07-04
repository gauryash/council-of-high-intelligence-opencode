# Council of High Intelligence

<p align="center">
  18 AI personas deliberate your hardest decisions. One command.
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
./install.sh           # installs to pi (~/.pi/agent/skills/council/)
```

Then in **pi** or **opencode-go**:

```
/council Should we open-source our agent framework?
/council --quick Should we add caching here?
/council --duo Should we use microservices or monolith?
```

## The 18 Council Members

| Agent | Figure | Domain | Tier | Polarity |
|-------|--------|--------|------|----------|
| `council-aristotle` | Aristotle | Categorization & structure | pro | Classifies everything |
| `council-socrates` | Socrates | Assumption destruction | pro | Questions everything |
| `council-sun-tzu` | Sun Tzu | Adversarial strategy | flash | Reads terrain & competition |
| `council-ada` | Ada Lovelace | Formal systems & abstraction | flash | What can/can't be mechanized |
| `council-aurelius` | Marcus Aurelius | Resilience & moral clarity | pro | Control vs acceptance |
| `council-machiavelli` | Machiavelli | Power dynamics & realpolitik | flash | How actors actually behave |
| `council-lao-tzu` | Lao Tzu | Non-action & emergence | pro | When less is more |
| `council-feynman` | Feynman | First-principles debugging | flash | Refuses unexplained complexity |
| `council-torvalds` | Linus Torvalds | Pragmatic engineering | flash | Ship it or shut up |
| `council-musashi` | Miyamoto Musashi | Strategic timing | flash | The decisive strike |
| `council-watts` | Alan Watts | Perspective & reframing | pro | Dissolves false problems |
| `council-karpathy` | Andrej Karpathy | Neural network intuition | flash | How models actually learn and fail |
| `council-sutskever` | Ilya Sutskever | Scaling frontier & AI safety | pro | When capability becomes risk |
| `council-kahneman` | Daniel Kahneman | Cognitive bias & decision science | pro | Your own thinking is the first error |
| `council-meadows` | Donella Meadows | Systems thinking & feedback loops | flash | Redesign the system, not the symptom |
| `council-munger` | Charlie Munger | Multi-model reasoning & economics | flash | Invert — what guarantees failure? |
| `council-taleb` | Nassim Taleb | Antifragility & tail risk | pro | Design for the tail, not the average |
| `council-rams` | Dieter Rams | User-centered design | flash | Less, but better — the user decides |

## Installation

Default install targets **pi** (`~/.pi/agent/skills/council/`). Add `--opencode` to also install for opencode-go.

```bash
./install.sh                          # pi only (default)
./install.sh --opencode               # pi + opencode-go
./install.sh --opencode --copy-configs # all + model configs
./install.sh --dry-run                # preview
./install.sh --pi-dir PATH            # custom pi dir
./install.sh --opencode-dir PATH      # custom opencode dir
```

Validate with `./scripts/council-simulation-checklist.sh`. Restart your client after installing.

## Requirements

- **pi** or **opencode-go** CLI
- `OPENCODE_GO_API_KEY` in `.env`

## Star History

[![Star History Chart](https://api.star-history.com/chart?repos=gauryash/council-of-high-intelligence-opencode&type=date&legend=top-left)](https://www.star-history.com/?repos=gauryash%2Fcouncil-of-high-intelligence-opencode&type=date&legend=top-left)
