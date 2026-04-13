# pon.ink · SCD Hub — Cultural & Market Monitoring Strategy

> **Purpose:** A living framework for tracking whether the platform is genuinely serving
> its participants — not just at scale, but at depth. Metrics here are chosen to surface
> real human outcomes, not vanity numbers. Each stakeholder type has distinct signals.
> Taken together they tell us whether pon.ink is fulfilling its Educate → Empower → Voice
> mission and sustaining itself to do so.

---

## 0. Guiding Principles

- **Community before conversion.** A metric that improves the platform's revenue while
  degrading participant outcomes is a bad metric.
- **Disaggregated by default.** All metrics should be segmentable by geography, language,
  role, and pathway. Aggregate numbers hide who's being left behind.
- **Open data where possible.** Environmental and public-interest metrics (Eco Ops, Health
  ID issuance) should be published in non-proprietary formats. Community owns its data.
- **Qualitative complements quantitative.** Numbers tell you _what_ is happening; regular
  conversations with participants tell you _why_.

---

## 1. Stakeholder Map

| Role | What they need to succeed | Primary failure mode to watch |
|---|---|---|
| **Participant** | Clear pathway from onboarding to first economic outcome | Drop-off between Educate and Empower phases |
| **Facilitator** | Low-friction session tools, real-time participant visibility | Burnout from under-supported sessions |
| **Mentor** | Matched mentees, measurable mentee progress, recognition | Invisible contribution — no feedback loop |
| **Administrator** | System uptime, financial transparency, compliance dashboards | Flying blind on revenue splits and audit logs |
| **Code Security Expert** | Continuous vuln scanning, dependency hygiene, incident playbooks | Alert fatigue from noise; missed critical patches |
| **Promoter** | Audience insight, campaign conversion, partnership health | Misaligned messaging that distances community trust |
| **Environmental Engineer** | Field node reliability, data quality, open publication pipeline | Sensor drift, data silos, government data deletion |

---

## 2. Cultural Metrics

Cultural health is the hardest thing to measure and the most important to get right.
These signals indicate whether pon.ink is resonating with and respecting its communities.

### 2.1 Participant Pathway Depth

| Metric | Target signal | Collection method |
|---|---|---|
| Onboarding → first tool action rate | >60% within 7 days | Supabase event log |
| Educate → Empower progression rate | >40% complete at least one module | Module completion tracking |
| Empower → Voice conversion | >20% produce a mintable asset or publish data | NFT mint events, Eco Ops submissions |
| 90-day retention (any active session) | >35% | Session timestamps |
| Cross-pathway engagement | % touching >1 of Sound/Eco/Health/Exchange | User role diversity index |

### 2.2 Community Representation

- **Geographic spread:** Active participants per city/region; goal is to not be Nairobi-only
  within 12 months.
- **Language diversity:** Sessions and content delivered in how many languages. Track which
  locales are underserved.
- **Gender and displacement status:** Optional self-reported fields. Track whether
  participation skews in ways that suggest access barriers.
- **Youth vs. established practitioner ratio:** pon.ink should lean young and street-level.
  If the ratio inverts, something in the UX or promotion is filtering out the target cohort.

### 2.3 Cultural Production Quality

- **$BARS NFTs minted per month** — not just quantity, but are they being traded/used
  downstream? A mint rate with zero secondary activity means the token has no real value.
- **Sample bank diversity** — track which figure calibrations (440Hz, Afro-Latin, etc.) are
  being used. Monoculture in the sampler means the tool isn't serving its full cultural range.
- **POAP participation tokens issued per event** — and the ratio of POAPs to unique wallets.
  High ratio = high re-engagement. Low ratio = one-time tourists.
- **Qualitative: community listening sessions** — quarterly calls with 8–12 participants
  across archetypes (ghetto youth, educator in exile, community builder). Record what
  people say pon.ink _actually_ helped them do, not what we hoped.

### 2.4 Mentor & Facilitator Resonance

- **Mentee-reported outcome surveys** — short (3-question) async check-ins at 30/60/90 days.
  "Did your mentor help you _do_ something?" not "how satisfied were you?"
- **Facilitator session notes** — freeform field submitted after each event. NLP sentiment
  scan for early warning on frustration, confusion, or unmet needs.
- **Mentor contribution visibility** — are mentors credited on the assets their mentees
  produce? Track whether the recognition system is actually being used.

