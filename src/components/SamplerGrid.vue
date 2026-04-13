<script lang="ts">
import { defineComponent } from 'vue';
import { useSampler } from 'core/composables/useSampler';

export default defineComponent({
  name: 'SamplerGrid',
  setup() {
    const { triggerPad } = useSampler();
    return { triggerPad };
  }
});
</script>

<template>
  <div class="sampler-grid">
    <div class="row q-col-gutter-sm">
      <div v-for="i in 16" :key="i" class="col-3">
        <q-btn 
          square 
          unelevated 
          class="full-width pad-ink font-mono" 
          :label="i.toString().padStart(2, '0')"
          @mousedown="triggerPad(i)"
          @touchstart.prevent="triggerPad(i)"
        />
      </div>
    </div>
  </div>
</template>

<style scoped>
.sampler-grid {
  max-width: 500px;
  margin: auto;
  border: 8px solid #1a1a1a;
  padding: 10px;
  background: #f5f2ed;
}
.pad-ink {
  height: 80px;
  background: white;
  border: 2px solid #1a1a1a;
  transition: all 0.1s;
}
.pad-ink:active {
  background: #3d5afe;
  color: white;
  transform: scale(0.95);
}
</style>
