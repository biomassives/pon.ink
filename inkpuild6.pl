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
    print "Figure Engine Calibrated: $path\n";
}

my %figure_map = (
    # 1. THE DRUM & SYNTH DEFINITIONS (The "Figure" Logic)
    'core/composables/useFigureEngine.ts' => <<'EOF',
// FIGURE-STYLE ENGINE: Constrained Rhythm & Harmony
// Tributing Propellerhead: X/Y Pad Logic for 440Hz Harmonics & Boom Bap
import { ref } from 'vue';
import { useAudioEngine } from './useAudioEngine';

export const useFigureEngine = () => {
  const { audioCtx, masterGain } = useAudioEngine();

  // 1. HARMONIC SYNTH (440Hz Base)
  const playHarmonic = (ratio: number, volume: number) => {
    if (!audioCtx.value || !masterGain.value) return;
    const osc = audioCtx.value.createOscillator();
    const g = audioCtx.value.createGain();
    
    osc.type = 'triangle';
    osc.frequency.setValueAtTime(440 * ratio, audioCtx.value.currentTime);
    
    g.gain.setValueAtTime(volume, audioCtx.value.currentTime);
    g.gain.exponentialRampToValueAtTime(0.001, audioCtx.value.currentTime + 0.5);
    
    osc.connect(g).connect(masterGain.value);
    osc.start();
    osc.stop(audioCtx.value.currentTime + 0.5);
  };

  // 2. BOOM BAP KICK SYNTH (Procedural)
  const playBoomBapKick = () => {
    if (!audioCtx.value || !masterGain.value) return;
    const osc = audioCtx.value.createOscillator();
    const g = audioCtx.value.createGain();
    
    osc.frequency.setValueAtTime(150, audioCtx.value.currentTime);
    osc.frequency.exponentialRampToValueAtTime(0.01, audioCtx.value.currentTime + 0.5);
    
    g.gain.setValueAtTime(1, audioCtx.value.currentTime);
    g.gain.exponentialRampToValueAtTime(0.01, audioCtx.value.currentTime + 0.5);
    
    osc.connect(g).connect(masterGain.value);
    osc.start();
    osc.stop(audioCtx.value.currentTime + 0.5);
  };

  return { playHarmonic, playBoomBapKick };
};
EOF

    # 2. THE 16-PAD BANK (Congas, Timbales, Shakere, Vocals)
    'src/components/FigureSampler.vue' => <<'EOF',
<template>
  <div class="figure-sampler q-pa-md bg-ink text-bone">
    <div class="row q-col-gutter-sm">
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
    
    <div class="xy-pad q-mt-lg border-bone flex flex-center" @mousemove="handleXY">
      <div class="text-overline font-mono">XY: HARMONIC 440 RESONANCE</div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
import { useFigureEngine } from 'core/composables/useFigureEngine';

export default defineComponent({
  name: 'FigureSampler',
  setup() {
    const { playHarmonic, playBoomBapKick } = useFigureEngine();
    const pads = ref([
      { id: 1, label: 'KICK', type: 'synth' },
      { id: 2, label: 'HI-HAT', type: 'sample' },
      { id: 3, label: 'CONGA L', type: 'sample' },
      { id: 4, label: 'CONGA H', type: 'sample' },
      { id: 5, label: 'TIMBALE', type: 'sample' },
      { id: 6, label: 'SHAKERE', type: 'sample' },
      { id: 7, label: 'VOCAL 1', type: 'sample' },
      { id: 8, label: 'VOCAL 2', type: 'sample' },
      // ... up to 16
    ]);

    const hitPad = (pad: any) => {
      if (pad.label === 'KICK') playBoomBapKick();
      console.log(`Triggering ${pad.label}`);
    };

    const handleXY = (e: MouseEvent) => {
      const ratio = e.offsetX / 200 + 1;
      const vol = 1 - (e.offsetY / 200);
      playHarmonic(ratio, vol);
    };

    return { pads, hitPad, handleXY };
  }
});
</script>

<style scoped>
.pad-square { height: 70px; border: 1px solid #f5f2ed; }
.xy-pad { height: 200px; background: #222; cursor: crosshair; }
.border-bone { border: 2px solid #f5f2ed; }
</style>
EOF
);

print "--- Designing the 16-Bar Figure Tribute ---\n";
foreach my $file_path (keys %figure_map) {
    patch_file($file_path, $figure_map{$file_path});
}
print "--- Figure Engine Stubs Placed. Signal Chain Open. ---\n";
