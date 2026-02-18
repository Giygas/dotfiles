---
name: resume-writing-guide
description: Write ATS-optimized resumes that get interviews. Based on data showing exact job title matching increases callbacks 10.6x, proper keyword density (25-35 keywords), quantified achievements, and modern ATS compatibility. Use for creating or reviewing resumes for any industry or experience level.
license: MIT
compatibility: opencode
metadata:
  audience: job-seekers, career-changers, students
  workflow: resume-writing, job-applications, career-development
---

# Resume Writing Guide - Get More Interviews

A data-driven guide to writing resumes that pass ATS screening and get you interview callbacks. Based on research showing specific techniques can increase interview rates by up to 10.6x.

## Quick Start

Ask your AI agent:

```
Use the resume-writing-guide to create an ATS-optimized resume for [job title]
```

```
Use the resume-writing-guide to review my resume and suggest improvements
```

## The Data: What Actually Works

### Critical Finding #1: Exact Job Title Matching (10.6x Impact)

**The single biggest factor:** Resumes that matched the exact job title from the posting in their header/summary got callbacks at **10.6 times the rate** of resumes that didn't.

Not a synonym. Not a creative interpretation. **The exact title.**

**Examples:**

```
❌ BAD:
Job Posting: "Senior Product Manager"
Your Resume: "Product Lead" or "Head of Product Strategy"

✅ GOOD:
Job Posting: "Senior Product Manager"
Your Resume: "Senior Product Manager"
```

**Why it works:**

- 99.7% of recruiters use keyword filters in ATS
- ATS keyword matching is largely literal
- If the ATS searches for "Senior Product Manager" and you wrote "Product Lead," you won't appear in results

**How to implement:**

```markdown
# Your Resume Header

John Smith
Senior Product Manager ← Exact match from job posting
john.smith@email.com | (555) 123-4567 | LinkedIn.com/in/johnsmith
```

### Critical Finding #2: Keyword Sweet Spot (25-35 Keywords)

**The magic number:** Resumes need 25-35 relevant, role-specific keywords to consistently score above 80% in ATS matching.

- **Below 25:** You're not surfacing in enough recruiter searches
- **Above 35:** You start tripping keyword-stuffing detectors (83% of companies now use AI-assisted screening)

**What counts as a keyword:**

- Technical skills (Python, Salesforce, AWS)
- Job-specific terms (project management, budget forecasting, user research)
- Tools and software (Adobe Creative Suite, Tableau, JIRA)
- Certifications (PMP, CPA, AWS Certified)
- Industry terms (Agile methodology, SEO, compliance)

**How to find keywords:**

