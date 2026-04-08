---
name: technical-translation
description: Translate technical documents (resumes, cover letters, portfolios) to French and Spanish with full linguistic and cultural accuracy. Handles professional register, local conventions, false friends, untranslatable tech terms, and market-specific formatting rules. Apply when asked to translate any professional or technical document.
license: MIT
compatibility: opencode
metadata:
  audience: personal
  workflow: resume-writing, job-applications, translation
---

# Technical Document Translation Guide

Translates professional and technical documents to French and Spanish with linguistic precision, cultural accuracy, and market-appropriate conventions. This is not a word-for-word translation skill — it is a professional localization skill.

---

## Core Translation Philosophy

**Localize, don't just translate.**

A resume translated word-for-word reads as foreign. The goal is a document that a native speaker would read as having been written originally in their language by a professional who understands local norms.

**Three-pass approach:**

1. **Accuracy pass** — correct meaning, no omissions, no additions
2. **Naturalness pass** — rewrite awkward literal translations into idiomatic phrasing
3. **Convention pass** — apply local formatting, register, and market rules

---

## French Translation Rules

### Register and Tone

- Use **formal "vous" register** throughout — never "tu" in professional documents
- French professional writing is **more formal than English** — avoid contractions, casual connectors, and colloquialisms
- Cover letters in French follow a **strict epistolary tradition** — they are not informal pitches
- Avoid Anglicisms where a French equivalent exists — but see Tech Terms section below

### Grammar Rules for Technical Documents

**Gender agreement:**

- Job titles must agree with the candidate's gender
- Male: "Développeur Full-Stack", "Ingénieur Logiciel"
- Female: "Développeuse Full-Stack", "Ingénieure Logicielle"
- When gender is unknown or neutral context: use masculine as default OR use inclusive writing ("Développeur·euse") — note which convention is used

**Capitalization:**

- French uses far less capitalization than English
- Job titles are NOT capitalized mid-sentence: "je suis développeur backend" not "Développeur Backend"
- Section headers in resumes: capitalize first word only ("Compétences techniques" not "Compétences Techniques")
- Languages and nationalities: lowercase in French ("français", "anglais", not "Français", "Anglais")
- Months: lowercase ("janvier 2025", not "Janvier 2025")

**Punctuation:**

- French uses spaces before certain punctuation: ` :`, ` ;`, ` !`, ` ?`
- Correct: `Compétences : Go, Python`
- Wrong: `Compétences: Go, Python`
- Quotation marks: « guillemets » not "English quotes"
- Numbers: use space as thousands separator — `77 000` not `77,000`
- Decimals: use comma — `78,5%` not `78.5%`

**Dates:**

- French format: `janvier 2025` (month lowercase, no abbreviation)
- Date ranges: `janvier 2025 – présent` (en dash, not hyphen)
- Never use numeric-only dates (01/2025) in professional documents

### French Resume Conventions

**Structure differences from English:**

- French resumes (CV) traditionally include: age or date of birth, nationality, and sometimes a photo — though modern tech CVs are moving away from this
- For tech roles targeting modern companies: omit photo, omit date of birth, include nationality only as "Nationalité : Argentine / Citoyenneté UE"
- Address format if included: number + street, postal code + city (e.g., `12 rue de la Paix, 83000 Toulon`)

**Section headers (standard French CV):**

- "Résumé professionnel" or "Profil" (not "Summary")
- "Expérience professionnelle" (not "Work Experience")
- "Compétences techniques" (not "Technical Skills")
- "Projets personnels" or "Projets" (not "Projects")
- "Formation" (not "Education")
- "Certifications" (same)
- "Langues" (not "Languages")

**Degree equivalences:**

