<template>
  <q-page class="bg-black text-white page-root">

    <!-- Ambient zone blobs - sit behind everything -->
    <div class="blobs" aria-hidden="true">
      <div
        :class="['blob blob--create', {
          'blob--active': focusedZone === 'create',
          'blob--dim':    focusedZone && focusedZone !== 'create'
        }]"
      />
      <div
        :class="['blob blob--connect', {
          'blob--active': focusedZone === 'connect',
          'blob--dim':    focusedZone && focusedZone !== 'connect'
        }]"
      />
      <div
        :class="['blob blob--exchange', {
          'blob--active': focusedZone === 'exchange',
          'blob--dim':    focusedZone && focusedZone !== 'exchange'
        }]"
      />
    </div>

    <!-- Venn rings - SVG overlay, right-column anchored -->
    <svg class="venn-rings" viewBox="0 0 380 360" aria-hidden="true" preserveAspectRatio="xMidYMid meet">
      <circle
        cx="145" cy="148" r="128"
        fill="none"
        :stroke="focusedZone === 'create' ? '#3d5afe' : '#1c1c1c'"
        stroke-width="1"
        :class="['ring', { 'ring--lit': focusedZone === 'create' }]"
      />
      <circle
        cx="235" cy="148" r="128"
        fill="none"
        :stroke="focusedZone === 'connect' ? '#ff3d00' : '#1c1c1c'"
        stroke-width="1"
        :class="['ring', { 'ring--lit': focusedZone === 'connect' }]"
      />
      <circle
        cx="190" cy="222" r="128"
        fill="none"
        :stroke="focusedZone === 'exchange' ? '#21ba45' : '#1c1c1c'"
        stroke-width="1"
        :class="['ring', { 'ring--lit': focusedZone === 'exchange' }]"
      />
    </svg>

    <div class="page-inner q-px-md q-py-xl">

      <!-- Header -->
      <header :class="['text-center q-mb-xl side-content', { 'side-content--gone': !!activeNode }]">
        <h1 class="text-h2 text-weight-bolder tracking-tighter q-mb-none">
          pon<span class="text-secondary">.</span>ink
        </h1>
        <div class="font-mono text-grey-7 text-uppercase tracking-widest text-caption">
          Production Support Portal · SCD Hub
        </div>
      </header>

      <section class="row q-col-gutter-xl items-center">

        <!-- Left: tagline + CTAs -->
        <div :class="['col-12 col-md-6 side-content', { 'side-content--gone': !!activeNode }]">
          <div class="text-overline text-secondary q-mb-md font-mono">Educate · Empower · Voice</div>
          <h2 class="text-h3 text-weight-bold q-mt-none line-height-tight">
            Built for those building<br>
            <span class="text-italic font-serif text-weight-light">from the margins.</span>
          </h2>
          <p class="text-subtitle1 text-grey-5 text-weight-light q-pr-lg">
            pon.ink is the production portal for <strong>SCD Hub</strong> — open infrastructure
            for ghetto youth, educators displaced by war or climate migration, and community
            builders who need real tools without gatekeeping. Sound, water, health, exchange:
            <strong>yours by right, not by privilege.</strong>
          </p>
          <div class="q-mt-xl row q-gutter-md">
            <q-btn unelevated color="secondary" label="Open Sampler" icon="tune" to="/sampler" class="q-px-lg q-py-md" />
            <q-btn outline color="white" label="Eco Ops" icon="eco" to="/nairobi" class="q-px-lg q-py-md" />
          </div>
        </div>

        <!-- Right: cards / expanded panel -->
        <div class="col-12 col-md-6 cards-col">

          <!-- Normal 2×2 grid -->
          <transition name="grid">
            <div v-if="!activeNode" class="row q-col-gutter-md">
              <div
                v-for="node in nodes"
                :key="node.title"
                class="col-6"
                @mouseenter="hoveredNode = node"
                @mouseleave="hoveredNode = null"
              >
                <q-card
                  flat
                  class="node-card bg-grey-10 q-pa-lg full-height relative-position overflow-hidden cursor-pointer"
                  :style="hoveredNode?.title === node.title ? { borderColor: node.hex, background: '#0d0d0d' } : {}"
                  @click="openNode(node)"
                >
                  <q-icon :name="node.icon" size="sm" class="q-mb-md" :style="{ color: node.hex }" />
                  <div class="text-weight-bold text-h6 q-mb-xs">{{ node.title }}</div>
                  <div class="text-caption text-grey-6 line-height-base">{{ node.desc }}</div>

                  <!-- Ghost icon -->
                  <div class="ghost-icon absolute-bottom-right q-pr-sm q-pb-sm">
                    <q-icon :name="node.icon" size="100px" color="grey-9" />
                  </div>

                  <!-- Zone tag bottom-left -->
                  <div class="zone-tag font-mono absolute-bottom-left q-pl-md q-pb-sm" :style="{ color: node.hex }">
                    {{ node.zone }}
                  </div>
                </q-card>
              </div>
            </div>
          </transition>

          <!-- Expanded panel -->
          <transition name="panel">
            <div v-if="activeNode" class="expanded-panel">

              <!-- Colored accent bar -->
              <div class="accent-bar" :style="{ background: activeNode.hex }" />

              <div class="q-pa-xl">

                <!-- Top row -->
                <div class="row items-center justify-between q-mb-lg">
                  <span class="font-mono text-grey-7 zone-heading">{{ activeNode.zone }}</span>
                  <q-btn flat round dense icon="close" color="grey-6" size="sm" @click="closeNode" />
                </div>

                <!-- Icon + title -->
                <q-icon :name="activeNode.icon" size="52px" class="q-mb-md" :style="{ color: activeNode.hex }" />
                <div class="text-h4 text-weight-bold q-mb-sm">{{ activeNode.title }}</div>
                <div class="text-body1 text-grey-5 q-mb-xl">{{ activeNode.desc }}</div>

                <!-- Detail bullets -->
                <div class="q-mb-xl">
                  <div
                    v-for="(detail, i) in activeNode.details"
                    :key="detail"
                    class="detail-row font-mono text-caption text-grey-4 q-mb-sm"
                    :style="{ transitionDelay: `${i * 60}ms` }"
                  >
                    <span class="detail-arrow q-mr-sm" :style="{ color: activeNode.hex }">→</span>
                    {{ detail }}
                  </div>
                </div>

                <div class="row q-gutter-md items-center">
                  <q-btn
                    unelevated
                    :label="activeNode.cta.label"
                    :to="activeNode.cta.to"
                    class="font-mono q-px-xl"
                    :style="{ background: activeNode.hex, color: '#000' }"
                  />
                  <q-btn
                    flat no-caps color="grey-7"
                    label="← back"
                    class="font-mono"
                    @click="closeNode"
                  />
                </div>

              </div>
            </div>
          </transition>

        </div>
      </section>

      <!-- Footer -->
      <footer :class="['q-mt-xl q-pt-xl border-top-dark text-center side-content', { 'side-content--gone': !!activeNode }]">
        <div class="row justify-center q-gutter-xl q-mb-md">
          <div class="text-caption text-grey-7"><span class="text-white">Eco Ops:</span> Active</div>
          <div class="text-caption text-grey-7"><span class="text-white">M-Pesa Bridge:</span> Online</div>
          <div class="text-caption text-grey-7"><span class="text-white">Health ID:</span> Open Spec</div>
        </div>
        <p class="text-caption text-grey-9 uppercase tracking-widest">
          Open Source &bull; Non-Proprietary &bull; Community Governed
        </p>
      </footer>

    </div>
  </q-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

