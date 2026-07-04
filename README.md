# Council of High Intelligence

<p align="center">
  18 AI personas deliberate your hardest decisions. One command.<br>
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

Convene a multi-persona deliberation with history's greatest thinkers — Aristotle, Feynman, Sun Tzu, Ada Lovelace, and 14 more — to analyze your toughest problems from every angle. Each member has a distinct persona, grounding protocol, and analytical method. No API keys needed.

---

## Quickstart

```bash
git clone https://github.com/gauryash/council-of-high-intelligence-opencode.git
cd council-of-high-intelligence-opencode
./install.sh           # installs to both pi and opencode-go by default
```

Then ask the council:

```
/council Should we open-source our agent framework?
/council --quick Should we add caching here?
/council --duo Should we use microservices or monolith?
```

**No API keys needed.** The council uses pi's own model to dispatch all 18 members as subagents.

---

## How It Works

You ask one question. The council runs a structured multi-round deliberation, then produces a verdict with vote tally, key insights, unresolved questions, and a concrete next step.

### Modes at a Glance

| Mode | Flag | Agents | Chairman | Total Spawned | Rounds |
|------|------|--------|----------|---------------|--------|
| **Auto-triad** (default) | *(no flag)* | 3 (auto-selected) | 1 separate | 4 subagents | 3 + verdict |
| **Full** | `--full` | 18 | 1 separate | 19 subagents | 3 + verdict |
| **Triad** | `--triad [domain]` | 3 (predefined) | 1 separate | 4 subagents | 3 + verdict |
| **Members** | `--members a,b,c` | 2–11 | 1 separate | 3–12 subagents | 3 + verdict |
| **Duo** | `--duo` | 2 | 1 separate | 3 subagents | 3 + verdict |
| **Quick** | `--quick` | 3 (auto-triad) | 1 separate | 4 subagents | 2 + verdict |

### Discussion Rounds by Mode

| Mode | Round 1 | Round 2 | Round 3 | Verdict |
|------|---------|---------|---------|---------|
| **Full** | ✅ Independent analysis (parallel, blind) | ✅ Cross-examination (anonymized) | ✅ Final crystallization | ✅ Chairman synthesizes |
| **Quick** | ✅ Rapid analysis (parallel) | — | ✅ Final positions (anonymized) | ✅ Chairman synthesizes |
| **Duo** | ✅ Opening positions | ✅ Direct response | ✅ Final statements | ✅ Chairman synthesizes |

---

## Usage

```
/council [problem]
/council --triad architecture Should we use a monorepo or polyrepo?
/council --full What is the right pricing strategy for our SaaS product?
/council --members socrates,feynman,ada Is our caching strategy correct?
/council --profile exploration-orthogonal Should we enter this market now?
/council --profile execution-lean --triad ship-now Should we ship today?
/council --quick Should we add caching here?
/council --duo Should we use microservices or monolith?
/council --duo --members torvalds,ada Is this abstraction worth it?
```

### Flags

| Flag | Effect |
|------|--------|
| `--full` | All 18 members |
| `--triad [domain]` | Predefined 3-member combination from the triad table |
| `--members name1,name2,...` | Manual selection (2–11 members) |
| `--profile [name]` | Panel profile: `classic`, `exploration-orthogonal`, `execution-lean` |
| `--quick` | Fast 2-round mode (200-word analysis → 75-word position, no cross-examination) |
| `--duo` | 2-member dialectic using polarity pairs |

Flag priority: `--quick` / `--duo` set the mode. `--full` / `--triad` / `--members` / `--profile` set the panel.

---

## The 18 Council Members

| Agent | Figure | Domain | Tier |
|-------|--------|--------|------|
| `council-aristotle` | **Aristotle** | Categorization & structure | pro |
| `council-socrates` | **Socrates** | Assumption destruction | pro |
| `council-sun-tzu` | **Sun Tzu** | Adversarial strategy | flash |
| `council-ada` | **Ada Lovelace** | Formal systems & abstraction | flash |
| `council-aurelius` | **Marcus Aurelius** | Resilience & moral clarity | pro |
| `council-machiavelli` | **Machiavelli** | Power dynamics & realpolitik | flash |
| `council-lao-tzu` | **Lao Tzu** | Non-action & emergence | pro |
| `council-feynman` | **Richard Feynman** | First-principles debugging | flash |
| `council-torvalds` | **Linus Torvalds** | Pragmatic engineering | flash |
| `council-musashi` | **Miyamoto Musashi** | Strategic timing | flash |
| `council-watts` | **Alan Watts** | Perspective & reframing | pro |
| `council-karpathy` | **Andrej Karpathy** | Neural network intuition & empirical ML | flash |
| `council-sutskever` | **Ilya Sutskever** | Scaling frontier & AI safety | pro |
| `council-kahneman` | **Daniel Kahneman** | Cognitive bias & decision science | pro |
| `council-meadows` | **Donella Meadows** | Systems thinking & feedback loops | flash |
| `council-munger` | **Charlie Munger** | Multi-model reasoning & economics | flash |
| `council-taleb` | **Nassim Taleb** | Antifragility & tail risk | pro |
| `council-rams` | **Dieter Rams** | User-centered design | flash |

