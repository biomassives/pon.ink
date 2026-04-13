<template>
  <div class="role-selector">

    <q-btn flat no-caps class="access-trigger font-mono" @click="menuOpen = true">
      <span class="trigger-access">ACCESS</span>
      <span class="trigger-pon q-mx-xs">PON.INK</span>
      <q-icon
        :name="menuOpen ? 'keyboard_arrow_up' : 'keyboard_arrow_down'"
        size="16px"
        class="trigger-arrow"
      />

      <q-menu
        v-model="menuOpen"
        anchor="bottom middle"
        self="top middle"
        class="role-menu"
        :offset="[0, 10]"
        transition-show="jump-down"
        transition-hide="jump-up"
      >
        <div class="menu-inner q-pa-lg">
          <div class="font-mono text-grey-7 text-uppercase q-mb-md menu-heading">
            Select your signal
          </div>
          <div class="row q-col-gutter-xs">
            <div v-for="role in roles" :key="role.id" class="col-6">
              <q-btn
                flat
                no-caps
                align="left"
                :class="['role-chip full-width font-mono', selectedRole?.id === role.id ? 'role-chip--active' : '']"
                @click="selectRole(role)"
              >
                <q-icon :name="role.icon" size="13px" class="q-mr-sm chip-icon" />
                {{ role.label }}
              </q-btn>
            </div>
          </div>
        </div>
      </q-menu>
    </q-btn>

    <!-- Venn diagram dialog -->
    <q-dialog v-model="showVenn">
      <q-card class="venn-card bg-black text-white q-pa-xl" v-if="selectedRole">

        <div class="row items-start justify-between q-mb-lg">
          <div>
            <div class="font-mono text-grey-7 text-uppercase venn-heading q-mb-xs">Signal Profile</div>
            <div class="text-h5 text-weight-bold">
              <q-icon :name="selectedRole.icon" color="secondary" size="22px" class="q-mr-sm" />
              {{ selectedRole.label }}
            </div>
          </div>
          <q-btn flat round dense icon="close" color="grey-7" v-close-popup />
        </div>

        <!-- Venn SVG -->
        <div class="venn-wrap q-mb-lg">
          <svg viewBox="0 0 300 268" xmlns="http://www.w3.org/2000/svg" class="venn-svg">
            <defs>
              <filter id="glow-c">
                <feGaussianBlur stdDeviation="5" result="blur" />
                <feMerge><feMergeNode in="blur" /><feMergeNode in="SourceGraphic" /></feMerge>
              </filter>
              <filter id="glow-k">
                <feGaussianBlur stdDeviation="5" result="blur" />
                <feMerge><feMergeNode in="blur" /><feMergeNode in="SourceGraphic" /></feMerge>
              </filter>
              <filter id="glow-e">
                <feGaussianBlur stdDeviation="5" result="blur" />
                <feMerge><feMergeNode in="blur" /><feMergeNode in="SourceGraphic" /></feMerge>
              </filter>
            </defs>

            <!-- Circles rendered with screen blend -->
            <g style="mix-blend-mode: screen;">
              <circle
                cx="112" cy="112" r="87"
                fill="#3d5afe"
                :fill-opacity="activeZones.includes('create') ? 0.78 : 0.07"
                :filter="activeZones.includes('create') ? 'url(#glow-c)' : ''"
                class="venn-circle"
              />
              <circle
                cx="188" cy="112" r="87"
                fill="#ff3d00"
                :fill-opacity="activeZones.includes('connect') ? 0.78 : 0.07"
                :filter="activeZones.includes('connect') ? 'url(#glow-k)' : ''"
                class="venn-circle"
              />
              <circle
                cx="150" cy="178" r="87"
                fill="#21ba45"
                :fill-opacity="activeZones.includes('exchange') ? 0.78 : 0.07"
                :filter="activeZones.includes('exchange') ? 'url(#glow-e)' : ''"
                class="venn-circle"
              />
            </g>

            <!-- CREATE label -->
            <text
              x="68" y="56"
              text-anchor="middle"
              font-family="monospace"
              font-size="8.5"
              font-weight="700"
              letter-spacing="1"
              :fill="activeZones.includes('create') ? '#ffffff' : '#333'"
              class="zone-label"
            >CREATE</text>
            <text
              x="68" y="68"
              text-anchor="middle"
              font-family="monospace"
              font-size="6.5"
              :fill="activeZones.includes('create') ? '#aaa' : '#2a2a2a'"
              class="zone-sublabel"
            >sound · nft · cms</text>

            <!-- CONNECT label -->
            <text
              x="232" y="56"
              text-anchor="middle"
              font-family="monospace"
              font-size="8.5"
              font-weight="700"
              letter-spacing="1"
              :fill="activeZones.includes('connect') ? '#ffffff' : '#333'"
              class="zone-label"
            >CONNECT</text>
            <text
              x="232" y="68"
              text-anchor="middle"
              font-family="monospace"
              font-size="6.5"
              :fill="activeZones.includes('connect') ? '#aaa' : '#2a2a2a'"
              class="zone-sublabel"
            >health · water · hub</text>

            <!-- EXCHANGE label -->
            <text
              x="150" y="258"
              text-anchor="middle"
              font-family="monospace"
              font-size="8.5"
              font-weight="700"
              letter-spacing="1"
              :fill="activeZones.includes('exchange') ? '#ffffff' : '#333'"
              class="zone-label"
            >EXCHANGE</text>
            <text
              x="150" y="268"
              text-anchor="middle"
              font-family="monospace"
              font-size="6.5"
              :fill="activeZones.includes('exchange') ? '#aaa' : '#2a2a2a'"
              class="zone-sublabel"
            >mpesa · stripe · crypto</text>
          </svg>
        </div>

        <!-- Access chips -->
        <div class="font-mono text-grey-7 text-uppercase venn-heading q-mb-sm">Access Points</div>
        <div class="row q-gutter-xs q-mb-lg">
          <q-chip
            v-for="item in selectedRole.access"
            :key="item"
            outline
            color="secondary"
            text-color="white"
            class="font-mono access-chip"
            size="sm"
          >
            {{ item }}
          </q-chip>
        </div>

        <div class="row q-gutter-md items-center">
          <q-btn
            unelevated
            color="secondary"
            label="Enter Signal"
            class="font-mono q-px-xl"
            v-close-popup
          />
          <q-btn
            flat
            no-caps
            color="grey-7"
            label="Change role"
            class="font-mono"
            @click="showVenn = false; menuOpen = true"
          />
        </div>

      </q-card>
    </q-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

