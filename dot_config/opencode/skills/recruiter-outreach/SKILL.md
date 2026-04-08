---
name: recruiter-outreach
description: Writes tailored recruiter outreach messages for LinkedIn, email, and job application follow-ups. Apply when asked to write a message to a recruiter, follow up on an application, or reach out about a job posting. Produces short, human, specific messages that avoid AI-sounding phrases.
license: MIT
compatibility: opencode
metadata:
  workflow: job-applications, networking
---

# Recruiter Outreach

Writes short, specific outreach messages to recruiters on LinkedIn,
email, or any professional platform. Applies to:

- Follow-up after submitting an application
- Cold outreach about a job posting
- Response to a recruiter who reached out first
- Salary and availability questions

---

## Core Philosophy

A recruiter message is not a mini cover letter.
It answers one question: **"Is this person worth a conversation?"**

The goal is a reply, not a sale. Short, specific, and human
beats long, comprehensive, and impressive every time.

---

## Message Types and Length

| Type                           | Platform       | Max Length                 |
| ------------------------------ | -------------- | -------------------------- |
| Follow-up after applying       | LinkedIn       | 4-5 sentences              |
| Cold outreach about posting    | LinkedIn       | 4-5 sentences              |
| Response to recruiter question | LinkedIn/Email | 3-4 sentences per question |
| Email follow-up                | Email          | 3 short paragraphs         |

Never exceed these lengths. If it doesn't fit, cut — don't expand.

---

## Structure by Message Type

### Follow-up After Applying (LinkedIn)

```
Sentence 1: State what you applied for (role name, company)
Sentence 2: One specific technical angle relevant to their stack
Sentence 3: One GitHub link with one-sentence description
Sentence 4: Invite reply without pressure
```

Example:

```
I just applied for the Golang Engineer position and wanted
to reach out directly.

My most relevant project is a Go REST API achieving
77K-92K req/sec with atomic zero-downtime deployments:
github.com/Giygas/medicaments-api

Happy to discuss if it looks like a fit.
```

### Cold Outreach About a Posting (LinkedIn)

```
Sentence 1: Reference the specific posting by title
Sentence 2: Why this company/role specifically — one concrete reason
Sentence 3: One technical anchor (project or metric)
Sentence 4: Call to action
```

### Response to Recruiter Questions

Answer each question directly and concisely.
One sentence per answer where possible.
Add context only where it helps the recruiter make a decision.

**Salary questions:**

- Always give a range, never "I'm flexible"
- Anchor toward the top of your range
- Add "depending on the full package and responsibilities"
- If entry-level, acknowledge it briefly and frame the range honestly

**Availability/relocation questions:**

- Be specific: "4-6 weeks" not "as soon as possible"
- If EU citizen relocating within EU: mention it — removes friction
- End with an invitation to continue the conversation

---

## Candidate Context

When writing for Gustavo Rossich, always draw from these anchors:

**Primary technical anchor:**
Go REST API — 77K-92K req/sec, atomic zero-downtime deployments,
78.5% test coverage, complete Prometheus/Grafana/Loki observability
→ github.com/Giygas/medicaments-api

**Secondary technical anchors:**

- Python/FastAPI — PIX Exchange Rate Tracker, 80% test coverage,
  circuit breaker patterns → github.com/Giygas/pix-historial
- Full-stack — Garage V. Parrot, SvelteKit, PostgreSQL with RLS,
  95+ Lighthouse scores → github.com/Giygas/garage-parrot
- Mobile — Limon Agrio, React Native, 500+ Play Store downloads

**Background anchor (use sparingly, one sentence max):**
7 years French Foreign Legion — shapes reliability and
production systems mindset. Never elaborate beyond one sentence
unless the recruiter asks.

**Salary ranges (adjust based on role seniority and location):**

- Junior backend role, Spain/France: 40.000–44.000€
- Junior/medior backend role, Spain: 42.000–48.000€
- Senior or Go-specialist role: research market before responding