- BAC+2 = BTS, DUT (2 years post-bac)
- BAC+3 = Licence, Bachelor (3 years post-bac)
- BAC+5 = Master, Ingénieur (5 years post-bac)
- Always include the RNCP level if the degree has one (e.g., "Titre RNCP Niveau 6")
- HETIC: "Titre RNCP — Concepteur Développeur de Solutions Digitales (Bac+3, Niveau 6)"

### French Cover Letter (Lettre de Motivation) Rules

**Mandatory structure:**

```
[City], le [date in full: 18 février 2026]

Objet : Candidature au poste de [exact job title]

Madame, Monsieur,

[Body — 3 paragraphs]

Cordialement,
[Name]
```

**Paragraph structure:**

- §1: Why this company (show you know them specifically — not generic)
- §2: What you bring (your technical value, with evidence)
- §3: Call to action (entretien, disponibilité)

**Closing formulas by formality level:**

- Standard: `Cordialement,` (2 spaces after comma, then newline, then name)
- More formal: `Dans l'attente de votre réponse, veuillez agréer, Madame, Monsieur, l'expression de mes salutations distinguées,`
- Tech startups: `Cordialement,` is always appropriate — never use the long formula for modern companies

**Length:** 300-350 words for French companies (see agents.md for full guidance)

### French Tech Terminology

**Keep in English (industry standard in France):**

- All programming languages: Go, Python, TypeScript, JavaScript
- Frameworks: SvelteKit, Nuxt, React Native, FastAPI, Django
- Tools: Docker, GitHub, Prometheus, Grafana
- Methodologies: Agile, Scrum, CI/CD, DevOps
- Common terms: API, backend, frontend, full-stack, framework, bug, commit, deploy

**Translate to French:**

- "software engineer" → "ingénieur logiciel" or "développeur logiciel"
- "test coverage" → "couverture de tests"
- "zero-downtime deployment" → "déploiement sans interruption de service"
- "rate limiting" → "limitation de débit"
- "load balancing" → "équilibrage de charge"
- "throughput" → "débit" (in performance context)
- "latency" → "latence"
- "benchmark" → "benchmark" (kept in French tech writing)
- "open source" → "open source" (kept)
- "pull request" → "pull request" (kept)

**False friends to watch:**

- "actually" ≠ "actuellement" (actuellement = currently)
- "eventually" ≠ "éventuellement" (éventuellement = possibly)
- "experience" in French is uncountable in some contexts: "j'ai de l'expérience en" not "j'ai une expérience en"
- "formation" in French means education/training, not the English "formation"
- "stage" in French means internship, not a performance stage

---

## Spanish Translation Rules

### Register and Tone

- Use **formal "usted" register** for cover letters and formal documents
- Resume bullet points: use **infinitive verb form** ("Desarrollar APIs", "Implementar pruebas") OR **past tense** ("Desarrollé", "Implementé") — pick one and be consistent
- Latin American Spanish vs. Spain Spanish: see regional section below
- Avoid direct calques from English — Spanish has rich professional vocabulary

### Grammar Rules for Technical Documents

**Gender agreement:**

- Job titles agree with candidate gender
- Male: "Desarrollador Full-Stack", "Ingeniero de Software"
- Female: "Desarrolladora Full-Stack", "Ingeniera de Software"
- Inclusive: "Desarrollador/a" or "Desarrolladore" (less common in professional docs)

**Capitalization:**

- Similar to French — less capitalization than English
- Job titles lowercase mid-sentence: "soy desarrollador backend"
- Section headers: capitalize first word only
- Languages/nationalities: lowercase ("francés", "inglés", "español")
- Months: lowercase ("enero", "febrero")

**Punctuation:**

- No space before `:`, `;`, `?`, `!` (unlike French)
- Inverted opening marks: `¿Cómo...?` and `¡Esto...!`
- Numbers: period as thousands separator in Spain (`77.000`), comma in Latin America (`77,000`) — or use space universally for documents targeting both
- Decimals: comma in Spain (`78,5%`), period in Latin America (`78.5%`) — check target market

**Dates:**