Each agent file (`~/.pi/agent/skills/council/agents/council-{name}.md`) contains 4 key sections that shape what each member says:

- **Identity** → their persona, philosophical stance
- **Grounding Protocol** → how they're constrained or grounded
- **Analytical Method** → how they process problems
- **Output Format** → the structure of their response

---

## Deliberation Flow (Full Mode)

Each `/council` invocation follows a strict, auditable sequence:

### STEP 0: Model Resolution
All members use pi's current model. No external API keys required.

### STEP 1: Parse Mode & Select Panel
Determine the mode (`--full`, `--triad`, `--quick`, `--duo`, or auto-triad) and select the panel. A **domain-weight seat** is designated — the member whose expertise most directly matches the problem gets a **1.5× vote weight** at tie-breaking.

### STEP 2: Load Member Prompts
Each member's agent file is read to extract Identity, Grounding Protocol, Analytical Method, and Output Format.

### STEP 2.5: Problem Restate Gate
Before any analysis, each member restates the problem through their lens. Catches wrong-question failures early.

### STEP 3: Chairman Selection
A Chairman is selected — the synthesizer who does NOT participate in deliberation. They emit the final verdict.

### STEP 4: Round 1 — Independent Analysis (Parallel, Blind-First)
All members analyze the problem independently, blind to each other's positions. 400 words max each.

### STEP 5: Round 2 — Cross-Examination (Anonymized)
Member identities are masked using stable labels (Member A, B, C…) to prevent conformity bias (see Choi et al., arXiv:2510.07517; Karpathy `llm-council`). Each member engages at least 2 others by label, with an anti-conformity directive. 300 words max.

### STEP 6: Post-Round Enforcement Scan
Checks for:
- **Dissent quota** — at least 2 members must articulate non-overlapping objections
- **Novelty gate** — each response must contain at least one new claim
- **Agreement check** — if >70% agree, trigger counterfactual to likely dissenters
- **Evidence labels** — claims tagged as `empirical | mechanistic | strategic | ethical | heuristic`
- **Anti-recursion** — Socrates re-asking an answered question triggers a 50-word forced position

### STEP 7: Round 3 — Final Crystallization (Parallel)
Each member states a final position (100 words max) with a structured stance line:
```
STANCE: <option label> | CONFIDENCE: high|med|low | DEALBREAKER: yes|no
```

### STEP 8: Tie-Breaking
Weighted tally. An option needs ≥2/3 of total weight to win. If no option clears the bar, the split is presented to the user. The domain-weight seat (1.5×) is factored in.

### STEP 9: Synthesize Verdict (Chairman)
The Chairman produces the final verdict with all sections filled in — consensus, vote tally, kill criteria, concrete next step, unresolved questions, key insights by member, minority report, and epistemic diversity scorecard.

### STEP 10: Session Metadata
Telemetry appended below the verdict — mode, panel size, rounds run, model, fallbacks, token estimate, duration.

---

## Predefined Triads

| Domain Keyword | Triad | Rationale |
|---------------|-------|-----------|
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

---

## Polarity Pairs

Pairs of members whose lenses naturally clash — used by `--duo` mode and useful for understanding the tensions in any full deliberation:

| Pair | Tension |
|------|---------|
| **Socrates** vs **Feynman** | Destroys top-down vs rebuilds bottom-up |
| **Aristotle** vs **Lao Tzu** | Classifies everything vs structure IS the problem |
| **Sun Tzu** vs **Aurelius** | Wins external games vs governs the internal one |
| **Ada** vs **Machiavelli** | Formal purity vs messy human incentives |
| **Torvalds** vs **Watts** | Ships concrete solutions vs questions whether the problem exists |
| **Musashi** vs **Torvalds** | Waits for the perfect moment vs ships it now |
| **Karpathy** vs **Sutskever** | Build it, observe it, iterate vs pause, research, ensure safety first |
| **Kahneman** vs **Feynman** | Your cognition is the first error vs trust first-principles reasoning |
| **Meadows** vs **Torvalds** | Redesign the feedback loop vs fix the symptom and ship |
| **Munger** vs **Aristotle** | Multi-model lattice vs single taxonomic system |
| **Taleb** vs **Karpathy** | Hidden catastrophic tails vs smooth empirical scaling curves |
| **Rams** vs **Ada** | What the user needs vs what computation can do |

---

## Council Profiles

### `classic` (default)
All 18 members with the domain triads above.

