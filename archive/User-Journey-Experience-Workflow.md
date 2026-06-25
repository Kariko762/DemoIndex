# Stage 4 User Journey Experience Workflow

## Purpose

This document translates the Stage 4 Technical Glossary into a granular operating workflow. It shows, step by step:

* what happens at each stage of the buyer journey
* who engages at each step
* which systems and tools are involved
* what is automated versus human-in-the-loop
* what remains human-orchestrated versus machine-executed
* which glossary capabilities are active at each step

## Scope

This workflow assumes a Stage 4 production environment only.

The goal is to show how Stage 4 works in practice when humans define the strategy and connected systems operationalize delivery, guidance, contextual continuity, and analytics.

## Reference Stack

This is a representative implementation stack used in the workflow below.

| Capability | Representative Tools |
| --- | --- |
| CRM and account system | Salesforce |
| Marketing automation | HubSpot or Marketo |
| Orchestration platform | Coast.io-style orchestration layer or custom orchestration app |
| Presentation layer | Seismic Interactive Content, Seismic Microsites, Coast.io Engagement Portal, or a custom React or Next.js buyer experience |
| CMS and content model | Contentful, Sanity, or structured content service |
| Identity and access | Auth0, Okta, or first-party identity service |
| Event collection | Segment, RudderStack, or Snowplow |
| Data warehouse | Snowflake, BigQuery, or Databricks |
| AI gateway service | Internal AI service running prompt orchestration and policy controls |
| LLM | Gemini via Vertex AI or Google AI Studio API |
| BI and seller activation | Looker, Salesforce dashboards, Slack, email alerts |

## Operating Roles

| Role | Primary Responsibility |
| --- | --- |
| AE | Owns account strategy, opportunity progression, and seller follow-up |
| SE | Defines technical narrative, workflow emphasis, objections, and approved experience pathways |
| RevOps | Governs templates, measurement, routing rules, and CRM integration |
| Product Marketing | Maintains value narrative, proof points, industry messaging, and approved copy blocks |
| Orchestration Platform | Assembles the experience and enforces rules |
| AI Service | Builds prompts, retrieves context, applies safety and policy constraints, calls Gemini |
| Gemini | Generates summaries, bridge copy, workflow intros, and guidance text |
| Buyer | Explores the experience and produces interaction signals |
| Analytics Layer | Scores, analyzes, and activates next actions |

## Automation Model

| Mode | Meaning |
| --- | --- |
| Human Orchestrated | A person explicitly decides strategy, pathway, or priority |
| Human in the Loop | A person approves, edits, or overrides a machine-generated output |
| Automated | The system executes deterministically from rules, triggers, or services |
| Intelligence Assisted | The system generates or suggests options inside human-defined boundaries |

## End-to-End Workflow

### Phase 1: Opportunity Qualification and Journey Initiation

| Step | Action | Primary Actor | Systems and Tools | Execution Mode | Glossary Items |
| --- | --- | --- | --- | --- | --- |
| 1 | Opportunity reaches the qualification threshold in CRM based on deal stage, fit score, or seller action. | AE, RevOps | Salesforce, scoring rules | Human Orchestrated plus Automated trigger | Unified Narrative Infrastructure |
| 2 | Salesforce emits a webhook or platform event indicating the opportunity is eligible for a guided experience. | Orchestration Platform | Salesforce Platform Events, webhook endpoint | Automated | Unified Narrative Infrastructure |
| 3 | Orchestration service receives the event and opens a new experience job with a unique journey ID. | Orchestration Platform | API gateway, orchestration service, PostgreSQL | Automated | Narrative Orchestration Engine |
| 4 | The orchestration service queries CRM for account profile, opportunity stage, buyer roles, industry, region, and open objections. | Orchestration Platform | Salesforce REST API, integration layer | Automated | Persistent Context |
| 5 | The service checks whether an existing journey already exists for the account and whether context should be resumed or forked. | Orchestration Platform | Journey state store, account lookup service | Automated | Persistent Context, Journey State Tracking |
| 6 | RevOps routing rules determine which template family applies: enterprise, mid-market, regulated industry, or strategic account. | RevOps, Orchestration Platform | Rules engine, config tables | Human Orchestrated rules with Automated execution | Structured Branching Logic |
| 7 | A base presentation layer instance is reserved and linked to the account, opportunity, and stakeholder group. | Orchestration Platform | Seismic, Coast.io, Next.js app shell, config service, CMS template registry | Automated | Unified Narrative Infrastructure, Presentation Layer |