- Format: `enero de 2025` (month lowercase + "de")
- Or: `18 de febrero de 2026`
- Date ranges: `enero 2025 – presente`

### Regional Differences (Spain vs. Latin America)

**For French job market applications (targeting Argentina/Latin America):**

- Use Latin American Spanish conventions
- "vos" is used in Argentina but avoid in professional documents — use "usted"
- Decimal: period (`78.5%`)
- "Computación" (Latin America) vs. "Informática" (Spain) for CS field
- "Celular" (Latin America) vs. "Móvil" (Spain) for mobile
- "Aplicación" or "app" for both

**For Spain job market:**

- "Informática" or "Tecnología" for the field
- "Móvil" for mobile development
- "Ordenador" vs. "computadora/computador" (Latin America)

**For documents targeting both markets:** Use neutral Latin American Spanish and avoid Spain-specific terms.

### Spanish Resume Conventions

**Section headers (standard Spanish CV):**

- "Perfil profesional" or "Resumen" (not "Summary")
- "Experiencia profesional" (not "Work Experience")
- "Habilidades técnicas" or "Competencias técnicas"
- "Proyectos" (not "Projects")
- "Formación académica" or "Educación"
- "Certificaciones"
- "Idiomas"

**Degree equivalences for Spanish market:**

- Reference international equivalences where known
- Argentine degrees: "Licenciatura" (4-5 years), "Tecnicatura" (2-3 years)
- Spanish degrees: "Grado" (4 years), "Máster" (1-2 years post-grado)
- For HETIC: "Título RNCP — Concepteur Développeur de Solutions Digitales (equivalente a Grado universitario, Nivel 6 europeo)"

### Spanish Cover Letter Rules

**Structure:**

```
[City], [date: 18 de febrero de 2026]

Asunto: Candidatura para el puesto de [exact job title]

Estimado/a Sr./Sra. [Name] / Estimado equipo de [Company]:

[Body]

Atentamente,
[Name]
```

**Closing formulas:**

- Standard: `Atentamente,`
- Formal: `En espera de su respuesta, le saluda atentamente,`
- Modern tech companies: `Un cordial saludo,`

**Length:** 250-300 words for Spanish-language applications

### Spanish Tech Terminology

**Keep in English (industry standard):**

- Same as French list: all languages, frameworks, tools
- "DevOps", "CI/CD", "API", "backend", "frontend", "full-stack"
- "benchmark", "deploy", "commit", "pull request"

**Translate to Spanish:**

- "software engineer" → "ingeniero de software" or "desarrollador de software"
- "test coverage" → "cobertura de pruebas"
- "zero-downtime deployment" → "despliegue sin tiempo de inactividad"
- "rate limiting" → "limitación de velocidad" or "control de tasa"
- "throughput" → "rendimiento" or "capacidad de procesamiento"
- "latency" → "latencia"
- "load balancing" → "balanceo de carga"
- "middleware" → "middleware" (kept)
- "open source" → "código abierto" (translate this one)
- "self-taught" → "autodidacta"

**False friends to watch:**

- "actually" ≠ "actualmente" (actualmente = currently)
- "eventually" ≠ "eventualmente" (eventualmente = possibly, by chance)
- "resume" (the document) = "currículum" or "CV" (never "resumen" in this context)
- "experience" = "experiencia" ✓ (no false friend here)
- "library" (code) = "librería" or "biblioteca" depending on region

---

### Bullet Point Style for CV/Resume Entries

**Preferred (most natural):** Noun-led construction

- French: "Conception d'une API RESTful..."
- Spanish: "Desarrollo de una API RESTful..."

**Acceptable (modern tech CVs):** Infinitive form

- French: "Construire une API RESTful..."
- Spanish: "Desarrollar una API RESTful..."

**Avoid:** Bare past participle (French) or repeated preterite
verbs (Spanish) — both read as direct translations of English
resume conventions rather than natively written documents.