---

## 3. Market Metrics

### 3.1 Payment Health

These map directly to the revenue structure in `SPEC_PAYMENTS_AFRICA.MD` (80/15/5 split).

| Metric | Target | Watch-out |
|---|---|---|
| M-Pesa STK Push success rate | >92% | Drop signals AT/Safaricom infra issue |
| Stripe payment conversion rate | >70% of initiated checkouts | Drop signals UX or locale mismatch |
| Net-to-artist KES (displayed pre-confirm) | 100% shown — no exceptions | Any suppression is a trust violation |
| Community Hardware Fund accrual (15%) | Track in a dedicated `community_fund` ledger row | Fund should never be redirected to operations |
| Platform fee (5%) | Must cover hosting + security retainer | If it doesn't, sustainability is at risk |
| Anti-fraud trigger rate | <1% of sessions | High rate = either attack or legitimate users being blocked |

### 3.2 Token Economy

| Metric | Signal |
|---|---|
| $BARS minted per month | Creative output volume |
| $BARS held > 30 days | Long-term value belief vs. immediate liquidation |
| NFT secondary sales volume | Whether the token has real aftermarket life |
| Health Card IDs issued (on-chain) | Scale of decentralized health infra adoption |
| Water Quality Certifications minted | Eco Ops data credibility (on-chain proof of testing) |
| POAP event tokens (vote/coordination use) | Whether governance tokens are actually used for governance |

### 3.3 Eco Ops Market Signals

Eco Ops is not purely commercial — but its sustainability depends on demonstrating value
to municipal partners, NGOs, and research institutions.

- **Open data downloads per month** — who is using the published water/environmental data?
  Track domains downloading (government, NGO, academic, commercial).
- **Third-party citations** — reports or publications that cite pon.ink/SCD Hub Eco Ops data.
- **Field node uptime** — SLA-style tracking per node. <95% uptime is a reliability story;
  repeated outages in one region may signal infrastructure or safety issues for field workers.
- **Contamination detection events** — how many alerts fired, how many were confirmed true
  positives, how quickly were they acted on by the community?
- **Partnership pipeline** — track municipal or NGO interest conversations by stage
  (intro / MOU / data-sharing agreement / funded).

### 3.4 Growth and Reach

| Metric | Purpose |
|---|---|
| Monthly active participants (MAP) | Core health signal — not users, participants |
| Promoter-attributed sign-ups | Which channels bring users who actually stay? |
| Organic vs. promoted session starts | Measures word-of-mouth vs. ad-dependency |
| Event attendance (online + in-person) | Track Collaborative events (Fana Ka, OT Kulcha, etc.) |
| GPL v3 forks of pon.ink codebase | Platform is working if others build on it |

---

## 4. Monitoring Infrastructure

### 4.1 Data Collection Stack

```
Supabase (Postgres)
  ├── participant_events       — onboarding, module completion, tool actions
  ├── mpesa_audit              — every STK Push (per SPEC_PAYMENTS_AFRICA.MD)
  ├── payment_splits_ledger    — 80/15/5 split records, append-only
  ├── eco_ops_nodes            — sensor readings, uptime, alert events
  ├── nft_mint_events          — mints, secondary sales (on-chain sync via webhook)
  └── community_fund_ledger    — 15% hardware fund, transparent and auditable

Supabase Edge Functions
  ├── rate-limit enforcement (anti-fraud)
  └── on-chain receipt hash generation (post M-Pesa callback)

On-chain (Polygon / Solana)
  ├── $BARS token contract
  ├── Health Card ID metadata
  └── Water Quality Certification proofs

Decentralized Storage (Pinata / Arweave / nft.storage)
  └── NFT asset permanence — metrics track retrieval latency and pin health
```

### 4.2 Dashboards by Role

Each stakeholder type should have a view scoped to what they actually need:

| Audience | Dashboard contents |
|---|---|
| **Participant** | My pathway progress, my assets, my earnings (KES/USD) |
| **Facilitator** | Session attendance, participant actions taken, feedback received |
| **Mentor** | Mentee list, mentee milestone completions, attribution on minted assets |
| **Administrator** | System uptime, payment split ledger, compliance flags, fund balances |
| **Security Expert** | Dependency audit results, vuln scan summary, incident log, rate-limit events |
| **Promoter** | Attribution by channel, event conversions, audience demographics |
| **Environmental Engineer** | Node map, sensor uptime, alert log, open data download stats |