### Phase 2: Human Strategy Definition

| Step | Action | Primary Actor | Systems and Tools | Execution Mode | Glossary Items |
| --- | --- | --- | --- | --- | --- |
| 8 | AE and SE review account context, current pain points, competitive threats, and likely buying committee members. | AE, SE | Salesforce, call notes, account plan | Human Orchestrated | Human-Led Orchestration |
| 9 | SE selects the primary narrative objective, such as contextual continuity, operational efficiency, integration confidence, or reporting consolidation. | SE | Orchestration admin UI | Human Orchestrated | Human-Led Orchestration, Narrative Continuity |
| 10 | SE chooses the core workflows to expose first, such as analytics dashboard, integration hub, security controls, or ROI view. | SE | Orchestration admin UI, CMS content graph | Human Orchestrated | Structured Branching Logic |
| 11 | SE flags specific objections that need direct handling, such as implementation complexity or security concerns. | SE | Objection taxonomy, orchestration UI | Human Orchestrated | Human-Led Orchestration |
| 12 | Product Marketing-approved narrative blocks are suggested based on industry and persona. | Orchestration Platform | CMS, taxonomy service, recommendation rules | Intelligence Assisted | Narrative Continuity, Operationalized Personalization |
| 13 | SE accepts, edits, or rejects suggested narrative blocks and confirms message priority order. | SE | Orchestration admin UI | Human in the Loop | Human-Led Orchestration, Narrative Continuity |
| 14 | Governance service validates that selected workflows and copy blocks comply with approved messaging and competitive rules. | Orchestration Platform, RevOps | Policy engine, approval rules | Automated with Human override if blocked | Governed Exploration Pathways, Human-Led Orchestration |
| 15 | Experience configuration is saved as a versioned narrative plan tied to the opportunity. | Orchestration Platform | PostgreSQL, audit log, config registry | Automated | Human-Led Orchestration |

### Phase 3: Data Hydration and Context Modeling

| Step | Action | Primary Actor | Systems and Tools | Execution Mode | Glossary Items |
| --- | --- | --- | --- | --- | --- |
| 16 | The orchestration service pulls current account attributes, custom fields, product usage signals, and prior engagement events. | Orchestration Platform | Salesforce API, product telemetry API, warehouse API | Automated | Persistent Context |
| 17 | Identity service resolves contacts, anonymous visitors, and known stakeholder records into a common account-level graph. | Orchestration Platform | Identity resolution service, Auth0, CRM IDs | Automated | Persistent Context |
| 18 | Context model is written to a profile object containing account facts, stakeholder hypotheses, open objections, and likely use cases. | Orchestration Platform | Profile service, PostgreSQL, Redis | Automated | Persistent Context |
| 19 | Journey state model is initialized with starting state equal to qualified, pre-experience, persona-targeted. | Orchestration Platform | State machine service | Automated | Journey State Tracking |
| 20 | Personalization service computes render variables such as company name, terminology preferences, currency, region, industry proof points, and role framing. | Orchestration Platform | Personalization service, CMS, localization tables | Automated | Operationalized Personalization |
| 21 | Missing or weak fields trigger fallback logic so the experience remains safe even with incomplete CRM data. | Orchestration Platform | Fallback rules, config service | Automated | Operationalized Personalization, Human-Led Orchestration |

### Phase 4: Content Retrieval and Experience Assembly