type Zone = 'create' | 'connect' | 'exchange';

interface Role {
  id: string;
  label: string;
  icon: string;
  zones: Zone[];
  access: string[];
}

const roles: Role[] = [
  { id: 'rapper',    label: 'Rapper',         icon: 'mic',                      zones: ['create', 'exchange'],            access: ['Sound Lab', '$BARS Tokens', 'Exchange'] },
  { id: 'beats',     label: 'Beats Provider', icon: 'graphic_eq',               zones: ['create', 'exchange'],            access: ['Sound Lab', 'Sample Banks', '$BARS Tokens', 'Exchange'] },
  { id: 'artist',    label: 'Artist',          icon: 'brush',                    zones: ['create', 'exchange'],            access: ['Sound Lab', 'Content CMS', '$BARS Tokens', 'Exchange'] },
  { id: 'educator',  label: 'Educator',        icon: 'school',                   zones: ['create', 'connect'],             access: ['Content CMS', 'Health ID', 'Water Maps'] },
  { id: 'engineer',  label: 'Engineer',        icon: 'code',                     zones: ['create', 'connect', 'exchange'], access: ['All Systems', 'Audio Lab', 'SCD Hub', 'Exchange'] },
  { id: 'leader',    label: 'Team Leader',     icon: 'groups',                   zones: ['create', 'connect', 'exchange'], access: ['All Systems', 'Admin Bridge', 'Governance'] },
  { id: 'studio',    label: 'Studio Tech',     icon: 'settings_input_component', zones: ['create'],                        access: ['Sound Lab', 'Sample Banks', 'Audio Tools'] },
  { id: 'producer',  label: 'Producer',        icon: 'album',                    zones: ['create', 'exchange'],            access: ['Sound Lab', '$BARS Tokens', 'Sample Banks', 'Exchange'] },
  { id: 'fan',       label: 'Fan',             icon: 'favorite',                 zones: ['create'],                        access: ['Sound Lab', 'Content'] },
  { id: 'poet',      label: 'Poet',            icon: 'edit_note',                zones: ['create'],                        access: ['Content CMS', 'Sound Lab'] },
  { id: 'donor',     label: 'Donor',           icon: 'volunteer_activism',       zones: ['connect', 'exchange'],           access: ['Exchange', 'Water Maps', 'Health ID'] },
  { id: 'legal',     label: 'Legal Person',    icon: 'gavel',                    zones: ['connect', 'exchange'],           access: ['Health ID', 'Exchange', 'Governance'] },
  { id: 'crypto',    label: 'Crypto Person',   icon: 'currency_bitcoin',         zones: ['create', 'exchange'],            access: ['$BARS Tokens', 'NFT Hub', 'Exchange'] },
];

