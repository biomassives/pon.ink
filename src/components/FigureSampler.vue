<template>
  <div class="q-pa-md">
    <div class="row q-col-gutter-md">
      <div v-for="pad in pads" :key="pad.id" class="col-3">
        <q-btn
          square
          unelevated
          :color="pad.active ? 'accent' : 'grey-9'"
          class="full-width pad-square"
          @mousedown="hitPad(pad)"
        >
          <div class="font-mono text-caption">{{ pad.label }}</div>
        </q-btn>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';

// Define the interface to kill the 'any' error
interface InstrumentPad {
  id: number;
  label: string;
  type: 'synth' | 'sample';
  active: boolean;
}

export default defineComponent({
  name: 'FigureSampler',
  setup() {
    const pads = ref<InstrumentPad[]>([
      { id: 1, label: 'KICK', type: 'synth', active: false },
      { id: 2, label: 'SNARE', type: 'sample', active: false },
      { id: 3, label: 'HAT', type: 'sample', active: false },
      { id: 4, label: 'CLAP', type: 'sample', active: false }
    ]);

    const hitPad = (pad: InstrumentPad) => {
      console.log(`Triggering ${pad.label}`);
      pad.active = true;
      setTimeout(() => { pad.active = false; }, 150);
    };

    return { pads, hitPad };
  }
});
</script>

<style lang="scss">
.pad-square {
  aspect-ratio: 1;
  border: 1px solid rgba(255,255,255,0.1);
}
</style>