| Step | Action | Primary Actor | Systems and Tools | Execution Mode | Glossary Items |
| --- | --- | --- | --- | --- | --- |
| 22 | The orchestration engine requests all content modules tagged to the selected persona, industry, narrative objective, and workflows. | Orchestration Platform | CMS API, taxonomy service | Automated | Narrative Continuity, Operationalized Personalization |
| 23 | The content service returns approved modules, each tagged by value theme, objection coverage, proof type, and workflow mapping. | CMS | Contentful or Sanity, metadata graph | Automated | Narrative Continuity |
| 24 | The orchestration engine composes the initial experience path, including landing view, workflow order, proof points, and bridge moments. | Orchestration Platform | Orchestration engine, state machine, config registry | Automated from human-defined plan | Narrative Orchestration Engine, Structured Branching Logic |
| 25 | The presentation layer renders the account-personalized landing page and loads precomputed pathway definitions. | Presentation Layer | Seismic, Coast.io portal, Next.js, React, edge config | Automated | Unified Narrative Infrastructure, Presentation Layer |
| 26 | A single canonical URL is generated and associated with the journey ID, account ID, and access rules. | Orchestration Platform | Routing service, token generator | Automated | Unified Narrative Infrastructure |
| 27 | Analytics instrumentation is attached to all pages, modules, buttons, overlays, and guidance panels before release. | Orchestration Platform | Segment, RudderStack, client SDKs | Automated | Granular Intent Capture, Journey State Tracking |

### Phase 5: AI Guidance Preparation

| Step | Action | Primary Actor | Systems and Tools | Execution Mode | Glossary Items |
| --- | --- | --- | --- | --- | --- |
| 28 | The orchestration layer determines which guidance surfaces require generated text, summaries, or bridge explanations. | Orchestration Platform | Guidance rules, template registry | Automated | Persistent Guidance Layer, Context Bridges |
| 29 | For each required guidance unit, the orchestration layer sends a structured request to the AI service. | Orchestration Platform | Internal AI gateway, message queue or API | Automated | Persistent Guidance Layer |
| 30 | The AI service builds a prompt package containing buyer context, selected workflows, approved narrative anchors, blocked topics, tone rules, and content constraints. | AI Service | Prompt orchestration service, policy engine | Automated | Human-Led Orchestration, Narrative Continuity |
| 31 | The AI service converts the request into retrieval tasks, including semantic search against approved vectorized content and nearest-neighbor lookup by persona and workflow cluster. | AI Service | Retrieval service, vector store query planner | Automated | Narrative Continuity, Context Bridges |
| 32 | The retrieval service embeds the query or uses a cached embedding and submits semantic search to the vector store. | AI Service | Gemini embedding model or Vertex embeddings, Pinecone or pgvector | Automated | Persistent Guidance Layer |
| 33 | The vector store returns nearest approved content groups, prior approved bridge patterns, and relevant proof points. | Vector Store | Pinecone, pgvector, Weaviate | Automated | Context Bridges, Persistent Guidance Layer |
| 34 | The AI service filters retrieved items through policy rules so only approved and context-valid fragments can be used. | AI Service | Policy engine, metadata filter | Automated | Human-Led Orchestration, Governed Exploration Pathways |
| 35 | The AI service sends the final prompt to Gemini with structured context, retrieved snippets, required output schema, and explicit guardrails. | AI Service | Vertex AI Gemini API | Automated | Persistent Guidance Layer, Context Bridges |
| 36 | Gemini returns draft outputs such as bridge copy, workflow intros, explanation text, and recommended next-step guidance. | Gemini | Gemini | Automated | Persistent Guidance Layer, Context Bridges |
| 37 | The AI service validates schema compliance, banned-term policies, token confidence thresholds, and brand rules. | AI Service | Validator, moderation, policy checks | Automated | Human-Led Orchestration |
| 38 | If the output is flagged as high-risk, low-confidence, or competitive-sensitive, it is routed to SE or Product Marketing for approval. | AI Service, SE, Product Marketing | Approval queue, admin UI | Human in the Loop | Human-Led Orchestration |
| 39 | Approved AI outputs are stored as journey-bound guidance modules with version metadata and provenance. | Orchestration Platform | CMS writeback, content cache, audit log | Automated after approval | Persistent Guidance Layer, Human-Led Orchestration |

### Phase 6: AI Video or Rich Media Personalization

| Step | Action | Primary Actor | Systems and Tools | Execution Mode | Glossary Items |
| --- | --- | --- | --- | --- | --- |
| 40 | The orchestration engine assembles an account-specific rich-media brief including script variables, persona framing, industry phrasing, and CTA targets. | Orchestration Platform | Rich-media service, config rules | Automated | Operationalized Personalization |
| 41 | If video is enabled, the brief is sent to a video generation provider for rendering. | Orchestration Platform | Synthesia or equivalent API | Automated | Operationalized Personalization |
| 42 | Rendered media asset is stored and attached to the journey path at the intended narrative step. | Orchestration Platform | Asset store, CDN, CMS | Automated | Unified Narrative Infrastructure |
| 43 | Media module is tagged so analytics can attribute engagement by persona, role, and narrative objective. | Orchestration Platform | Asset metadata service, analytics SDK | Automated | Granular Intent Capture |

