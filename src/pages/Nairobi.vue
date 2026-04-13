<template>
  <q-page class="bg-black text-white onboard-root">

    <!-- Subtle grid texture -->
    <div class="grid-texture" aria-hidden="true" />

    <div class="onboard-inner q-px-md q-py-xl">

      <!-- ── Mission header ───────────────────────────────────── -->
      <header class="text-center q-mb-xl">
        <div class="font-mono text-secondary text-uppercase tracking-widest text-caption q-mb-sm">
          SCD Hub · Production Portal
        </div>
        <h1 class="text-h2 text-weight-bold q-mb-md line-height-tight">
          Tools that belong<br>
          <span class="text-italic font-serif text-weight-light text-grey-5">to everyone.</span>
        </h1>
        <p class="text-subtitle1 text-grey-5 text-weight-light q-mx-auto mission-para">
          pon.ink is the open production portal for SCD Hub — a distributed infrastructure
          network for sound, environment, health, and economic access. No gatekeeping.
          No vendor lock-in. Built with and for communities pushed to the margins by poverty,
          conflict, and climate displacement.
        </p>
      </header>

      <!-- ── Who this is for ─────────────────────────────────── -->
      <section class="q-mb-xl">
        <div class="section-label font-mono text-grey-7 q-mb-lg">Who this is for</div>
        <div class="row q-col-gutter-lg">
          <div v-for="archetype in archetypes" :key="archetype.id" class="col-12 col-sm-4">
            <div
              class="archetype-card q-pa-lg"
              :class="{ 'archetype-card--active': selectedArchetype === archetype.id }"
              :style="selectedArchetype === archetype.id ? { borderColor: archetype.hex } : {}"
              @click="selectedArchetype = archetype.id"
            >
              <q-icon :name="archetype.icon" size="32px" class="q-mb-md" :style="{ color: archetype.hex }" />
              <div class="text-weight-bold q-mb-xs">{{ archetype.label }}</div>
              <div class="text-caption text-grey-6 line-height-base">{{ archetype.desc }}</div>
              <div class="q-mt-md">
                <q-chip
                  v-for="tag in archetype.tags"
                  :key="tag"
                  dense
                  outline
                  size="sm"
                  class="font-mono"
                  :style="{ borderColor: archetype.hex, color: archetype.hex }"
                >
                  {{ tag }}
                </q-chip>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- ── Workflow: Educate → Empower → Voice ─────────────── -->
      <section class="q-mb-xl">
        <div class="section-label font-mono text-grey-7 q-mb-lg">The workflow</div>
        <div class="row q-col-gutter-md items-stretch">
          <div v-for="(phase, i) in phases" :key="phase.title" class="col-12 col-md-4">
            <div class="phase-card q-pa-lg full-height">
              <div class="phase-number font-mono text-grey-9 q-mb-sm">0{{ i + 1 }}</div>
              <div class="phase-title text-h5 text-weight-bold q-mb-sm" :style="{ color: phase.hex }">
                {{ phase.title }}
              </div>
              <p class="text-body2 text-grey-5 line-height-base q-mb-md">{{ phase.desc }}</p>
              <ul class="phase-list">
                <li v-for="item in phase.items" :key="item" class="text-caption text-grey-6 font-mono q-mb-xs">
                  <span :style="{ color: phase.hex }">›</span> {{ item }}
                </li>
              </ul>
            </div>
            <!-- Arrow between phases -->
            <div v-if="i < phases.length - 1" class="phase-arrow text-grey-8 font-mono text-center q-my-sm hidden-sm-and-up">
              ↓
            </div>
          </div>
        </div>
      </section>

      <!-- ── Eco Ops status + entry ───────────────────────────── -->
      <section class="q-mb-xl">
        <div class="section-label font-mono text-grey-7 q-mb-lg">Eco Ops — Field Node Status</div>
        <div class="row q-col-gutter-lg">

          <!-- Status panel -->
          <div class="col-12 col-md-5">
            <div class="status-panel q-pa-lg">
              <div class="row items-center q-mb-md">
                <q-icon name="eco" size="20px" color="positive" class="q-mr-sm" />
                <span class="text-weight-bold">Network Status</span>
                <q-space />
                <span class="font-mono text-caption text-positive">● LIVE</span>
              </div>
              <q-separator color="grey-9" class="q-mb-md" />
              <div v-for="node in ecoNodes" :key="node.label" class="row items-center q-mb-sm">
                <div class="node-dot q-mr-sm" :class="`node-dot--${node.status}`" />
                <span class="text-caption text-grey-5 font-mono">{{ node.label }}</span>
                <q-space />
                <span class="text-caption font-mono" :class="node.status === 'active' ? 'text-positive' : node.status === 'pending' ? 'text-warning' : 'text-grey-7'">
                  {{ node.value }}
                </span>
              </div>
            </div>
          </div>

          <!-- What Eco Ops does -->
          <div class="col-12 col-md-7">
            <div class="eco-desc q-pa-lg full-height">
              <h3 class="text-h5 text-weight-bold q-mt-none q-mb-md">
                Environmental infrastructure,<br>community-owned.
              </h3>
              <p class="text-body2 text-grey-5 line-height-base q-mb-lg">
                Eco Ops is the field operations layer of SCD Hub. We map water systems,
                detect contamination events, and build distributed sensor networks in
                underserved urban areas — producing open data that communities control
                and governments can't quietly delete.
              </p>
              <div class="row q-gutter-md">
                <q-btn unelevated color="positive" label="Join Field Network" icon="sensors" class="q-px-lg font-mono" />
                <q-btn flat color="grey-5" label="Read the spec" icon="description" class="font-mono" />
              </div>
            </div>
          </div>

        </div>
      </section>

      <!-- ── Get started ─────────────────────────────────────── -->
      <section class="q-mb-xl">
        <div class="section-label font-mono text-grey-7 q-mb-lg">Get started</div>
        <div class="row q-col-gutter-md">
          <div v-for="entry in entryPoints" :key="entry.label" class="col-12 col-sm-6 col-md-3">
            <q-btn
              unelevated
              :to="entry.to"
              class="entry-btn full-width q-pa-lg font-mono"
              :style="{ background: entry.hex + '18', borderColor: entry.hex }"
            >
              <div class="column items-center q-gutter-sm">
                <q-icon :name="entry.icon" size="28px" :style="{ color: entry.hex }" />
                <div class="text-weight-bold text-white">{{ entry.label }}</div>
                <div class="text-caption text-grey-6 text-center" style="white-space: normal;">{{ entry.sub }}</div>
              </div>
            </q-btn>
          </div>
        </div>
      </section>

      <!-- ── Footer note ─────────────────────────────────────── -->
      <footer class="text-center q-pt-xl border-top-dark">
        <p class="text-caption text-grey-8 font-mono q-mb-xs">
          pon.ink is production infrastructure. SCD Hub is the parent organization and network.
        </p>
        <p class="text-caption text-grey-9 uppercase tracking-widest">
          Open Source &bull; Community Governed &bull; Radically Transparent
        </p>
      </footer>

    </div>
  </q-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';