**Availability:**

- Currently in Toulon, France
- EU citizen — no visa or work permit friction within EU
- Relocation timeline: 4-6 weeks

---

## Rules — What to Write

- **One project per message** — the most relevant one to their stack
- **One GitHub link maximum** — with a one-sentence description
- **Specific to their stack** — mention their technology by name
- **Direct call to action** — end with an invitation, not a statement
- **Match their language** — French recruiter → French message,
  Spanish → Spanish, English → English
- **Match their tone** — informal LinkedIn message → informal reply,
  formal email → formal reply

---

## Rules — What Never to Write

### Banned opening phrases

- "I hope this message finds you well"
- "I came across your posting and"
- "I am very interested in"
- "I would love to"
- "I am passionate about"
- "I am excited about this opportunity"
- Any opener that could start any message to any recruiter

### Banned closing phrases

- "Thank you for considering my application"
- "Thank you for your time"
- "I look forward to hearing from you" (too passive)
- "Please don't hesitate to contact me"
- "I am available for an interview at your convenience"

### Banned content

- Metrics without context ("77K req/sec" with no benchmark note)
- Tech stack lists ("I know Go, Python, TypeScript, Docker, CI/CD...")
- Soft skill claims ("I am a fast learner", "team player", "motivated")
- Defensive statements about lack of experience as an opener
- Repeating resume content — link to it, don't summarize it
- More than one GitHub link — creates decision paralysis
- Salary as a single number — always a range

### Banned AI phrases (from anti-ai-writing.md)

- "aligns with my experience"
- "leveraging my skills"
- "resonates with"
- "motivated to contribute"
- "eager to bring value"

---

## Salary Response Rules

**Always provide a range** — single numbers invite lowballing.

**Acknowledge experience level honestly if entry-level:**

```
Considerando que es mi primer puesto profesional como
desarrollador, busco un rango de 40.000–44.000€ brutos
anuales, dependiendo del paquete y las responsabilidades.
```

**Never apologize for the range** — state it factually.

**Never say "I'm flexible"** — it signals you don't know your worth.

**After giving the range, move forward:**

```
Quedo disponible para una llamada cuando te venga bien.
```

---

## Relocation Response Rules

**Be specific about timeline** — "4-6 weeks" not "soon" or "ASAP".

**Mention EU citizenship proactively** — removes a common friction point
recruiters face with candidates from other countries.

**Don't over-explain** — one sentence covers it:

```
Soy ciudadano de la UE, por lo que la mudanza sería
sencilla — podría estar disponible en 4–6 semanas.
```

---

## Language and Tone Matching

**LinkedIn informal (emoji in their message):**
→ Match informal tone, short sentences, skip formal closing formula

**LinkedIn professional (no emoji, formal language):**
→ Match professional tone, slightly longer sentences acceptable

**Email formal:**
→ Use proper opening (Madame/Monsieur or equivalent)
→ Use proper closing formula for the language:

- French: "Cordialement," or "Je vous prie d'agréer..."
- Spanish: "Saludos," or "Atentamente,"
- English: "Best regards,"

**Never use formal closing formulas on LinkedIn** — they read as
copy-pasted from a letter template.

---

## Quick Scan Checklist

Before delivering any recruiter message:

- [ ] Under the length limit for the platform
- [ ] No banned opening phrases
- [ ] No banned closing phrases
- [ ] No tech stack list
- [ ] No soft skill claims
- [ ] Maximum one GitHub link with description
- [ ] Salary given as range with context (if applicable)
- [ ] Relocation timeline specific (if applicable)
- [ ] EU citizenship mentioned (if relocation involved)
- [ ] Language matches recruiter's message
- [ ] Tone matches recruiter's message
- [ ] Ends with a clear, non-pushy call to action
- [ ] No sentence transferable unchanged to a different recruiter