### Phase 7: Buyer Entry and Identity Resolution

| Step | Action | Primary Actor | Systems and Tools | Execution Mode | Glossary Items |
| --- | --- | --- | --- | --- | --- |
| 44 | AE sends the single journey link or the link is delivered through email automation. | AE, Marketing Automation | Salesforce email, HubSpot, Marketo | Human Orchestrated or Automated | Unified Narrative Infrastructure |
| 45 | Buyer clicks the link and lands in the presentation layer. | Buyer | Browser, Seismic microsite, Coast.io portal, or custom web app | Human action | Unified Narrative Infrastructure, Presentation Layer |
| 46 | Access service resolves whether the visitor is authenticated, cookie-known, email-token-known, or anonymous. | Orchestration Platform | Identity service, auth token, cookies | Automated | Persistent Context |
| 47 | If the buyer is recognized, the platform resumes saved state, prior interactions, and likely role framing. | Orchestration Platform | Profile store, Redis session cache | Automated | Persistent Context, Journey State Tracking |
| 48 | If the buyer is unknown, the platform assigns a temporary visitor ID and begins progressive identity resolution. | Orchestration Platform | Session service, analytics identity stitching | Automated | Persistent Context |

### Phase 8: Guided Experience Runtime

| Step | Action | Primary Actor | Systems and Tools | Execution Mode | Glossary Items |
| --- | --- | --- | --- | --- | --- |
| 49 | The landing view presents the primary value narrative, tailored proof points, and the recommended starting workflow. | Presentation Layer | React UI, Seismic content region, CMS, personalization service | Automated | Narrative Continuity, Persistent Guidance Layer, Presentation Layer |
| 50 | A persistent guidance panel explains why this workflow matters for the buyer's role and what they should learn first. | Presentation Layer, AI Service | Guidance module, Gemini-generated or templated text | Automated | Persistent Guidance Layer, Presentation Layer |
| 51 | Buyer selects a workflow or accepts the recommended path. | Buyer | UI navigation | Human action | Structured Branching Logic |
| 52 | The orchestration engine checks whether the selected path is valid for the current journey state and buyer context. | Orchestration Platform | State machine, policy engine | Automated | Governed Exploration Pathways, Journey State Tracking |
| 53 | If valid, the next workflow loads with role-specific data and tagged value framing. | Presentation Layer | React UI, CMS, data injector | Automated | Operationalized Personalization, Narrative Continuity, Presentation Layer |
| 54 | If the buyer attempts a non-primary jump, the engine determines whether a context bridge is required before the destination can render. | Orchestration Platform | Bridge rules, state machine | Automated | Context Bridges, Narrative Orchestration Engine |
| 55 | The bridge service requests a suitable bridge asset or AI-generated transition based on source state and target state. | Orchestration Platform, AI Service | CMS, retrieval service, Gemini | Automated | Context Bridges |
| 56 | The bridge content is displayed to explain why the target workflow matters and how it connects back to the current business objective. | Presentation Layer | Overlay, side panel, modal | Automated | Context Bridges, Narrative Continuity, Presentation Layer |
| 57 | Buyer enters the destination workflow with reinforced narrative framing instead of a cold context reset. | Buyer, Presentation Layer | UI, stateful client app | Human action plus Automated state carry-forward | Persistent Context, Narrative Continuity, Presentation Layer |
| 58 | Every significant interaction emits events including viewed module, dwell time, branch choice, objection interactions, and CTA engagement. | Presentation Layer | Segment, RudderStack, custom events | Automated | Granular Intent Capture, Presentation Layer |
| 59 | Stream processor updates the current journey state based on live behavior, such as exploring, validating, stalling, or deep technical review. | Analytics Layer | Kafka Streams, Flink, Python state updater | Automated | Journey State Tracking |
| 60 | Guidance logic adapts the next recommended action based on the updated state. | Orchestration Platform | Recommendation rules, guidance service | Automated | Persistent Guidance Layer, Journey State Tracking |
| 61 | If the buyer repeatedly interacts with integration content, the system increases integration relevance and surfaces supporting proof or customer stories using predefined Stage 4 rules. | Orchestration Platform | Rules engine, CMS | Automated | Granular Intent Capture, Persistent Guidance Layer |
| 62 | If engagement weakens after a transition, the platform marks possible narrative drift and injects a recovery bridge or summary. | Orchestration Platform | Drift detector, Gemini, guidance panel | Automated | Narrative Drift, Context Bridges |
| 63 | If the buyer opens high-sensitivity content such as pricing or security, stricter governance logic controls what can be shown and whether seller escalation is needed. | Orchestration Platform, AE, SE | Policy engine, escalation rules, Slack alert | Automated with Human follow-up | Human-Led Orchestration, Governed Exploration Pathways |
| 64 | If the buyer requests help, an AI assistant or guided FAQ service answers within approved scope and logs the interaction. | Buyer, AI Service | Conversational UI, Gemini, retrieval service | Automated with fallback to human | Persistent Guidance Layer, Granular Intent Capture |
| 65 | If the AI assistant detects uncertainty, unsupported claims, or a sensitive competitive question, it defers and recommends seller intervention. | AI Service | Confidence rules, moderation, escalation workflow | Automated with Human in the Loop | Human-Led Orchestration |
| 66 | AE or SE receives a real-time notification if the buyer reaches a critical buying signal, such as repeat pricing views or a validated technical path. | Analytics Layer, AE, SE | Salesforce task, Slack, email alert | Automated | Granular Intent Capture |