> **Note:** All dashboards should be readable on a mid-range Android handset on 3G.
> Desktop-first dashboards exclude the people who matter most.

### 4.3 Alerting Thresholds

| Signal | Threshold | Who gets alerted |
|---|---|---|
| M-Pesa STK success rate < 88% | 15-minute window | Administrator + Security Expert |
| Eco Ops node offline > 2h | Any single node | Environmental Engineer |
| `mpesa_audit` insert failure | Any single failure | Security Expert + Administrator |
| Supabase Edge Function error rate > 5% | 10-minute window | Security Expert |
| Community fund ledger divergence | Any | Administrator (escalate immediately) |
| NFT pin health degradation on Pinata/Arweave | Retrieval latency > 10s | Security Expert |
| Anti-fraud rate-limit trigger spike (>10x baseline) | 5-minute window | Security Expert |

---

## 5. Development Pathways

How metrics should drive roadmap decisions — and what to do when signals are mixed.

### 5.1 Participant Drop-off at Educate → Empower

**Signal:** Onboarding rates are healthy but module completion is low.

**Investigate:**
- Are modules too long or text-heavy for mobile?
- Are they available in the participant's primary language?
- Is there a cost barrier (data, device) at a specific step?

**Pathway:** Short-form video modules, offline-downloadable content, peer-facilitated
cohort structures rather than solo self-paced learning.

### 5.2 M-Pesa Adoption Lags Stripe

**Signal:** In regions where both are available, participants choose Stripe over M-Pesa.

**Investigate:**
- Is the M-Pesa UX showing the pre-confirm net-to-artist KES amount clearly?
- Are STK Push wait times exceeding participant patience?
- Is there a trust deficit with the phone-number data collection step?

**Pathway:** Improve STK Push UX feedback loop (progress indicator, retry with clear error).
Add testimonials from artists who were paid via M-Pesa. Review NDPA data disclosure copy.

### 5.3 $BARS Minted but Not Traded

**Signal:** High mint volume, near-zero secondary market activity.

**Investigate:**
- Do participants understand the token has aftermarket utility?
- Is there a marketplace they can actually access (mobile, low-data)?
- Is the asset quality (audio, metadata) sufficient for buyers to find value?

**Pathway:** In-app marketplace preview, Sound Lab audio quality improvements, mentorship
pairing between producers and digital market literacy facilitators.

### 5.4 Eco Ops Data Not Being Used Externally

**Signal:** Open data is published but download numbers are flat; no third-party citations.

**Investigate:**
- Is the data format accessible (GeoJSON, CSV — not proprietary GIS formats)?
- Is there a human-readable data catalog explaining what each dataset contains?
- Are NGOs and researchers even aware the data exists?

**Pathway:** Proactive outreach to water/public health research institutions. Publish a
plain-English data story per quarter (one specific contamination event, mapped, explained).
Submit to open data registries (HDX, CKAN instances).

### 5.5 Promoter Channels Bring Tourists, Not Participants

**Signal:** High click-through from a channel but low 90-day retention for those users.

**Investigate:**
- Is the channel audience actually the target cohort?
- Is the landing experience (onboarding page) matching the message that drove the click?
- Are promoters rewarded for sign-ups rather than retained participants?

**Pathway:** Shift promoter incentive structure toward 90-day retained participant bonuses
rather than raw sign-up volume. Align campaign messaging with real participant stories.

---

## 6. Feedback Loops

### 6.1 Quarterly Community Review

- 8–12 participants per call, sampled across archetypes and geographies
- Facilitated by a community member, not the pon.ink team
- Three questions: What worked? What blocked you? What should we build next?
- Output: public summary (not verbatim) posted to the repo and onboarding page

### 6.2 Monthly Security Retro

- Code Security Expert leads a 30-minute sync with Administrator
- Agenda: open vulns, dependency updates, audit log anomalies, upcoming compliance dates
- Kenya NDPA, GDPR (if EU participants), and GPL v3 compliance checks included
- Output: brief written summary committed to `/docs/security-retros/`

### 6.3 Event Post-Mortems

Following every Collaborative event (Fana Ka, OT Kulcha, etc.):
- Facilitator submits a structured note within 48h
- Metrics pulled: attendance, POAPs issued, payments processed, assets minted
- Cultural temperature: what landed, what didn't, what the room asked for that didn't exist yet
- Feeds directly into the next sprint's backlog prioritization