type Zone = 'create' | 'connect' | 'exchange';

interface Node {
  title: string;
  desc: string;
  icon: string;
  hex: string;
  zone: Zone;
  details: string[];
  cta: { label: string; to: string };
}

const nodes: Node[] = [
  {
    title: 'Sound Lab',
    desc: 'Your voice is the asset. Record, sample, and mint street resonance as $BARS audio tokens.',
    icon: 'graphic_eq',
    hex: '#3d5afe',
    zone: 'create',
    details: [
      '440Hz figure calibration — no gear required',
      '16-pad sampler grid with full touch support',
      'Tokenize as $BARS audio NFTs on-chain',
      'Unlock via M-Pesa KES or Stripe USD',
    ],
    cta: { label: 'Open Sampler', to: '/sampler' },
  },
  {
    title: 'Eco Ops',
    desc: 'Environmental infrastructure mapping for communities that can\'t wait for government.',
    icon: 'eco',
    hex: '#ff3d00',
    zone: 'connect',
    details: [
      'Real-time urban water pipe and node mapping',
      'Cross-connection and contamination detection',
      'Distributed Eco Ops field node network',
      'Open data export — non-proprietary formats',
    ],
    cta: { label: 'View Eco Ops', to: '/nairobi' },
  },
  {
    title: 'Health ID',
    desc: 'Offline-first health verification for displaced, migrant, and stateless populations.',
    icon: 'badge',
    hex: '#ff3d00',
    zone: 'connect',
    details: [
      'Works fully offline — no connectivity required',
      'Cross-border interoperability standard',
      'Community health worker mobile tools',
      'Zero vendor lock-in — open spec, yours to fork',
    ],
    cta: { label: 'Read Standard', to: '/nairobi' },
  },
  {
    title: 'Exchange',
    desc: 'Payment pathways that work where you are — no bank account required.',
    icon: 'currency_exchange',
    hex: '#21ba45',
    zone: 'exchange',
    details: [
      'M-Pesa KES — works on a basic handset',
      'Stripe USD — global card and wallet support',
      'Automatic currency and locale detection',
      'NFT sample bank unlocks on payment confirm',
    ],
    cta: { label: 'Test Payment', to: '/nairobi-checkout' },
  },
];

const hoveredNode = ref<Node | null>(null);
const activeNode  = ref<Node | null>(null);