### Phase 9: Session Completion and Seller Activation

| Step | Action | Primary Actor | Systems and Tools | Execution Mode | Glossary Items |
| --- | --- | --- | --- | --- | --- |
| 67 | Buyer exits or completes the session. | Buyer | Browser | Human action | Journey State Tracking |
| 68 | Event pipeline closes the session and computes summary metrics such as depth, path completion, bridge usage, and stakeholder behavior. | Analytics Layer | Segment warehouse sync, dbt, Python jobs | Automated | Journey State Tracking, Granular Intent Capture |
| 69 | Narrative Integrity Score is computed from anchor coverage, transition coherence, objection handling, and behavioral consistency. | Analytics Layer | Warehouse model, scoring job | Automated | Narrative Integrity Score |
| 70 | Seller-facing summary is generated showing what the buyer explored, where confidence increased, where friction appeared, and which stakeholders likely care most. | Analytics Layer | CRM sync, dashboard service, AI summarization service | Automated | Granular Intent Capture, Journey State Tracking |
| 71 | If configured, the AI service drafts a follow-up summary for the AE using retrieved journey facts and approved email templates. | AI Service | Prompt service, Gemini, CRM activity feed | Intelligence Assisted | Persistent Guidance Layer |
| 72 | AE reviews, edits, and sends the follow-up email or meeting invite. | AE | Salesforce, email client | Human in the Loop | Human-Led Orchestration |
| 73 | Engagement summary, narrative score, and pathway signals are written back to CRM for reporting and next-step automation. | Analytics Layer | Salesforce API, reverse ETL | Automated | Unified Narrative Infrastructure, Narrative Integrity Score |

## Detailed AI Retrieval and Generation Subflow

This subflow expands the Stage 4 guidance and context-bridge path into fine-grained service interactions.

