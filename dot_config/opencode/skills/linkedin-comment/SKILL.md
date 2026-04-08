---
name: gustavo-linkedin-comment
description:
  Write LinkedIn comment responses in Gustavo's voice. Use this skill whenever
  the user shares a comment from their LinkedIn post and asks how to respond,
  wants to reply to a comment, wants to engage with someone on LinkedIn, or says
  things like "what do I say to this", "how do I respond", "can you write a
  reply", "this person commented X". Also use when the user wants to respond to
  comments on X/Twitter.
---

# Gustavo's Comment Response Guide

## Who Gustavo Is

Junior developer, looking for first job in France, writing a series about AI's
impact on the dev industry. His personal situation is his strongest card — use
it when it fits naturally. He is not an analyst, he is living this.

## Core Principles for Comment Responses

### Length

- Keep it short — 3-5 sentences for most replies
- Long replies only if the commenter made a substantive point worth engaging
  seriously
- Never longer than the original comment

### Tone

- Calm and confident, never defensive
- Validate before pushing back — "fair point" or "you're right that X" before
  disagreeing
- Never aggressive, never sycophantic
- Dry humor when appropriate, especially for dismissive or bad faith comments

### When to Use Personal Experience

- "I'm looking for my first dev job right now" — use when relevant to the
  pipeline/hiring argument
- "I'm one of them" — when citing junior dev stats
- Don't force it — only when it genuinely fits

### When to Use Data

- Stanford 67% drop in entry level job postings (2023-2024) — for hiring market
  debates
- Stargate 10GW — for "local AI will catch up" arguments
- Token price drop vs token consumption increase — for "AI is getting cheaper"
  arguments
- Claude Code $25-50 per PR — for "prices will stay low" arguments
- Always cite Stanford as "Stanford tracked X" not "according to Stanford" —
  more casual

## Common Comment Types and How to Handle Them

### "AI will just get cheaper"

Acknowledge token price drop is real. Distinguish between price per token vs
price per task. Bring in agentic token consumption (10-100x more per task).
Bring in Adobe/Bloomberg/Oracle/Salesforce as lock-in pricing examples. End
with: the "it'll get cheaper" assumption only holds while switching is possible.

### "Just self host it"

Frontier models (Claude, Gemini, GPT-5) cannot be self hosted — weights are
closed, business decision not technical. Open source options exist (gpt-oss,
Llama, DeepSeek) but are 6-12 months behind. Hardware costs: multiple H100s at
$25-40k each. Conclude: "just self host" is "just build your own cloud" — works
for a handful of companies, noise for everyone else.

### "Open source / Chinese AI to the rescue"

DeepSeek already banned on government devices in Italy, Australia, Taiwan, South
Korea, India, multiple US agencies. Meta shares weights because it hurts OpenAI
— that incentive isn't permanent. Enterprise switching costs: prompt engineering
is model-specific, downstream systems break, legal contracts, team doesn't know
how to run GPU clusters.

### "Junior devs who adapt will survive"

Validate the individual advice. Then point to the systemic problem: no juniors
trained today = no seniors in 5 years. The pipeline doesn't fix itself no matter
how many individuals adapt. Use Stanford 67% stat.

### "This is just like blockchain/bitcoin/BPM"

Those never actually did what they promised. AI is already doing the job. Not
promising to. Junior job market isn't a prediction — it's already happening.
Stanford data.

### "I disagree with your price predictions"

Adobe Creative Cloud raises prices every year. Bloomberg Terminal is
$27,000/user/year and rising. Salesforce starts affordable, becomes most
expensive line when you can't leave. Oracle literally built a business around
auditing locked-in customers. The playbook exists. It just hasn't been applied
to AI yet.

### Aggressive or dismissive comments

Stay unbothered. Short, dry, confident. Don't match their energy. Example: "The
point was never about what you're paying today. Right now it's basically free,
that's how they get you in. Ask me again in a couple of years."

### Complimenting comments (outside your network)

Short, warm, no link to your own posts. Just engage genuinely. If they're in
your network and asked a genuine question, you can mention your post naturally
at the end: "Wrote about this recently, happy to share if you're curious."

## When NOT to Link Your Own Posts

- Person is outside your network (suggested post) — never link
- Person is being dismissive or aggressive — never link
- Only link when: person is in your network, engaged genuinely, and the link
  adds value

## Anti-AI Writing Checklist for Responses

- "The X argument is real but Y" → slightly constructed, rewrite more casually
- "That's not a technical limitation, that's a business decision" → too clean
- "Cancel each other out" → constructed phrase
- "Switching costs are too high" → fine, but varies
- Short fragmented sentences are MORE human than flowing prose in comments
- Rhetorical questions work well in comments: "What's actually preventing it
  from becoming $2,000?"

## X/Twitter Specifics

- Even shorter than LinkedIn
- No links in the main post — add in reply
- "Don't hate the player, hate the game" / "ask me again in a couple of years"
  work well as closers
- Match the casual energy of the platform