### 6.4 Continuous On-Chain Audit

- All $BARS mints, Health Card IDs, and Water Quality Certifications are publicly verifiable
- Monthly automated report confirming on-chain state matches Supabase records
- Any divergence triggers immediate Security Expert review

---

## 7. Six-Month Monitoring Milestones

| Milestone | Metric | Target by |
|---|---|---|
| First Eco Ops node fully instrumented | Sensor uptime > 95% sustained for 30 days | Month 2 |
| First M-Pesa → on-chain receipt cycle live | End-to-end test with real KES transaction | Month 1 |
| Participant dashboard deployed | MAP visible per facilitator | Month 2 |
| Open data first publish | Water quality dataset on HDX or equivalent | Month 3 |
| First quarterly community review | Completed with output published | Month 3 |
| $BARS secondary market activity | At least 1 secondary sale on any marketplace | Month 4 |
| GPL v3 first external fork | Another org builds on pon.ink codebase | Month 6 |
| Security retro cadence established | 6 retros completed on schedule | Month 6 |

---

## 8. Public Policy Intersections — Real Sustainability

pon.ink sits at the intersection of multiple policy domains that are typically siloed from
each other — and from the communities most affected by them. This section maps those
intersections and defines how we position the platform's data, advocacy, and artistic output
to influence them.

> **Definition of "real sustainability" here:** Not carbon credits and corporate ESG reports.
> Sustainability means the conditions for a dignified, healthy life being reliably available
> to people currently denied them — starting with clean water, uncontaminated food, and
> economic agency. Everything else follows from that floor.

### 8.1 Poverty Alleviation

Urban improvised communities are not poor because of individual failure — they face
structural conditions (informal land tenure, exclusion from formal credit, under-resourced
schools, proximity to industrial pollution) that compound across generations.

**Policy intersections to track and name:**

- **Informal economy recognition:** M-Pesa and $BARS unlock pathways should be tracked as
  evidence that financial inclusion works without requiring formal banking. Aggregate
  transaction data (anonymized) can be submitted to policy bodies as a case study.
- **Intellectual property access:** The GPL v3 stance and $BARS NFT model is a direct
  challenge to IP regimes that lock cultural production behind corporate intermediaries.
  Track how many participants earn from their first asset — this is poverty alleviation
  data, not just a music metric.
- **Vocational skill credentialing:** Certificates issued through pon.ink modules should
  be designed to be portable to formal employment contexts. Advocate for recognition of
  open, community-verified credentials by national vocational qualification bodies.

**Artistic advocacy role:** Commission tracks, murals, and visual essays from participants
that directly name the structural mechanisms — not just the symptoms — of urban poverty.
This is community-controlled narrative production, not charity communication.

### 8.2 Clean Environment and Contamination

In many urban informal settlements, residents live alongside industrial waste, open sewage,
and unmanaged cross-connections between potable and non-potable water systems.
These are not natural disasters — they are policy failures, often with identifiable actors
who have avoided accountability because the affected communities lack documentation power.

**Policy intersections:**

- **Right to clean water (constitutional in Kenya, South Africa, and others):** Eco Ops
  sensor data is potential legal evidence. Data from the network should be time-stamped,
  cryptographically signed, and stored on Arweave (permanent, tamper-evident) specifically
  so it can survive government data deletion and be used in litigation or oversight hearings.
- **Industrial polluter accountability:** When contamination events are detected and mapped,
  the data should be proactively shared with environmental law NGOs (e.g. Centre for
  Environmental Rights, Natural Justice) not just published passively.
- **Urban planning exclusion:** Track the location of Eco Ops nodes relative to formally
  planned vs. informal settlement zones. The gap in infrastructure investment is the
  policy story. Map it. Publish it. Let artists visualize it.
- **Climate displacement monitoring:** Educators and participants who have been displaced by
  climate events (flooding, drought, sea-level encroachment) should be able to log their
  displacement origin and cause through the platform. This contributes to the global
  climate migration dataset that currently under-counts informal community impact.

**Artistic advocacy role:** Visual artists and muralists mapping contamination zones onto
public walls turn Eco Ops data into undeniable community communication. Track how many
public art pieces reference pon.ink environmental data — this is a cultural reach metric
with direct policy impact.

### 8.3 Food Contamination and Nutritional Awareness