| Micro-Step | Action | Actor or Service | Inputs | Outputs | Mode |
| --- | --- | --- | --- | --- | --- |
| A1 | Orchestration platform requests a bridge or guidance asset for the current buyer state. | Orchestration Platform | journey ID, source state, target state, persona, account context | generation request | Automated |
| A2 | AI service loads prompt template and policy template for the requested asset type. | AI Service | asset type, governance rules | prompt skeleton | Automated |
| A3 | AI service loads approved narrative anchors and blocked claims from the content policy registry. | AI Service | policy IDs, narrative plan | allowed content set | Automated |
| A4 | AI service constructs retrieval query text representing the buyer's situation and intent. | AI Service | profile object, workflow target, objection state | semantic query | Automated |
| A5 | AI service sends the retrieval query for embedding generation. | AI Service | semantic query | embedding vector | Automated |
| A6 | Vector retrieval service performs nearest-neighbor search across vectorized approved content, prior bridge assets, and approved proof snippets. | Vector Store | embedding vector, metadata filters | ranked candidates | Automated |
| A7 | Retrieval service groups nearest results by content family, persona fit, workflow relevance, and performance history. | Vector Store | ranked candidates | nearest groups | Automated |
| A8 | AI service selects top groups and discards low-confidence or policy-incompatible candidates. | AI Service | nearest groups, policy filters | filtered context pack | Automated |
| A9 | AI service builds final Gemini prompt with buyer context, retrieved snippets, required structure, tone instructions, and forbidden content. | AI Service | filtered context pack, prompt template | final prompt | Automated |
| A10 | AI service sends the final prompt to Gemini. | AI Service | final prompt | model request | Automated |
| A11 | Gemini produces structured output in JSON or schema-constrained text. | Gemini | model request | generated bridge or guidance draft | Automated |
| A12 | AI service validates schema, checks for hallucinated entities, and confirms required narrative anchors are present. | AI Service | generated draft | validated draft or exception | Automated |
| A13 | If validation fails, AI service retries with tighter constraints or falls back to a pre-approved static asset. | AI Service | validation result | revised draft or fallback asset | Automated |
| A14 | If validation passes but sensitivity is high, the asset enters a human approval queue. | AI Service, SE, Product Marketing | validated draft | approved or rejected asset | Human in the Loop |
| A15 | Approved output is cached and bound to the journey runtime so the UI can render it with low latency. | Orchestration Platform | approved asset | renderable guidance module | Automated |

## Human-Orchestrated Versus Automated Summary

| Capability Area | Human-Orchestrated Elements | Automated Elements | Human-in-the-Loop Elements |
| --- | --- | --- | --- |
| Narrative strategy | value proposition, narrative hierarchy, workflow priority, objection framing | none | review of AI-suggested narratives |
| Experience assembly | selection of allowed branches and priorities | presentation-layer assembly, data injection, URL creation, module loading | approval of blocked or exceptional paths |
| Guidance generation | policy definition and approved message boundaries | prompt building, retrieval, Gemini generation, runtime rendering | review of high-risk outputs |
| Runtime navigation | buyer choices and seller intervention strategy | state updates, bridge injection, next-step recommendation, analytics capture | seller response to high-value alerts |
| Post-session optimization | KPI definitions and governance thresholds | scoring, summarization, CRM writeback | AE review of follow-up content |

## Glossary-to-Workflow Crosswalk

| Glossary Item | Where It Appears Most Clearly in the Workflow |
| --- | --- |
| Unified Narrative Infrastructure | steps 1 to 7, 22 to 27, 44 to 45, 73 |
| Presentation Layer | steps 7, 25, 45, 49 to 58 |
| Narrative Orchestration Engine | steps 3, 24, 52, 54 |
| Human-Led Orchestration | steps 8 to 15, 30, 34, 38, 65, 72 |
| Persistent Context | steps 4 to 5, 16 to 21, 46 to 48, 57 |
| Journey State Tracking | steps 5, 19, 27, 47, 52, 59, 67 to 70 |
| Narrative Continuity | steps 9, 12 to 13, 22 to 24, 49 to 57 |
| Context Bridges | steps 28, 31 to 39, 54 to 56, 62, A1 to A15 |
| Persistent Guidance Layer | steps 28 to 39, 49 to 50, 60, 64 |
| Operationalized Personalization | steps 20 to 21, 22, 40 to 43, 53 |
| Structured Branching Logic | steps 6, 10, 24, 51 to 54 |
| Governed Exploration Pathways | steps 14, 34, 52 to 55, 63 |
| Narrative Integrity Score | step 69, 73 |
| Granular Intent Capture | steps 27, 43, 58, 61, 66, 68, 70 |
## Practical Reading

Stage 4 is human-led orchestration with system-level execution.

That means people still define the narrative strategy, approved branches, messaging guardrails, and escalation paths, while the platform automates assembly, guidance presentation, state updates, analytics capture, and seller activation.

Even when Gemini is used inside Stage 4, it operates within human-defined prompts, approved content boundaries, retrieval filters, and policy checks. In this model, AI supports delivery and explanation. It does not independently set journey strategy.