const focusedZone = computed<Zone | null>(
  () => activeNode.value?.zone ?? hoveredNode.value?.zone ?? null
);

function openNode(node: Node) {
  hoveredNode.value = null;
  activeNode.value  = node;
}

function closeNode() {
  activeNode.value = null;
}
</script>

<style scoped>
/* ─── Page shell ─────────────────────────────────────────────── */
.page-root {
  position: relative;
  overflow: hidden;
  min-height: 100vh;
}
.page-inner {
  position: relative;
  z-index: 2;
  max-width: 1100px;
  margin: 0 auto;
}

/* ─── Ambient blobs ──────────────────────────────────────────── */
.blobs {
  position: fixed;
  inset: 0;
  pointer-events: none;
  z-index: 0;
}
.blob {
  position: absolute;
  border-radius: 50%;
  filter: blur(90px);
  transition: transform 0.8s cubic-bezier(0.4, 0, 0.2, 1),
              opacity   0.8s cubic-bezier(0.4, 0, 0.2, 1);
}
.blob--create  { width: 500px; height: 500px; top: -10%; right: 10%;  background: #3d5afe; opacity: 0.04; transform: scale(1);   }
.blob--connect { width: 420px; height: 420px; top:  5%;  right: -5%;  background: #ff3d00; opacity: 0.04; transform: scale(1);   }
.blob--exchange{ width: 460px; height: 460px; top: 30%;  right: 5%;   background: #21ba45; opacity: 0.04; transform: scale(1);   }

.blob--active  { opacity: 0.13 !important; transform: scale(1.9) !important; }
.blob--dim     { opacity: 0.01 !important; transform: scale(0.7) !important; }

/* ─── Venn rings SVG ─────────────────────────────────────────── */
.venn-rings {
  position: fixed;
  top: 50%;
  right: -60px;
  width: 520px;
  height: 520px;
  transform: translateY(-48%);
  pointer-events: none;
  z-index: 1;
}
.ring {
  transition: stroke 0.5s ease, stroke-width 0.5s ease, opacity 0.5s ease;
  opacity: 0.5;
}
.ring--lit {
  stroke-width: 1.5 !important;
  opacity: 1;
  filter: drop-shadow(0 0 6px currentColor);
}

/* ─── Side content fade ──────────────────────────────────────── */
.side-content {
  transition: opacity 0.45s ease, transform 0.45s ease;
}
.side-content--gone {
  opacity: 0;
  transform: translateX(-24px);
  pointer-events: none;
}

/* ─── Cards col ──────────────────────────────────────────────── */
.cards-col {
  position: relative;
  min-height: 360px;
}

/* ─── Node cards ─────────────────────────────────────────────── */
.node-card {
  border: 1px solid #1e1e1e;
  transition: border-color 0.35s ease, background 0.35s ease, transform 0.25s ease;
}
.node-card:hover {
  transform: translateY(-4px);
}
.ghost-icon {
  opacity: 0.04;
}
.zone-tag {
  font-size: 8px;
  letter-spacing: 3px;
  text-transform: uppercase;
  opacity: 0.6;
}
.line-height-base { line-height: 1.5; }

/* ─── Grid transition ────────────────────────────────────────── */
.grid-leave-active { transition: opacity 0.25s ease, transform 0.25s ease; position: absolute; width: 100%; }
.grid-leave-to     { opacity: 0; transform: scale(0.94); }
.grid-enter-active { transition: opacity 0.35s ease 0.1s, transform 0.35s ease 0.1s; }
.grid-enter-from   { opacity: 0; transform: scale(0.94); }

/* ─── Expanded panel ─────────────────────────────────────────── */
.expanded-panel {
  border: 1px solid #1e1e1e;
  background: #060606;
  overflow: hidden;
}
.accent-bar {
  height: 3px;
  width: 100%;
}
.zone-heading {
  font-size: 9px;
  letter-spacing: 4px;
  text-transform: uppercase;
}
.detail-row {
  letter-spacing: 0.3px;
  opacity: 0;
  animation: slide-in 0.4s ease forwards;
}
.detail-arrow {
  font-weight: 700;
}

@keyframes slide-in {
  from { opacity: 0; transform: translateX(-12px); }
  to   { opacity: 1; transform: translateX(0); }
}

/* ─── Panel transition ───────────────────────────────────────── */
.panel-enter-active { transition: opacity 0.4s ease 0.2s, transform 0.4s ease 0.2s; }
.panel-enter-from   { opacity: 0; transform: translateY(28px) scale(0.97); }
.panel-leave-active { transition: opacity 0.2s ease, transform 0.2s ease; }
.panel-leave-to     { opacity: 0; transform: translateY(-16px) scale(0.97); }

/* ─── Typography helpers ─────────────────────────────────────── */
.tracking-tighter  { letter-spacing: -4px; }
.tracking-widest   { letter-spacing: 5px; }
.line-height-tight { line-height: 1.1; }
.border-top-dark   { border-top: 1px solid #1a1a1a; }
.font-serif        { font-family: 'Georgia', serif; }
</style>