1. **Read the job posting carefully** - Look for:
   - Required skills
   - Preferred qualifications
   - Responsibilities
   - Tools mentioned
   - Repeated terms (if mentioned 3+ times, it's important)

2. **Use exact phrases** - Don't use synonyms or abbreviations unless the posting uses them
   - "Adobe Creative Cloud" ≠ "Adobe Creative Suite" (different strings to parser)
   - "Project Management" ≠ "PM" (unless posting uses "PM")

3. **Include both forms when appropriate:**
   - "Enterprise Resource Planning (ERP)"
   - "Master of Business Administration (MBA)"
   - "Search Engine Optimization (SEO)"

**Example - Keyword Analysis:**

```
Job Posting: "Senior Data Analyst"

Keywords to include (naturally):
1. Data analysis
2. SQL
3. Python
4. Tableau
5. Data visualization
6. Statistical analysis
7. A/B testing
8. Dashboard creation
9. Stakeholder communication
10. Business intelligence
... up to 25-35 total
```

**Where to place keywords:**

- Professional summary (5-8 keywords)
- Skills section (10-15 keywords)
- Work experience (10-15 keywords, naturally woven)

**❌ Don't do this:**

- White text keyword stuffing (AI screening flags it)
- Keyword cramming in unnatural sentences
- Copy-pasting job description

**✅ Do this:**

- Weave keywords naturally into achievement statements
- Use exact terms from job posting
- Place keywords where they make contextual sense

### Critical Finding #3: Date Format Consistency

**Weird but true:** Inconsistent date formats caused ATS systems to miscalculate total experience.

**Example of the problem:**

- "Jan 2019" (Role 1)
- "2019-01" (Role 2)
- "January '19" (Role 3)

→ System calculated 3 years of experience when candidate had 8 years

**Solution:** Pick ONE format and use it everywhere.

**Most reliable format:** "Month Year" (e.g., "Jan 2020 - Mar 2023")

**✅ GOOD:**

```
Senior Developer
ABC Company | Jan 2020 - Present

Software Engineer
XYZ Corp | Mar 2017 - Dec 2019

Junior Developer
Tech Startup | Jun 2015 - Feb 2017
```

**❌ BAD (inconsistent):**

```
Senior Developer
ABC Company | 01/2020 - Present

Software Engineer
XYZ Corp | March 2017 - 12/2019

Junior Developer
Tech Startup | 06/15 - February '17
```

### Critical Finding #4: File Format (.docx wins)

**.docx parsed reliably across EVERY system tested.**

**PDFs had edge cases:**

- Scanned documents
- Certain export settings
- Embedded fonts that broke parsing

**The rule:**

- Keep a .docx master version
- Only use PDF when the application specifically requests it

**How to save properly:**

1. Create in Microsoft Word or Google Docs
2. Save as .docx (Word 2007+ format)
3. Test by opening in a different computer to ensure compatibility
4. If PDF required, use "Save as PDF" from Word (text-based, not scanned)

## Core ATS Resume Structure

### The Template

Use this proven structure:

```
[YOUR NAME]
[Exact Job Title from Posting]
Phone | Email | LinkedIn | Location (City, State)

PROFESSIONAL SUMMARY
2-3 sentences highlighting your experience, key skills (5-8 keywords), and value proposition.

SKILLS
• Skill 1 (keyword)    • Skill 2 (keyword)    • Skill 3 (keyword)
• Skill 4 (keyword)    • Skill 5 (keyword)    • Skill 6 (keyword)
[10-15 skills total, matching job posting]

WORK EXPERIENCE

Job Title | Company Name | City, State | Month Year - Month Year
• Achievement with quantifiable result (Action verb + what you did + measurable impact)
• Achievement with quantifiable result
• Achievement with quantifiable result
[3-5 bullets per role]

Job Title | Company Name | City, State | Month Year - Month Year
• Achievement with quantifiable result
• Achievement with quantifiable result
• Achievement with quantifiable result

EDUCATION

Degree Name, Major | University Name | City, State | Graduation Year
• Relevant honors, GPA (if >3.5), relevant coursework

CERTIFICATIONS (if applicable)
• Certification Name | Issuing Organization | Year
```

### Section-by-Section Breakdown

#### 1. Header / Contact Information

**Put this in the body, NOT in header/footer** (ATS often can't read headers/footers)

```
✅ GOOD:
John Smith
Senior Product Manager
john.smith@email.com | (555) 123-4567 | linkedin.com/in/johnsmith | San Francisco, CA

❌ BAD (in Word header):
[Header section with name and contact info]
```

**What to include:**

- Full name
- Exact job title from posting
- Phone number (no weird formatting, just digits)
- Professional email (firstname.lastname@email.com)
- LinkedIn URL (customize it!)
- City and State (no full address needed)

**What NOT to include:**

- Photo (causes ATS issues, potential bias)
- Full street address (privacy concern)
- Unprofessional email (partyguy99@hotmail.com)
- Multiple phone numbers
- Personal website (unless relevant to job)

#### 2. Professional Summary

**Purpose:** Hook the reader in 2-3 sentences with your value proposition.

**Formula:** [Job Title] + [Years of Experience] + [Key Skills] + [Value/Achievement]

**Length:** 2-3 sentences, 50-70 words

**Include:** 5-8 keywords from job posting

**Examples:**

```
✅ GOOD (Data Analyst):
Data Analyst with 5+ years of experience transforming complex datasets into actionable business insights. Expertise in SQL, Python, Tableau, and statistical analysis. Proven track record of improving decision-making through data visualization and A/B testing, resulting in 20% increase in operational efficiency.

✅ GOOD (Marketing Manager):
Results-driven Marketing Manager with 7 years of experience leading digital campaigns and brand strategy. Skilled in SEO, content marketing, Google Analytics, and marketing automation. Successfully increased lead generation by 150% and reduced customer acquisition costs by 30% through data-driven strategies.

❌ BAD (too generic):
Experienced professional seeking challenging opportunities to leverage my skills and grow in a dynamic environment.

❌ BAD (no keywords):
I am a dedicated worker with excellent communication skills and a passion for helping others achieve their goals.
```

#### 3. Skills Section

**Format:** Simple list, no bars/charts/graphics

**Number of skills:** 10-15 (part of your 25-35 keyword total)

**Types of skills to include:**

- Hard skills (technical abilities, tools, software)
- Industry-specific skills
- Certifications (if relevant)

**How to organize:**

```
✅ GOOD (clean, scannable):
SKILLS
• Python        • SQL           • Tableau        • Data Visualization
• A/B Testing   • R             • Excel          • Statistical Analysis
• Machine Learning  • ETL        • Power BI       • Predictive Modeling

✅ GOOD (categorized, if many skills):
TECHNICAL SKILLS
Programming: Python, R, SQL, JavaScript
Tools: Tableau, Power BI, Excel, JIRA, Git
Cloud: AWS, Azure, Google Cloud Platform

❌ BAD (graphics):
Python     ████████░░ 80%
SQL        ██████████ 100%
[Charts and bars confuse ATS]

❌ BAD (vague):
• Good communication
• Team player
• Problem solver
[These are not searchable skills]
```

**Pro tip:** Mirror the exact skill names from the job posting

- If they say "Microsoft Excel," don't just write "Excel"
- If they say "Salesforce CRM," include "CRM" in your phrasing

#### 4. Work Experience

**Format:** Reverse chronological (most recent first)

**Structure per role:**

```
Job Title | Company Name | City, State | Month Year - Month Year
• Achievement bullet 1
• Achievement bullet 2
• Achievement bullet 3
```

**Number of bullets:** 3-5 per role (focus on most recent roles)

**The Achievement Formula:**

**[Action Verb] + [What You Did] + [Measurable Result]**

**Example transformation:**

```
❌ BEFORE (responsibility):
Responsible for managing social media accounts.

✅ AFTER (achievement):
Managed social media strategy across 5 platforms, increasing engagement by 150% and growing follower base from 5K to 45K in 12 months.
```

**Quantify EVERYTHING possible:**

- Money: revenue, costs, savings, budget
- Time: reduced by X%, completed in X days
- People: team size, customers served, users reached
- Scale: number of projects, accounts, transactions
- Percentages: growth, improvement, efficiency gains

**Achievement Examples by Function:**

**Sales:**

```
• Exceeded annual quota by 145%, generating $2.3M in new revenue and securing 23 enterprise clients
• Grew territory from $0 to $1.8M in sales within first year, ranking #2 among 35-person national sales team
• Reduced sales cycle by 30% through implementation of automated lead scoring system
```

**Marketing:**

```
• Increased website traffic by 250% through SEO optimization and content strategy, generating 500+ qualified leads monthly
• Launched email marketing campaign that achieved 45% open rate (15% above industry average) and 12% conversion rate
• Managed $500K annual marketing budget across 8 channels, achieving 3:1 ROI
```

**Software Engineering:**

```
• Architected and deployed microservices platform handling 10M+ daily requests with 99.9% uptime
• Reduced page load time by 60% through code optimization and caching strategies, improving user retention by 25%
• Led team of 5 engineers to deliver product feature 2 weeks ahead of schedule, resulting in $200K additional revenue
```

**Project Management:**

```
• Managed $2M infrastructure project, delivering 3 weeks ahead of schedule and $150K under budget
• Coordinated cross-functional team of 15 across 4 departments to launch new product line, achieving $5M in first-year sales
• Implemented Agile methodology, reducing project delivery time by 40% and increasing team productivity by 35%
```

**Customer Service:**

```
• Maintained 98% customer satisfaction rating while handling 90+ support tickets daily
• Reduced average response time from 24 hours to 4 hours, improving customer retention by 15%
• Trained and mentored team of 8 new representatives, resulting in 20% improvement in team performance metrics
```

**Operations:**

```
• Streamlined supply chain process, reducing delivery time by 35% and cutting costs by $200K annually
• Implemented inventory management system that decreased stock discrepancies by 90% and improved accuracy to 99.5%
• Led process improvement initiative that increased operational efficiency by 45% and reduced errors by 60%
```

**How to find numbers when you "don't have any":**

1. **Estimate conservatively** - "Handled 20-30 customer inquiries daily"
2. **Use percentages** - "Improved process efficiency by approximately 25%"
3. **Count things** - "Managed portfolio of 15 client accounts"
4. **Use time** - "Completed projects 2 weeks ahead of deadline on average"
5. **Compare before/after** - "Reduced processing time from 3 days to 1 day"
6. **Look at old emails/reports** - Often contain metrics you forgot
7. **Ask former colleagues** - They might remember numbers

**Action Verbs to Start Bullets:**

**Leadership:** Led, Directed, Managed, Supervised, Coordinated, Spearheaded
**Achievement:** Achieved, Exceeded, Surpassed, Delivered, Accomplished, Generated
**Improvement:** Increased, Improved, Enhanced, Optimized, Streamlined, Boosted
**Creation:** Developed, Created, Designed, Built, Established, Launched
**Analysis:** Analyzed, Evaluated, Assessed, Researched, Identified, Investigated
**Cost Savings:** Reduced, Decreased, Cut, Saved, Eliminated, Minimized

**❌ Avoid weak verbs:** Helped, Assisted, Was responsible for, Worked on

#### 5. Education

**Format:**

```
Degree Name, Major | University Name | City, State | Graduation Year
• GPA: 3.8/4.0 (only if >3.5)
• Relevant coursework: [if recent grad]
• Honors: Dean's List, Magna Cum Laude, etc.
```

**Examples:**

```
✅ GOOD:
Bachelor of Science, Computer Science | Stanford University | Stanford, CA | 2020
• GPA: 3.9/4.0, Magna Cum Laude
• Relevant Coursework: Machine Learning, Data Structures, Algorithms, Database Systems

✅ GOOD (experienced professional):
Master of Business Administration (MBA) | Harvard Business School | Boston, MA | 2015
Bachelor of Arts, Economics | UCLA | Los Angeles, CA | 2010

❌ BAD (too much detail for experienced professional):
Bachelor of Science in Business Administration, Major in Finance
University of Texas at Austin | Austin, TX | May 2008
GPA: 3.2/4.0
Coursework: Financial Accounting, Microeconomics, Business Statistics...
[Keep it concise if you have 5+ years experience]
```

**Placement:**

- Recent grads: Put Education near the top, after Summary
- Experienced professionals: Put Education after Work Experience

#### 6. Certifications (if applicable)

```
CERTIFICATIONS
• Project Management Professional (PMP) | PMI | 2023
• AWS Certified Solutions Architect | Amazon Web Services | 2022
• Certified Public Accountant (CPA) | State of California | 2020
```

**Include if:**

- Required or preferred in job posting
- Industry-standard (CPA, PMP, CFA, etc.)
- Technical certifications (AWS, Google Cloud, etc.)
- Recent and relevant

**Don't include:**

- Expired certifications
- Irrelevant certifications
- "Certificates of completion" from online courses (unless specifically requested)

## Formatting Rules for ATS

### ✅ DO:

**Layout:**

- Single-column layout
- Left-aligned text
- Standard margins (0.5" - 1")
- Consistent spacing throughout

**Fonts:**

- Arial, Calibri, Helvetica, or Times New Roman
- 10-12pt for body text
- 14-16pt for your name
- No decorative fonts

**Sections:**

- Use standard headers: "Work Experience," "Education," "Skills"
- Don't get creative: "My Journey" or "Where I've Been" confuses ATS

**Dates:**

- Consistent format: "Month Year - Month Year"
- Example: "Jan 2020 - Present"

**File:**

- Save as .docx
- Filename: "FirstName_LastName_Resume.docx"

### ❌ DON'T:

**Avoid completely:**

- Tables (ATS struggles with them)
- Columns (text may be read in wrong order)
- Text boxes (often not parsed)
- Headers/footers (ATS usually skips them)
- Images, photos, logos
- Icons (◆ ✓ ★)
- Charts, graphs, skill bars
- Horizontal lines between sections
- Fancy bullet points (stick to • or -)

**Don't use:**

- Creative section names ("My Superpowers" instead of "Skills")
- Abbreviations without spelling out first (unless job posting uses them)
- Pronouns (I, me, my) - use implied subject
- Paragraphs instead of bullets for experience
- Fancy page numbers or watermarks

## Tailoring Your Resume for Each Job

**You MUST tailor your resume for each application.** One-size-fits-all doesn't work in 2025.

### 15-Minute Tailoring Process:

**Step 1: Analyze the job posting (5 minutes)**

1. Highlight required skills
2. Note the exact job title
3. Identify keywords mentioned 3+ times
4. Look for specific tools/software mentioned
5. Note the company's language (formal vs casual)

**Step 2: Adjust your resume (10 minutes)**

1. Change your resume header to match exact job title
2. Update Professional Summary to include 5-8 keywords from posting
3. Reorder Skills section to put job's top requirements first
4. Emphasize relevant achievements in Work Experience
5. Add any missing keywords naturally into experience bullets
6. Ensure 25-35 keyword total from job posting

**Example:**

```
Job Posting A: "Marketing Manager - B2B SaaS"
→ Your Header: "Marketing Manager"
→ Keywords to emphasize: B2B, SaaS, Lead Generation, Marketing Automation

Job Posting B: "Digital Marketing Manager - E-commerce"
→ Your Header: "Digital Marketing Manager"
→ Keywords to emphasize: E-commerce, Digital Marketing, SEO, Conversion Optimization
```

## Testing Your Resume

### ATS Compatibility Checklist:

- [ ] Saved as .docx (unless PDF specifically requested)
- [ ] Single-column layout, no tables or text boxes
- [ ] Standard section headers (Work Experience, Skills, Education)
- [ ] Contact info in body, not header/footer
- [ ] Exact job title from posting in header
- [ ] 25-35 keywords from job posting included naturally
- [ ] Consistent date format throughout (Month Year)
- [ ] Standard font (Arial, Calibri, Times New Roman)
- [ ] No images, icons, charts, or graphics
- [ ] All experience bullets start with action verbs
- [ ] 3-5 quantified achievements per recent role
- [ ] Clean, ATS-friendly formatting

### Online ATS Scanners:

Test your resume before applying:

- Jobscan (compares resume to job description, gives match score)
- Resume Worded (free ATS check)
- TopResume (free ATS scan)

**How to use:**

1. Copy job description
2. Upload your resume
3. Check match score (aim for 80%+)
4. Review suggested keywords
5. Add missing important keywords
6. Retest until score is 80%+

## Common Mistakes and Fixes

### Mistake 1: Generic Resume

**Problem:** Same resume sent to every job

**Fix:** Tailor each resume (15 min per application)

- Match exact job title
- Include job-specific keywords
- Emphasize relevant experience

### Mistake 2: Responsibilities Instead of Achievements

**Problem:**

```
❌ Responsible for managing customer accounts
❌ Tasked with improving sales
```

**Fix:**

```
✅ Managed portfolio of 25 enterprise accounts worth $5M, achieving 95% retention rate
✅ Increased sales by 40% through targeted outreach campaign, generating $800K additional revenue
```

### Mistake 3: Keyword Stuffing

**Problem:** Cramming keywords unnaturally

```
❌ "Expert in Python, SQL, Java, C++, JavaScript, Ruby, PHP, and Scala with Python and SQL experience using Python for SQL queries in Python-based SQL environments."
```

**Fix:** Natural placement

```
✅ "Developed Python scripts to automate SQL database queries, reducing report generation time by 70%."
```

### Mistake 4: No Quantification

**Problem:** Vague claims

```
❌ Improved efficiency
❌ Increased sales
❌ Managed team
```

**Fix:** Specific numbers

```
✅ Improved operational efficiency by 35%, saving $150K annually
✅ Increased sales by 60% from $800K to $1.3M in 18 months
✅ Managed cross-functional team of 12 across 3 departments
```

### Mistake 5: Poor Formatting

**Problem:** Using creative templates with columns, graphics, tables

**Fix:** Clean, simple, single-column layout with standard sections

### Mistake 6: Inconsistent Dates

**Problem:**

```
❌ Jan 2020 - Present
❌ 03/2018 - 12/2019
❌ June '16 - February 2018
```

**Fix:** Pick one format

```
✅ Jan 2020 - Present
✅ Mar 2018 - Dec 2019
✅ Jun 2016 - Feb 2018
```

## Resume Length Guidelines

**General rule:** 1 page per 10 years of experience

**Recent grad / 0-5 years:** 1 page
**Mid-career / 5-15 years:** 1-2 pages
**Senior / 15+ years:** 2 pages (max)
**Executive / C-suite:** 2 pages

**How to fit content:**

**If too long:**

- Remove oldest/irrelevant positions
- Cut bullets from older roles (keep 2-3)
- Remove irrelevant coursework
- Tighten language (remove filler words)
- Adjust margins slightly (minimum 0.5")

**If too short:**

- Add more achievement bullets (up to 5 per role)
- Include relevant volunteer work
- Add certifications/training
- Include academic projects (if recent grad)

## Special Cases

### Recent Graduates / Entry-Level

**Structure:**

```
Name
Exact Job Title (from posting)
Contact Info

EDUCATION (put this first)
Degree, Major | University | Year
• GPA (if >3.5), Honors, Relevant Coursework

SKILLS
[List relevant technical and soft skills]

RELEVANT EXPERIENCE
[Internships, projects, part-time work]

PROJECTS (if applicable)
[Academic or personal projects relevant to job]

LEADERSHIP & ACTIVITIES
[Relevant student organizations, volunteer work]
```

**Focus on:**

- Academic achievements
- Relevant coursework and projects
- Internships and co-ops
- Transferable skills from any work (even retail/service)
- Leadership in student organizations

**Example achievement bullets:**

```
✅ "Led 5-person team for capstone project that achieved highest grade in class of 45 students"
✅ "Tutored 20+ students in Python programming, with 90% achieving grade improvement"
✅ "Organized fundraising event that raised $15K, exceeding goal by 50%"
```

### Career Changers

**Strategy:**

- Use functional or hybrid resume format
- Lead with Skills section (transferable skills)
- Reframe previous experience to highlight relevant achievements
- Include transitional training/certifications
- Address change briefly in summary

**Example summary:**

```
"Marketing professional transitioning to UX Design with Google UX Design Certificate and 5 years of experience in customer research and data analysis. Skilled in user research, prototyping, and Figma. Successfully completed 3 portfolio projects demonstrating user-centered design principles."
```

### Employment Gaps

**Strategies:**

1. **Use years only** (if gap is partial year)

```
2020 - 2023 instead of Jan 2020 - Mar 2023
```

2. **Include relevant gap activities**

```
Freelance Consultant | Self-Employed | 2021 - 2022
• Provided marketing consulting for 8 small businesses
• Managed digital campaigns with $50K total budget
```

3. **Be honest** (in summary or cover letter, not emphasized)

- "Taking time to care for family member"
- "Personal health recovery"
- "Professional development and skill building"

### Remote Work

**How to indicate:**

```
Software Engineer | TechCorp (Remote) | Jan 2020 - Present
• Collaborated with distributed team across 5 time zones...
```

**Highlight remote skills:**

- Self-motivation
- Async communication
- Remote collaboration tools (Zoom, Slack, Asana)
- Time management

## Industry-Specific Tips

### Tech / Software Engineering

**Must-haves:**

- GitHub link (if code is professional quality)
- Technical skills section (languages, frameworks, tools)
- Quantified impact (load time, uptime, users, scale)
- Systems/architecture you've worked on

**Keywords to include:**

- Programming languages
- Frameworks and libraries
- Cloud platforms (AWS, Azure, GCP)
- DevOps tools
- Methodologies (Agile, Scrum)

### Sales

**Focus on:**

- Quota attainment (% over/under)
- Revenue generated
- Number of accounts/clients
- Ranking among team
- Growth metrics

**Formula:** Performance vs Target

```
✅ "Exceeded quota by 156%, generating $2.1M in sales vs $1.35M target"
✅ "Ranked #1 out of 42 sales reps for 6 consecutive quarters"
```

### Marketing

**Emphasize:**

- Campaign results (ROI, conversions, leads)
- Audience growth
- Engagement metrics
- Budget managed
- A/B test results

**Keywords:**

- SEO, SEM, PPC
- Content marketing
- Social media marketing
- Email marketing
- Marketing automation
- Analytics tools (Google Analytics, HubSpot)

### Healthcare

**Include:**

- Certifications and licenses prominently
- Patient outcomes/satisfaction scores
- Efficiency improvements
- Compliance experience
- EHR systems

**Required:**

- License numbers (RN #12345, MD License CA #67890)
- Certifications (BLS, ACLS, PALS)
- Clinical skills section

### Finance / Accounting

**Emphasize:**

- Dollar amounts managed
- Cost savings
- Process improvements
- Compliance achievements
- Software proficiency (QuickBooks, SAP, Oracle)

**Required:**

- CPA or relevant certifications
- Education credentials
- Technical skills (Excel, financial modeling)

## Final Checklist Before Submitting

- [ ] File name: FirstName_LastName_Resume.docx
- [ ] Exact job title from posting is in header
- [ ] Contact info in body (not header/footer)
- [ ] Professional email address
- [ ] LinkedIn URL is customized and matches resume
- [ ] 25-35 keywords from job posting included
- [ ] Every experience bullet starts with action verb
- [ ] 3-5 quantified achievements per recent role
- [ ] Dates consistent throughout (Month Year format)
- [ ] No typos or grammatical errors (proofread 3x)
- [ ] No unexplained gaps in employment
- [ ] Standard section headers used
- [ ] Single-column layout, no tables/graphics
- [ ] Standard font (Arial, Calibri, Times New Roman)
- [ ] Saved as .docx (unless PDF requested)
- [ ] Tested with ATS scanner (80%+ match score)
- [ ] Tailored specifically to this job posting
- [ ] 1-2 pages total (depending on experience)
- [ ] Skills section matches job requirements
- [ ] Most recent role has most detail
- [ ] All claims are truthful and verifiable

## Pro Tips

1. **Update your LinkedIn to match your resume** - Recruiters will check, inconsistencies raise red flags

2. **Keep a master resume** - Document with ALL your experience and achievements, then customize for each job

3. **Save different versions** - "Resume_CompanyName_JobTitle_Date.docx"

4. **Follow application instructions exactly** - If they ask for PDF, send PDF. If they ask for specific filename, use it.

5. **Don't lie** - Everything is verifiable. Estimate conservatively, round down if unsure.

6. **Update regularly** - Even when employed, keep achievements documented

7. **Get feedback** - Have someone in your target industry review it

8. **Apply early** - Many companies sort by application date

9. **Use job posting language** - Mirror their phrasing in your resume

10. **Quality over quantity** - Better to apply to 10 jobs with tailored resumes than 50 with generic one

## Summary: The Formula for Interview Success

1. **Match exact job title** in header (10.6x impact)
2. **Include 25-35 keywords** from job posting
3. **Use consistent date format** (Month Year)
4. **Save as .docx** (unless told otherwise)
5. **Single-column, simple layout** (no graphics, tables, columns)
6. **Quantify every achievement** (numbers, percentages, results)
7. **Tailor for each job** (15 min per application)
8. **Test with ATS scanner** (80%+ match score)
9. **Proofread carefully** (zero typos)
10. **Apply the same day** job posts (early applicants get priority)

**Expected results:**

- 80%+ ATS match score
- 3-5x more interview requests
- Callbacks within 1-2 weeks

**Remember:** Your resume's job is not to get you hired. Its job is to get you an interview. Focus on passing ATS and interesting the recruiter enough for a phone call.

Good luck! 🚀