### `exploration-orthogonal`
12-member panel for discovery and "unknown unknowns" reduction.

**Members**: Socrates, Feynman, Sun Tzu, Machiavelli, Ada, Lao Tzu, Aurelius, Torvalds, Karpathy, Sutskever, Kahneman, Meadows

**Profile triads**: `unknowns`, `market-entry`, `system-design`, `reframing`, `ai-frontier`, `blind-spots`

### `execution-lean`
5-member panel for fast decision-to-action loops.

**Members**: Torvalds, Feynman, Sun Tzu, Aurelius, Ada

**Profile triads**: `ship-now`, `launch-strategy`, `stability`

---

## Verdict Output

Every deliberation produces a structured verdict with these sections:

```
## Council Verdict

### Problem
### Council Composition
### Chairman
### Acceptable Compromises
### Kill Criteria
### Concrete Next Step
### Unresolved Questions
### Recommended Next Steps
### Consensus & Agreement
### Vote Tally
### Key Insights by Member
### Points of Disagreement
### Minority Report
### Epistemic Diversity Scorecard
### Follow-Up

---
### Session Metadata
```

**Kill Criteria** are specific observable conditions that would falsify the verdict — each is tied to a measurable threshold or event within a stated time window.

**Concrete Next Step** is exactly one action with a verb that produces an artifact: `Write`, `Push`, `Merge`, `Run`, `File`, `Measure` — never `Consider` or `Explore`.

---

## Installation

By default `./install.sh` installs for **both** pi (`~/.pi/agent/skills/council/`) and opencode-go (`~/.config/opencode/skills/council/`).

```bash
./install.sh                          # both pi + opencode-go (default)
./install.sh --no-pi                  # opencode-go only
./install.sh --no-opencode            # pi only
./install.sh --dry-run                # preview without changes
./install.sh --pi-dir PATH            # custom pi directory
./install.sh --opencode-dir PATH       # custom opencode directory
```

Then restart your client and use `/council`.

---

## Requirements

- **pi** CLI installed (with `pi-subagents` package)
- No API keys required — the council uses pi's own model

---

## Agent Files

A full set of 18 agent definitions ships in the `agents/` directory:

| File | Member | Domain |
|------|--------|--------|
| `council-aristotle.md` | Aristotle | Categorization & structure |
| `council-socrates.md` | Socrates | Assumption destruction |
| `council-sun-tzu.md` | Sun Tzu | Adversarial strategy |
| `council-ada.md` | Ada Lovelace | Formal systems & abstraction |
| `council-aurelius.md` | Marcus Aurelius | Resilience & moral clarity |
| `council-machiavelli.md` | Machiavelli | Power dynamics & realpolitik |
| `council-lao-tzu.md` | Lao Tzu | Non-action & emergence |
| `council-feynman.md` | Feynman | First-principles debugging |
| `council-torvalds.md` | Linus Torvalds | Pragmatic engineering |
| `council-musashi.md` | Miyamoto Musashi | Strategic timing |
| `council-watts.md` | Alan Watts | Perspective & reframing |
| `council-karpathy.md` | Andrej Karpathy | Neural network intuition |
| `council-sutskever.md` | Ilya Sutskever | Scaling frontier & AI safety |
| `council-kahneman.md` | Daniel Kahneman | Cognitive bias & decision science |
| `council-meadows.md` | Donella Meadows | Systems thinking & feedback loops |
| `council-munger.md` | Charlie Munger | Multi-model reasoning & economics |
| `council-taleb.md` | Nassim Taleb | Antifragility & tail risk |
| `council-rams.md` | Dieter Rams | User-centered design |

---

## Examples

**Full mode:** `/council --triad strategy Should we open-source our agent framework?`
→ Convenes Sun Tzu + Machiavelli + Aurelius, runs 3-round deliberation, produces Council Verdict.

**Quick mode:** `/council --quick Should we add Redis caching to the auth flow?`
→ Auto-selects architecture triad, runs 2-round rapid analysis, produces Quick Verdict.

**Duo mode:** `/council --duo Should we rewrite the monolith as microservices?`
→ Selects Aristotle vs Lao Tzu (architecture domain), runs 3-round dialectic, produces Duo Verdict.

**Auto-triad:** `/council What's the best pricing model for our API?`
→ Coordinator analyzes problem, selects the `product` triad (Torvalds + Machiavelli + Watts), runs full deliberation.

---

## Star History

[![Star History Chart](https://api.star-history.com/chart?repos=gauryash/council-of-high-intelligence-opencode&type=date&legend=top-left)](https://www.star-history.com/?repos=gauryash%2Fcouncil-of-high-intelligence-opencode&type=date&legend=top-left)

---

## License

[CC0 1.0 Universal (Public Domain Dedication)](https://creativecommons.org/publicdomain/zero/1.0/)
