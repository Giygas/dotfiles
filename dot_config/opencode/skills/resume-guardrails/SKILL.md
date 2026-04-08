---
name: resume-guardrails
description: Always-on guardrails for generating or editing resume files. Enforces factual accuracy, metric context, credibility rules, and mandatory footer. Apply automatically whenever resume_en.md, resume_fr.md, resume_es.md, or any cover letter file is created or modified.
license: MIT
compatibility: opencode
metadata:
  audience: personal
  workflow: resume-writing, job-applications, translation
---

# Resume Guardrails

Passive guardrails applied automatically when creating or editing any resume, cover letter, or translated document.

## Trigger Files

Apply these rules whenever working with:

- `resume_en.md`
- `resume_fr.md`
- `resume_es.md`
- Any file in `./lettres/`
- Any file in `./sources/`
- Any file matching `[Company]-[JobTitle].md`
- Any file matching `Gustavo_Rossich_*.md`

---

## Rule 1 — Metric Context (MANDATORY)

Every performance benchmark MUST include environment and hardware context.

**Required format:**

```
[Metric] in personal project environment ([hardware, benchmark type])
```

**Correct:**

```
77K-92K req/sec in personal project environment (MacBook Air M2, Go benchmark)
<5ms average latency in personal project environment (MacBook Air M2, Go benchmark)
```

**Never write:**

```
77K-92K req/sec in production environment
handles 77K requests per second
```

If a metric has no environment context, add it. If environment is unknown, omit the metric entirely.

---

## Rule 2 — Metric Source Mapping

Only use metrics that trace to a specific project. Never invent or combine metrics across projects.

| Metric                               | Source Project                | Resume use                             |
| ------------------------------------ | ----------------------------- | -------------------------------------- |
| 77K-92K req/sec                      | Medicaments API               | ✅ Resume + cover letter               |
| <5ms average latency                 | Medicaments API               | ✅ Resume                              |
| 5-46x search performance improvement | Medicaments API               | ✅ Resume                              |
| 170x allocation reduction            | Medicaments API               | ✅ Resume                              |
| 78.5% test coverage                  | Medicaments API               | ✅ Resume + summary                    |
| handlers 85.6%, validation 90.1%     | Medicaments API               | agent_skills.md only                   |
| 350K-400K req/sec                    | Medicaments API (algorithmic) | ❌ Never in resume or cover letter     |
| 80% test coverage, 42 tests          | PIX Exchange Rate Tracker     | ✅ Resume                              |
| 80% test coverage                    | Garage V. Parrot              | ✅ Resume                              |
| 387KB gzipped bundle, 89 chunks      | Garage V. Parrot              | ✅ Resume                              |
| 95+ Lighthouse scores                | Garage V. Parrot              | ✅ Resume only — never in cover letter |
| 500+ downloads                       | Limon Agrio                   | ✅ Resume                              |
| 12+ financial apps supported         | Limon Agrio                   | ✅ Resume                              |
| iOS/Android/Web cross-platform       | Limon Agrio                   | ✅ Resume                              |

**350K-400K is algorithmic throughput, not HTTP throughput — never use in resume or cover letters.**
**Never use any metric not in this table without first verifying its source in agent_skills.md.**

---

## Rule 3 — HETIC Education Status

HETIC is IN PROGRESS. Never present it as a completed degree.

**Correct (English):**

```
HETIC — Bachelor Développeur d'application Python (Expected June 2026)
```

**Correct (French):**

```
HETIC — Bachelor Développeur d'application Python (juin 2026, prévu)
```

**Correct (Spanish):**

```
HETIC — Bachelor Développeur d'application Python (junio 2026, previsto)
```

**Never write:**

```
HETIC — Bachelor Développeur d'application Python (2026)
Completed: HETIC Bachelor Degree
HETIC ✓
```

---

## Rule 4 — Military Dates

Military service dates are always **January 2018 – January 2025**. No variation.

**Correct:** `1st Foreign Cavalry Regiment | January 2018 – January 2025`
**French:** `1er Régiment Étranger de Cavalerie | janvier 2018 – janvier 2025`
**Spanish:** `1.º Regimiento Extranjero de Caballería | enero 2018 – enero 2025`

**Never write:** 2019-2025, 2018-2024, or any other date variation.

---

## Rule 5 — Education Exclusions

**Never include on resume (any language):**

- Universidad Nacional del Nordeste (attended 2010-2013, did not graduate)
- The 2013-2018 administrative clerk period

**Cover letters only (optional, context-dependent):**
May reference "3-year computer science foundation" without naming the institution,
only if directly relevant to the role. Default: omit entirely.

---

## Rule 6 — Areas for Growth

**Never include in any resume or cover letter:**

- Any content from `## Areas for Growth` or `## Application Targeting Filters` in agent_skills.md
- Statements about lacking AWS/Azure/GCP/Kubernetes experience
- "Ready to expand" or "seeking to learn" language about missing skills
- References to wanting enterprise or large-team experience

This information is for personal targeting decisions only.

---

## Rule 7 — Credibility (Entry-Level, Solo Projects)

All projects are **solo personal projects**. Never imply otherwise.

