<template>
  <q-page class="q-pa-xl bg-bone">
    <div class="row q-col-gutter-lg">
      <div class="col-12 col-md-8">
        <h1 class="text-h2 zen-ink-text">Resonance Lab</h1>
        <p class="text-h6 font-mono">Analog Synthesis & Street Sampling</p>
        
        <audio-visualizer class="q-mb-lg" />
        
        <div class="row q-col-gutter-sm">
          <div class="col-4" v-for="n in 3" :key="n">
            <q-btn 
              square 
              outline 
              class="full-width q-py-xl" 
              color="black" 
              :label="'SAMPLER ' + n"
              @click="triggerSample(n)"
            />
          </div>
        </div>
      </div>
      
      <div class="col-12 col-md-4">
        <div class="q-pa-md border-black">
          <div class="text-overline">Moog Control</div>
          <q-slider v-model="frequency" :min="100" :max="1000" color="black" />
          <q-btn unelevated color="black" label="Trigger Synth" class="full-width q-mt-md" />
        </div>
      </div>
    </div>
  </q-page>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
import AudioVisualizer from 'components/AudioVisualizer.vue';

export default defineComponent({
  name: 'AudioLab',
  components: { AudioVisualizer },
  setup() {
    const frequency = ref(440);
    const triggerSample = (id: number) => console.log(`Triggering Pad ${id}`);
    return { frequency, triggerSample };
  }
});
</script>

<style scoped>
.border-black { border: 4px solid #1a1a1a; padding: 20px; }
</style>
