# Council of High Intelligence

<p align="center">
  <img src="assets/header.jpeg" alt="Council of High Intelligence" width="800">
</p>

<p align="center">
  18 AI personas deliberate your hardest decisions across multiple reasoning perspectives. One command.
</p>

<p align="center">
  <a href="https://github.com/0xNyk/council-of-high-intelligence/releases"><img src="https://img.shields.io/github/v/release/0xNyk/council-of-high-intelligence" alt="Release"></a>
  <a href="https://github.com/0xNyk/council-of-high-intelligence/stargazers"><img src="https://img.shields.io/github/stars/0xNyk/council-of-high-intelligence" alt="Stars"></a>
  <a href="https://creativecommons.org/publicdomain/zero/1.0/"><img src="https://img.shields.io/badge/license-CC0-blue" alt="License"></a>
  <img src="https://img.shields.io/badge/opencode-go-skill-purple" alt="opencode-go Skill">
  <img src="https://img.shields.io/badge/members-18-orange" alt="18 Members">
</p>

<details>
<summary><strong>Table of Contents</strong></summary>

- [Quickstart](#quickstart)
- [Why This Works](#why-this-works)
- [The 18 Council Members](#the-18-council-members)
- [Three Deliberation Modes](#three-deliberation-modes)
- [Installation](#installation)
- [Requirements](#requirements)
- [Contributing](#contributing)
- [Support the Project](#support-the-project)

</details>

## Quickstart

```bash
git clone https://github.com/0xNyk/council-of-high-intelligence.git
cd council-of-high-intelligence
cp .env.example .env
# Edit .env and set your OPENCODE_GO_API_KEY
./install.sh
```

Then in opencode-go:

```
/council Should we open-source our agent framework?
/council --quick Should we add caching here?
/council --duo Should we use microservices or monolith?
```

## Why This Works

A single LLM gives you one reasoning path dressed up as confidence. Ask it a hard question and you get a fluent, structured, wrong answer. The council gives you structured disagreement instead:

- **Get genuinely different perspectives** — polarity pairs force real tension (Socrates destroys assumptions; Feynman rebuilds from first principles). Model tier routing (pro/flash) ensures heavyweight analytical roles get deeper reasoning capacity while practical roles stay fast
- **Catch wrong questions early** — the Problem Restate Gate makes every member reframe the question before analysis begins. If 3 members restate your question differently, the question was the problem
- **Know what the council can't answer** — verdicts lead with Unresolved Questions and Recommended Next Steps, not with confident-sounding consensus. What the council doesn't know matters more than where it agrees
- **Prevent groupthink** — dissent quotas, novelty gates, and counterfactual prompts enforce genuine disagreement. If >70% agree too early, two members are forced to steelman the opposing view

> **Why not just ask an LLM directly?** A single prompt gives you one model's confident best guess. The council gives you 3-18 independent analyses from different intellectual traditions, forces them to challenge each other's claims, and synthesizes a verdict that surfaces disagreement rather than hiding it. It's the difference between asking one advisor and convening a board.

## The 18 Council Members

| Agent | Figure | Domain | Model Tier | Polarity |
|-------|--------|--------|-------|----------|
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
| `council-karpathy` | Andrej Karpathy | Neural network intuition & empirical ML | flash | How models actually learn and fail |
| `council-sutskever` | Ilya Sutskever | Scaling frontier & AI safety | pro | When capability becomes risk |
| `council-kahneman` | Daniel Kahneman | Cognitive bias & decision science | pro | Your own thinking is the first error |
| `council-meadows` | Donella Meadows | Systems thinking & feedback loops | flash | Redesign the system, not the symptom |
| `council-munger` | Charlie Munger | Multi-model reasoning & economics | flash | Invert — what guarantees failure? |
| `council-taleb` | Nassim Taleb | Antifragility & tail risk | pro | Design for the tail, not the average |
| `council-rams` | Dieter Rams | User-centered design | flash | Less, but better — the user decides |

<details>
<summary><strong>Polarity Pairs</strong> — members are chosen as deliberate counterweights</summary>

- **Socrates vs Feynman** — Destroys top-down vs rebuilds bottom-up
- **Aristotle vs Lao Tzu** — Classifies everything vs structure IS the problem
- **Sun Tzu vs Aurelius** — Wins external games vs governs the internal one
- **Ada vs Machiavelli** — Formal purity vs messy human incentives
- **Torvalds vs Watts** — Ships concrete solutions vs questions whether the problem exists
- **Musashi vs Torvalds** — Waits for the perfect moment vs ships it now
- **Karpathy vs Sutskever** — Build it, observe it, iterate vs pause, research, ensure safety first
- **Karpathy vs Ada** — Empirical ML intuition vs formal systems theory
- **Kahneman vs Feynman** — Your cognition is the first error vs trust first-principles reasoning
- **Meadows vs Torvalds** — Redesign the feedback loop vs fix the symptom and ship
- **Munger vs Aristotle** — Multi-model lattice vs single taxonomic system
- **Taleb vs Karpathy** — Hidden catastrophic tails vs smooth empirical scaling curves
- **Rams vs Ada** — What the user needs vs what computation can do

</details>

## Three Deliberation Modes

### Full Mode (default)
3-round structured deliberation: independent analysis → cross-examination → final positions.

```
/council Should we open-source our agent framework?
/council --triad strategy What's our competitive moat?
/council --full What is the right pricing model?
```

### Quick Mode (`--quick`)
2-round rapid analysis for simpler decisions. No cross-examination.

```
/council --quick Should we add caching here?
/council --quick --triad shipping Should we release today?
```

### Duo Mode (`--duo`)
2-member dialectic using polarity pairs. Great for exploring tensions.

```
/council --duo Should we use microservices or monolith?
/council --duo --members torvalds,ada Is this abstraction worth it?
```

<details>
<summary><strong>Pre-defined Triads</strong> — 20 domain-specific 3-member combinations</summary>

| Domain | Triad | Rationale |
|--------|-------|-----------|
| `architecture` | Aristotle + Ada + Feynman | Classify + formalize + simplicity-test |
| `strategy` | Sun Tzu + Machiavelli + Aurelius | Terrain + incentives + moral grounding |
| `ethics` | Aurelius + Socrates + Lao Tzu | Duty + questioning + natural order |
| `debugging` | Feynman + Socrates + Ada | Bottom-up + assumption testing + formal verification |
| `innovation` | Ada + Lao Tzu + Aristotle | Abstraction + emergence + classification |
| `conflict` | Socrates + Machiavelli + Aurelius | Expose + predict + ground |
| `complexity` | Lao Tzu + Aristotle + Ada | Emergence + categories + formalism |
| `risk` | Sun Tzu + Aurelius + Feynman | Threats + resilience + empirical verification |
| `shipping` | Torvalds + Musashi + Feynman | Pragmatism + timing + first-principles |
| `product` | Torvalds + Machiavelli + Watts | Ship it + incentives + reframing |
| `founder` | Musashi + Sun Tzu + Torvalds | Timing + terrain + engineering reality |
| `ai` | Karpathy + Sutskever + Ada | Empirical ML + scaling frontier + formal limits |
| `ai-product` | Karpathy + Torvalds + Machiavelli | ML capability + shipping pragmatism + incentives |
| `ai-safety` | Sutskever + Aurelius + Socrates | Safety frontier + moral clarity + assumption destruction |
| `decision` | Kahneman + Munger + Aurelius | Bias detection + inversion + moral clarity |
| `systems` | Meadows + Lao Tzu + Aristotle | Feedback loops + emergence + categories |
| `uncertainty` | Taleb + Sun Tzu + Sutskever | Tail risk + terrain + scaling frontier |
| `design` | Rams + Torvalds + Watts | User clarity + maintainability + reframing |
| `economics` | Munger + Machiavelli + Sun Tzu | Models + incentives + competition |
| `bias` | Kahneman + Socrates + Watts | Cognitive bias + assumption destruction + frame audit |

</details>

<details>
<summary><strong>Council Profiles</strong> — pre-built panels for different needs</summary>

### `classic` (default)
All 18 members with domain triads above. Best for broad deliberation.

### `exploration-orthogonal`
12-member panel for discovery and "unknown unknowns" reduction:
- Socrates, Feynman, Sun Tzu, Machiavelli, Ada, Lao Tzu, Aurelius, Torvalds, Karpathy, Sutskever, Kahneman, Meadows
- Profile triads: `unknowns`, `market-entry`, `system-design`, `reframing`, `ai-frontier`, `blind-spots`

### `execution-lean`
5-member panel for fast decision-to-action:
- Torvalds, Feynman, Sun Tzu, Aurelius, Ada
- Profile triads: `ship-now`, `launch-strategy`, `stability`

</details>

## Installation

Installs 18 council agents plus the skill file for opencode-go.

```bash
./install.sh                                   # Default install
./install.sh --opencode-dir /path/to/opencode  # Custom opencode directory
./install.sh --dry-run                          # Preview without writing
./install.sh --copy-configs                     # Also install model routing templates
```

Restart opencode-go after installing. Run `./scripts/council-simulation-checklist.sh` to validate. Try the demo session pack to test all modes.

## Requirements

- [opencode-go](https://opencode.ai) CLI
- An API key for the opencode-go endpoint (set `OPENCODE_GO_API_KEY` in `.env`)
- Built-in: no external provider CLIs required — all dispatch happens through the opencode-go API

## Deliberation Protocol

Full mode runs 7 steps: model routing → problem restate gate → independent analysis → cross-examination → enforcement scan → final positions → verdict synthesis. Verdicts lead with what the council doesn't know.

<details>
<summary><strong>Full protocol details</strong></summary>

### Full Mode (7 steps)
1. **Model Routing** — assign member tiers (pro/flash)
2. **Problem Restate Gate** — each member restates the problem + provides an alternative framing before analysis begins
3. **Round 1: Independent Analysis (blind-first)** — all members analyze in parallel (400 words max)
4. **Round 2: Cross-Examination** — members challenge each other (300 words, must engage 2+ others)
5. **Post-Round Enforcement** — dissent quota, novelty gate, agreement check, anti-recursion (single pass)
6. **Round 3: Final Crystallization** — 100-word position statements
7. **Verdict Synthesis** — leads with Unresolved Questions and Recommended Next Steps

### Quick Mode
1. **Problem Restate + Rapid Analysis** — reframe + analyze in parallel (200 words max)
2. **Final Positions** — 75-word crystallization

### Duo Mode
1. **Problem Restate + Opening Positions** — reframe + state positions (300 words)
2. **Direct Response** — engage opponent's claims (200 words)
3. **Final Statements** — 50-word positions

### Enforcement Mechanisms
- **Bounded protocol is the forcing function** — deliberation runs a fixed round budget (full 3 / quick 2 / duo 3), so it cannot loop. Anti-recursion guards (the "hemlock rule" caps Socrates' questioning; any pair exceeding 2 messages is cut off) enforce the bound mid-round.
- Dissent quota + novelty gate + counterfactual pass prevent premature convergence
- **Tie-breaking is a counted tally, not a prose impression** — each member emits a structured `STANCE:` line in the final round; consensus requires a **domain-weighted 2/3 majority** (the on-domain seat carries 1.5×, designated *before* positions exist). A genuine split is escalated to the user with the full tally rather than forced into false consensus.
- All verdicts include a Vote Tally and a Follow-Up section for outcome tracking

</details>

## Contributing

Contributions welcome. Read the [contribution guidelines](CONTRIBUTING.md) first.

## Support the Project

If you find this project useful, consider supporting my open-source work.

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-support-orange?logo=buymeacoffee)](https://buymeacoffee.com/nyk_builderz)

**Solana donations**

`BYLu8XD8hGDUtdRBWpGWu5HKoiPrWqCxYFSh4oxXuvPg`

## License

[![CC0](https://licensebuttons.net/p/zero/1.0/88x31.png)](https://creativecommons.org/publicdomain/zero/1.0/)

To the extent possible under law, the authors have waived all copyright and
related or neighboring rights to this work.

---

<p align="center">
  <a href="https://star-history.com/#0xNyk/council-of-high-intelligence&Date">
    <img src="https://api.star-history.com/svg?repos=0xNyk/council-of-high-intelligence&type=Date" alt="Star History" width="400">
  </a>
</p>
