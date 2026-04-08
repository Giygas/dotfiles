---
name: anti-ai-writing
description: Prevents AI-sounding phrases in professional writing. Apply automatically when generating cover letters, webform responses, professional summaries, or any candidate-facing document. Scan all output for banned phrases before delivering.
license: MIT
compatibility: opencode
metadata:
  audience: personal
  workflow: resume-writing, job-applications, cover-letters
---

# Anti-AI Writing Rules

Apply these rules to every cover letter, webform response, and professional
summary before outputting. Scan the complete text for banned phrases.
If any are found, rewrite the sentence from scratch — do not just
replace the banned phrase with a synonym.

---

## Banned Connector Phrases

These phrases signal AI-generated text immediately:

- "aligns perfectly with"
- "aligns with my experience"
- "aligns with my background"
- "resonates with"
- "leveraging my skills"
- "leveraging my experience"
- "utilizing my experience"
- "I am passionate about"
- "I am excited to"
- "I would love to"
- "I am eager to"
- "this opportunity"
- "take ownership of"
- "take this opportunity"
- "I am thrilled"
- "I am delighted"

**Why these fail**: They are abstract bridges between two things
that should connect directly. Remove the connector and make the
connection explicit instead.

❌ "My experience with Go aligns perfectly with your backend requirements"
✅ "Your backend runs on Go — I've built production APIs in Go
that handle 77K-92K req/sec, so I can contribute immediately
rather than spending the first month learning the language"

---

## Banned Closing Patterns

These closings signal the writer is thinking about what they
will receive from the company, not what they will contribute:

- "learning from a talented team"
- "continue growing as an engineer"
- "contribute to your mission"
- "be part of your journey"
- "join your exciting team"
- "grow in a dynamic environment"
- Any sentence where the subject is what YOU will gain
- "Thank you for considering my application"
- "Thank you for your time and consideration"
- Any sentence starting with "Thank you for" as a closing

**Replace with**: What you want to BUILD or SOLVE there specifically.

❌ "I look forward to learning from your talented team and
growing as an engineer"
✅ "I want to be working on the data extraction reliability
problem — that's the kind of engineering challenge where
the decisions made in week one determine whether the
product works at scale"

---

## Banned Empty Claims

These words add length without adding information:

- "problem-solving skills"
- "strong communication skills"
- "attention to detail" (without a specific example)
- "results-driven"
- "hard-working"
- "passionate" (about anything)
- "motivated"
- "dynamic"
- "innovative"
- "revolutionize" (echoing company marketing back at them)
- "synergy" / "leverage" / "impactful"
- "team player" / "collaborative" (without evidence)
- "quick learner" (show it instead)

**Replace with**: A specific example, metric, or concrete observation.

❌ "I am a results-driven developer with strong problem-solving skills"
✅ "When the Medicaments API search was too slow, I traced it to
runtime string normalization and eliminated it through
pre-computed data structures — 170x allocation reduction,
measurable before and after"

---

## Banned Marketing Echo

Never repeat the company's own marketing language back at them.
It reads as flattery, not understanding.

❌ "I want to help Joko revolutionize the shopping experience"
(echoes their own tagline)
✅ "I want to work on the data extraction and comparison problem —
getting reliable structured data from e-commerce sites at scale
is genuinely hard, and that's the part that interests me"

---

## The Specificity Test

Before finalizing any sentence, ask:

**Could this sentence appear unchanged in an application
to a completely different company?**

If yes → it is too generic. Rewrite it to name something
specific about this company, this role, or this person's
actual background.

Every paragraph should contain at least one element that
could not appear in any other application.

---

## The Closing Test

Before finalizing the last paragraph, ask:

**Is the final thought about what I want to BUILD
or about what I want to RECEIVE?**

Good closings end on contribution, not aspiration.
The reader should finish thinking "this person wants
to solve our problem" not "this person wants a job."

---

## Em Dash Usage

Em dashes (—) are not an AI tell on their own.
One per paragraph is fine. Two or more per paragraph
signals AI overuse — rewrite to reduce.

---

## Quick Scan Checklist

Before delivering any cover letter or webform response:

- [ ] No banned connector phrases (aligns with, resonates with, leveraging)
- [ ] No banned closing patterns (learning from, growing as, contribute to your mission)
- [ ] No empty claim adjectives (passionate, results-driven, innovative)
- [ ] No company marketing language echoed back
- [ ] Every paragraph passes the specificity test
- [ ] Final paragraph passes the closing test
- [ ] Maximum one em dash per paragraph
- [ ] No sentence starts with "I am excited/thrilled/delighted"