defineOptions({ name: 'NairobiOnboarding' });

const selectedArchetype = ref<string | null>(null);

const archetypes = [
  {
    id: 'youth',
    label: 'Ghetto Youth',
    icon: 'headphones',
    hex: '#3d5afe',
    desc: 'You make music, art, and culture with what you have. Sound Lab turns your craft into tokens you own — no label, no middleman.',
    tags: ['Sound Lab', '$BARS tokens', 'M-Pesa'],
  },
  {
    id: 'educator',
    label: 'Educator in Exile',
    icon: 'school',
    hex: '#ff3d00',
    desc: 'Displaced by conflict or climate — your knowledge doesn\'t stop at a border. Carry credentials that work offline and across systems.',
    tags: ['Health ID', 'Offline-first', 'Open spec'],
  },
  {
    id: 'builder',
    label: 'Community Builder',
    icon: 'groups',
    hex: '#21ba45',
    desc: 'Organizing water, health, or economic access for your neighbourhood. Eco Ops gives you the mapping and data tools that were built for this.',
    tags: ['Eco Ops', 'Water mapping', 'Open data'],
  },
];

const phases = [
  {
    title: 'Educate',
    hex: '#3d5afe',
    desc: 'Access open curriculum, documentation, and skill-building pathways — in your language, at your pace, with no prerequisite income.',
    items: [
      'Vocational skills modules',
      'Open AI & full-stack curriculum',
      'Environmental engineering basics',
      'Health worker certification paths',
    ],
  },
  {
    title: 'Empower',
    hex: '#ff3d00',
    desc: 'Turn knowledge into deployable tools. Every module connects directly to a working production system you can run yourself.',
    items: [
      'Deploy your own Eco Ops node',
      'Launch a local $BARS sampler session',
      'Issue Health IDs to your community',
      'Set up M-Pesa or Stripe payment flows',
    ],
  },
  {
    title: 'Voice',
    hex: '#21ba45',
    desc: 'Your data, your signal, your ownership. Everything built here is yours — on-chain, open-spec, and non-proprietary.',
    items: [
      'Mint audio as $BARS NFTs',
      'Publish open environmental data',
      'Control your own health records',
      'Earn from your contributions',
    ],
  },
];

