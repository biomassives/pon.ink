<template>
  <q-dialog v-model="show" persistent transition-show="fade" transition-hide="fade">
    <q-card class="bg-black text-white q-pa-xl text-center">
      <div class="zen-ink-text text-h2 q-mb-md text-white">RESONANCE</div>
      <p class="font-mono text-grey-5">Browser Audio Context requires a human touch.</p>
      <q-btn outline color="white" label="INITIALIZE SIGNAL" class="q-px-xl q-py-md" @click="init" />
    </q-card>
  </q-dialog>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
import { useAudioEngine } from 'core/composables/useAudioEngine';

export default defineComponent({
  setup() {
    const show = ref(true);
    const { initEngine } = useAudioEngine();
    const init = () => {
      initEngine();
      show.value = false;
    };
    return { show, init };
  }
});
</script>