Contaminated water systems are inseparable from food safety — irrigation water, food
processing, and street food preparation all intersect with the infrastructure failures
Eco Ops is documenting.

**Policy intersections:**

- **Food safety regulations vs. informal vendors:** Street food vendors in informal markets
  are often subject to raids and licensing crackdowns while the water supply they depend on
  goes unmonitored. pon.ink can support advocacy for _infrastructure accountability first,
  vendor compliance second_.
- **Nutritional deserts:** Track the geographic overlap between active Eco Ops nodes and
  the presence of fresh produce markets vs. ultra-processed food retail. This is public
  health data. Make it visual. Submit it to city health departments.
- **Agricultural runoff and urban farming:** Where participants are engaged in urban
  agriculture (increasingly common in informal settlements as a food security strategy),
  Eco Ops soil and water data is directly relevant to whether their crops are safe.
  Create a simple advisory layer: "Eco Ops data for your growing zone."
- **Nutritional literacy modules:** Add a vocational track specifically on food systems,
  nutrition, and the relationship between environmental contamination and diet-related
  disease. Make this available offline-first. Partner with community health workers
  already credentialed via Health ID.

**Artistic advocacy role:** Young rappers and spoken word artists with lived experience of
food insecurity are not illustrating a policy paper — they are primary sources. Give them
production infrastructure (Sound Lab) and platform (pon.ink events) to make that testimony
audible to audiences that policy documents never reach. Track plays and shares of tracks
that explicitly address food access and contamination — this is public health outreach data.

### 8.4 Unique Local Challenges — Community-Specific Documentation

A critical failure mode of external-facing platforms serving marginalized communities is
generalizing "the ghetto" as a single condition. The specific pressures on a youth in
Kibera (Nairobi) differ from those in Soweto, Trenchtown, or Compton — different colonial
histories, different land-tenure regimes, different climate exposures, different state
relationships.

**How pon.ink addresses this:**

- **Locality tags on all content and data:** Every NFT mint, Eco Ops submission, and
  Health ID issuance carries a locality identifier. Over time this builds a dataset that
  shows how challenges differ by place rather than flattening them.
- **Local facilitator authority:** Facilitators in each node city have editorial authority
  over the curriculum emphasis for their cohort. A facilitator in a drought-affected area
  weights water differently than one in a flood zone. Track divergence between local
  curriculum adaptations — this is a signal of how well the platform is locally rooted.
- **Artist-as-documentarian program:** Formally structure a track within the platform where
  visual artists, rappers, and short-form video makers are supported (technically and
  economically via $BARS advances) to document specific local conditions. Output:
  community-controlled media archives, not platform-owned content.
- **Policy brief pipeline:** Every quarter, aggregate the locality-tagged data + artistic
  output into a brief that can be submitted to a relevant policy body. The brief is written
  by a community member, reviewed by a mentor, formatted by an administrator. It is
  published under the community's name, not pon.ink's.

### 8.5 Metrics for Policy Influence

These supplement the market and cultural metrics in Sections 2–3:

| Metric | What it signals |
|---|---|
| Environmental data submissions to open registries | Platform's public-interest data footprint |
| Legal/advocacy NGO engagements with Eco Ops data | Real-world policy leverage of sensor network |
| Artist tracks explicitly addressing structural issues | Community voice pipeline is functioning |
| Policy briefs published per year | Platform's contribution to the public record |
| Contamination events → confirmed regulatory response | Whether data actually changes conditions |
| Food safety advisories issued using Eco Ops data | Cross-domain utility of environmental layer |
| Climate displacement records logged | Contribution to global migration dataset |
| Locality-tagged assets across distinct communities | Depth of geographic specificity |

---

## 9. What We Do Not Measure (Intentionally)

- **Raw page views or impressions.** These reward noise, not depth.
- **Social media follower counts.** A thousand followers who never participate are worth less
  than ten who mint, map, and return.
- **Token price.** $BARS value is a downstream consequence of real utility, not a goal to
  manage. Chasing price corrupts the other metrics.
- **Competitor comparisons.** There is no meaningful competitor serving this specific cohort
  in this specific intersection of sound, environment, health, and exchange. Comparisons
  distract from the actual question: are we serving our people?

---

_Maintained by the pon.ink administrative team. Reviewed quarterly alongside the community
review process. All changes to this document should be committed with a brief rationale._