const ecoNodes = [
  { label: 'Nairobi Urban Water Grid', status: 'active',  value: 'Connected' },
  { label: 'Cross-connection Detection', status: 'active',  value: 'Running' },
  { label: 'Field Sensor Network',       status: 'pending', value: 'Onboarding' },
  { label: 'M-Pesa Bridge',             status: 'active',  value: 'Online' },
  { label: 'Open Data Export',           status: 'active',  value: 'Non-proprietary' },
  { label: 'West Africa Node',           status: 'inactive', value: 'Planned' },
];

const entryPoints = [
  { label: 'Sound Lab',  icon: 'graphic_eq',      hex: '#3d5afe', to: '/sampler',          sub: 'Record & mint audio' },
  { label: 'Eco Ops',   icon: 'eco',              hex: '#21ba45', to: '/nairobi',          sub: 'Water & env mapping' },
  { label: 'Audio Lab', icon: 'speaker',          hex: '#9c27b0', to: '/audio-lab',        sub: '440Hz calibration' },
  { label: 'Exchange',  icon: 'currency_exchange', hex: '#ff9800', to: '/nairobi-checkout', sub: 'M-Pesa · Stripe' },
];
</script>

<style scoped>
/* ─── Page shell ───────────────────────────────────────────── */
.onboard-root {
  position: relative;
  min-height: 100vh;
}
.grid-texture {
  position: fixed;
  inset: 0;
  pointer-events: none;
  background-image:
    linear-gradient(rgba(255,255,255,0.012) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255,255,255,0.012) 1px, transparent 1px);
  background-size: 48px 48px;
  z-index: 0;
}
.onboard-inner {
  position: relative;
  z-index: 1;
  max-width: 1080px;
  margin: 0 auto;
}

/* ─── Mission para ─────────────────────────────────────────── */
.mission-para {
  max-width: 640px;
}

/* ─── Section label ────────────────────────────────────────── */
.section-label {
  font-size: 9px;
  letter-spacing: 4px;
  text-transform: uppercase;
  border-left: 2px solid #1e1e1e;
  padding-left: 12px;
}

/* ─── Archetype cards ──────────────────────────────────────── */
.archetype-card {
  border: 1px solid #1a1a1a;
  background: #080808;
  cursor: pointer;
  transition: border-color 0.3s ease, background 0.3s ease;
}
.archetype-card:hover,
.archetype-card--active {
  background: #0e0e0e;
}
.line-height-base { line-height: 1.55; }

/* ─── Phase cards ──────────────────────────────────────────── */
.phase-card {
  border: 1px solid #141414;
  background: #060606;
}
.phase-number {
  font-size: 40px;
  font-weight: 800;
  line-height: 1;
  letter-spacing: -2px;
}
.phase-title {
  line-height: 1.15;
}
.phase-list {
  list-style: none;
  padding: 0;
  margin: 0;
}
.phase-list li {
  line-height: 1.6;
}

/* ─── Status panel ─────────────────────────────────────────── */
.status-panel {
  border: 1px solid #1a1a1a;
  background: #080808;
  height: 100%;
}
.node-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  flex-shrink: 0;
}
.node-dot--active  { background: #21ba45; }
.node-dot--pending { background: #f2a61d; }
.node-dot--inactive { background: #333; }

/* ─── Eco desc ─────────────────────────────────────────────── */
.eco-desc {
  border: 1px solid #1a1a1a;
  background: #080808;
}

/* ─── Entry buttons ────────────────────────────────────────── */
.entry-btn {
  border: 1px solid;
  border-radius: 2px !important;
  transition: opacity 0.2s ease;
  text-transform: none !important;
}
.entry-btn:hover {
  opacity: 0.85;
}

/* ─── Footer ───────────────────────────────────────────────── */
.border-top-dark { border-top: 1px solid #141414; }
.tracking-widest { letter-spacing: 5px; }
.font-mono  { font-family: 'JetBrains Mono', 'Courier New', monospace; }
.font-serif { font-family: 'Georgia', serif; }
.line-height-tight { line-height: 1.1; }
</style>