❌ French: "Construit API RESTful..." (incomplete sentence)
❌ Spanish: "Desarrollé API RESTful..." (grammatically fine
but reads as mechanical translation)
✅ French: "Conception d'une API RESTful..."
✅ Spanish: "Desarrollo de una API RESTful..."

---

## Candidate-Specific Translation Notes

### Names and Proper Nouns — Never Translate

- Gustavo Rossich — never translate or modify
- 1st Foreign Cavalry Regiment → "1er Régiment Étranger de Cavalerie" (French) / "1.° Regimiento Extranjero de Caballería" (Spanish)
- HETIC — keep as-is in all languages
- All project names: Medicaments API, PIX Exchange Rate Tracker, Garage V. Parrot, Limon Agrio, Rapillama — keep as-is

### Metrics — Language-Specific Formatting

- `77K-92K req/sec` → French: `77 000–92 000 req/s` | Spanish (Latin America): `77.000–92.000 req/s`
- `78.5%` → French: `78,5 %` (space before %) | Spanish Spain: `78,5 %` | Spanish Latin America: `78.5%`
- Always preserve environment context in all languages

### Military Background Translation

- "Pilote VBL" — keep in French (it's already French); Spanish: "Conductor/Piloto de VBL (Vehículo Blindado Ligero)"
- "Auxiliaire Sanitaire" — French: keep; Spanish: "Auxiliar Sanitario"
- "Foreign Legion" context: well-known internationally, no translation needed for the institution name

---

## Output Format

When translating a document, always output:

1. **Target language version** — the full translated document
2. **Translation notes** — a brief list of:
   - Non-obvious translation choices made and why
   - Terms kept in English and why
   - Any ambiguities where multiple valid translations exist
   - Regional variants chosen (if applicable)

**Example translation note format:**

```
Translation Notes:
- "full-stack" kept in English — standard term in [FR/ES] tech market
- "développeur" used (masculine) — adjust to "développeuse" if needed
- Decimal format changed to French convention: 78,5%
- "1er Régiment Étranger de Cavalerie" used — official French name of unit
```

---

## Quality Checks Before Finalizing

- [ ] Gender agreement consistent throughout
- [ ] Capitalization follows target language rules (not English rules)
- [ ] Punctuation spacing correct (French: space before : ; ! ?)
- [ ] Numbers formatted for target locale (decimals, thousands)
- [ ] Dates in full text format, not numeric
- [ ] Tech terms kept in English where industry-standard
- [ ] False friends checked and corrected
- [ ] Register is formal throughout (vous/usted)
- [ ] Closing formula appropriate for document type and company culture
- [ ] Proper nouns and project names unchanged
- [ ] Metric environment context preserved from original
- [ ] **Article check (French & Spanish)**: Resume bullets omit  
       articles in English but French and Spanish require them.  
       Before finalizing, scan every bullet for:  
       - Missing definite articles (le, la, les / el, la, los, las)  
       - Missing indefinite articles (un, une / un, una)  
       - Missing partitive constructions (du, de la / del, de la)

      Common patterns to check:
      ❌ "réduisant bande passante de 80%"
      ✅ "réduisant la bande passante de 80%"
      ❌ "mantenimiento de huella de memoria"
      ✅ "mantenimiento de una huella de memoria"
      ❌ "Logro de 78,5% cobertura de pruebas"
      ✅ "Logro de una cobertura de pruebas del 78,5%"

- [ ] **Verb variety check**: Scan bullet openings for repeated  
       noun-led constructions using the same word back to back  
       (e.g., two consecutive "Desarrollo de..." bullets).  
       Vary using synonyms:  
       - French: Conception / Développement / Mise en place /  
       Déploiement / Implémentation / Création / Obtention  
       - Spanish: Desarrollo / Construcción / Implementación /  
       Diseño / Despliegue / Creación / Integración