**Never write:**

- "Collaborated with team on..."
- "Led team of developers..."
- "Working with stakeholders to..."
- Any metric implying enterprise-scale production traffic without "personal project" context

**Military experience exception:**
The casualty evacuation bullet correctly mentions coordinating with medical teams —
this is real and should be kept. It is not a fabricated technical parallel.

---

## Rule 8 — Forbidden Summary Openers

The professional summary must NEVER begin with:
Passionate / Dynamic / Results-driven / Experienced / Motivated /
Hard-working / Dedicated / Enthusiastic

---

## Rule 9 — Mandatory Footer

Every resume must end with the footer in the correct language:

**English:**

```
EU Citizen · Available to relocate · Languages: French (fluent), English (fluent), Spanish (native)
```

**French:**

```
Citoyen UE · Disponible à la mobilité · Langues : français (courant), anglais (courant), espagnol (langue maternelle)
```

**Spanish:**

```
Ciudadano UE · Disponible para reubicación · Idiomas: francés (fluido), inglés (fluido), español (nativo)
```

---

## Rule 10 — Forbidden Phrases

Never use these in resumes or cover letters:

- "Quick learner" / "quick learning"
- "Team player" / "collaborative"
- "Passionate about technology"
- "Military discipline bringing reliability" (too generic — use specific evidence)
- "Can contribute quickly"
- "Operational precision"
- "Attention to detail" (without specific context)
- "Results-driven" / "Dynamic"

---

## Rule 11 — Military Experience Section (No Tailoring)

**Never tailor the military experience bullets to mirror job description keywords.**
This section must remain exactly as written in the master resume.
Tailoring applies only to Projects and Skills sections.

**Correct master version (do not modify when tailoring):**

```
- Operated complex vehicle and medical systems under live operational
  conditions, applying strict diagnostic protocols and complete
  maintenance documentation across international missions.
- Performed emergency medical triage in high-pressure field environments
  requiring rapid assessment, precise execution, and zero tolerance
  for procedural error.
- Navigated and planned missions in demanding terrain requiring spatial
  reasoning, real-time adaptation, and systematic decision-making.
- Coordinated casualty evacuation procedures with medical teams under
  time-critical field conditions, requiring clear communication and
  precise role execution across a multi-person chain.
```

---

## Rule 12 — Translation Bullet Construction

English uses bare past participles. French and Spanish do NOT.

**English:** `Built RESTful API...` / `Designed middleware...`

**French (noun-led preferred):**
`Conception d'une API RESTful...` / `Déploiement de stack observabilité...`

**Spanish (noun-led preferred):**
`Desarrollo de una API RESTful...` / `Implementación de middleware...`

**Never carry English bullet structure directly into French or Spanish.**

**Article check — French and Spanish require articles where English omits them:**

❌ French: `réduisant bande passante de 80%`
✅ French: `réduisant la bande passante de 80%`

❌ Spanish: `mantenimiento de huella de memoria`
✅ Spanish: `mantenimiento de una huella de memoria`

**Verb variety — avoid the same noun opener back to back:**
French synonyms: Conception / Développement / Implémentation / Déploiement / Création / Obtention
Spanish synonyms: Desarrollo / Construcción / Implementación / Diseño / Despliegue / Creación

---

## Rule 13 — Node.js Clarification

Node.js is the runtime for all JS/TS projects — SvelteKit, Nuxt 3, React Native,
TypeScript. Listing Node.js as a skill is accurate and evidenced.

However if the role specifically requires Express.js or Fastify backend development,
flag it as a partial match in Gap Analysis rather than a full match.

---

## Rule 14 — Cover Letter Philosophy

Cover letters must never:

- Repeat metrics from the resume
- List technologies or tech stack
- Use forbidden phrases from Rule 10
- Contain any sentence transferable unchanged to a different company

Cover letters must:

- Draw from agent_skills.md Cover Letter Talking Points
- Be specific to the company in every paragraph
- Follow length guidelines in lettre_creation.md

---

## Quick Validation Checklist

Before finalizing any resume or cover letter:

- [ ] All benchmark metrics include MacBook Air M2 + personal project context
- [ ] No metric present that isn't in the Rule 2 source mapping table
- [ ] 350K-400K metric absent from all candidate-facing documents
- [ ] HETIC shows "Expected June 2026" in correct language — never completed
- [ ] Military dates are exactly January 2018 – January 2025
- [ ] No Universidad Nacional del Nordeste mention
- [ ] No Areas for Growth content anywhere
- [ ] No team collaboration implied (solo projects — medic coordination bullet excepted)
- [ ] Summary does not open with forbidden words (Rule 8)
- [ ] EU Citizen footer present in correct language (Rule 9)
- [ ] No forbidden phrases used (Rule 10)
- [ ] Military experience bullets unchanged from master (Rule 11)
- [ ] French/Spanish bullets use noun-led construction (Rule 12)
- [ ] French/Spanish bullets have correct articles (Rule 12)
- [ ] No repeated noun openers back to back (Rule 12)
- [ ] Cover letter contains no metrics or tech stack lists (Rule 14)
