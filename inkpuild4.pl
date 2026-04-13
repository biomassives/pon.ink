#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(make_path);
use File::Basename;

sub patch_file {
    my ($path, $content) = @_;
    my $dir = dirname($path);
    make_path($dir) unless -d $dir;
    open(my $fh, '>', $path) or die "Could not open $path: $!";
    print $fh $content;
    close($fh);
    print "Resonated: $path\n";
}

my %audio_map = (
    # 1. THE AUDIO ENGINE (The Moog/Sampler Interface)
    'core/composables/useAudioEngine.ts' => <<'EOF',
// WEB AUDIO ENGINE: Moog / Sampler / Recording
// Tonight's Logic: Initialize AudioContext and Oscillator/Buffer connections.
import { ref } from 'vue';

export const useAudioEngine = () => {
  const audioCtx = ref<AudioContext | null>(null);
  const masterGain = ref<GainNode | null>(null);

  const initEngine = () => {
    audioCtx.value = new (window.AudioContext || (window as any).webkitAudioContext)();
    masterGain.value = audioCtx.value.createGain();
    masterGain.value.connect(audioCtx.value.destination);
    console.log("Audio Engine Inked: [READY]");
  };

  // Stub for Moog-style Synth
  const playMoogNote = (freq: number) => {
    if (!audioCtx.value || !masterGain.value) return;
    const osc = audioCtx.value.createOscillator();
    osc.type = 'sawtooth'; // Classic Moog vibe
    osc.frequency.setValueAtTime(freq, audioCtx.value.currentTime);
    osc.connect(masterGain.value);
    osc.start();
    osc.stop(audioCtx.value.currentTime + 0.5);
  };

  return { initEngine, playMoogNote, audioCtx, masterGain };
};
EOF

    # 2. THE VISUALIZER COMPONENT (Quasar + Canvas)
    'src/components/AudioVisualizer.vue' => <<'EOF',
<template>
  <div class="visualizer-container border-ink">
    <canvas ref="vizCanvas" class="full-width" style="height: 200px;"></canvas>
    <div class="text-caption font-mono q-mt-xs">Signal Analysis: [ACTIVE]</div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from 'vue';

export default defineComponent({
  name: 'AudioVisualizer',
  setup() {
    const vizCanvas = ref<HTMLCanvasElement | null>(null);
    
    onMounted(() => {
      // TODO: Connect to useAudioEngine's AnalyserNode
      console.log("Visualizer Mounted: Ready for FFT Data");
    });

    return { vizCanvas };
  }
});
</script>

<style scoped>
.border-ink { border: 2px solid #1a1a1a; background: #f5f2ed; }
</style>
EOF

    # 3. THE EXPERIMENTAL PAGE (Moog & Sampler Hub)
    'src/pages/AudioLab.vue' => <<'EOF',
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
EOF
);

print "--- Inking the Audio Signal Chain ---\n";

foreach my $file_path (keys %audio_map) {
    patch_file($file_path, $audio_map{$file_path});
}

print "--- Audio Lab Stubs Ready. Import AudioLab into your routes.ts ---\n";