const menuOpen = ref(false);
const showVenn = ref(false);
const selectedRole = ref<Role | null>(null);

const activeZones = computed<Zone[]>(() => selectedRole.value?.zones ?? []);

function selectRole(role: Role) {
  selectedRole.value = role;
  menuOpen.value = false;
  showVenn.value = true;
}
</script>

<style scoped>
/* Trigger button */
.access-trigger {
  border: 1px solid #252525;
  border-radius: 0;
  padding: 6px 14px;
  letter-spacing: 0.5px;
  transition: border-color 0.2s, background 0.2s;
}
.access-trigger:hover {
  border-color: #3d5afe;
  background: #0a0a0a !important;
}
.trigger-access {
  color: #3d5afe;
  font-weight: 700;
  font-size: 11px;
  letter-spacing: 2px;
}
.trigger-pon {
  color: #ccc;
  font-size: 11px;
  letter-spacing: 1px;
}
.trigger-arrow {
  color: #444;
}

/* Dropdown menu */
.role-menu {
  background: #080808 !important;
  border: 1px solid #1e1e1e !important;
  border-radius: 0 !important;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.8) !important;
}
.menu-inner {
  width: 360px;
  max-width: 92vw;
}
.menu-heading {
  font-size: 9px;
  letter-spacing: 3px;
}

/* Role chips in dropdown */
.role-chip {
  color: #444;
  font-size: 10px;
  letter-spacing: 0.5px;
  border: 1px solid #151515;
  border-radius: 0;
  padding: 7px 10px;
  transition: all 0.12s;
  text-transform: none;
}
.role-chip:hover {
  color: #ddd;
  border-color: #2a2a2a;
  background: #111 !important;
}
.role-chip--active {
  color: #3d5afe !important;
  border-color: #3d5afe !important;
  background: #05070f !important;
}
.chip-icon {
  opacity: 0.5;
  flex-shrink: 0;
}

/* Venn dialog card */
.venn-card {
  width: 500px;
  max-width: 95vw;
  border: 1px solid #1e1e1e !important;
  border-radius: 0 !important;
}
.venn-heading {
  font-size: 9px;
  letter-spacing: 3px;
}
.venn-wrap {
  background: #050505;
  border: 1px solid #111;
  padding: 8px;
}
.venn-svg {
  display: block;
  width: 100%;
}
.venn-circle {
  transition: fill-opacity 0.45s cubic-bezier(0.4, 0, 0.2, 1);
}
.zone-label {
  transition: fill 0.3s;
}
.zone-sublabel {
  transition: fill 0.3s;
}

/* Access chips */
.access-chip {
  font-size: 9px;
  letter-spacing: 1px;
  border-radius: 0 !important;
}
</style>
