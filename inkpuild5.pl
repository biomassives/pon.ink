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
    print "Sampler Module Inked: $path\n";
}

my %sampler_map = (
    # 1. THE SAMPLER ENGINE (Advanced Buffer Management)
    'core/composables/useSampler.ts' => <<'EOF',
// 16-BAR SAMPLER ENGINE
// Tonight: Logic for loading external URL samples into AudioBuffers.
import { ref } from 'vue';
import { useAudioEngine } from './useAudioEngine';

export const useSampler = () => {
  const { audioCtx, masterGain } = useAudioEngine();
  const samples = ref<Map<number, AudioBuffer>>(new Map());

  const loadSample = async (padIndex: number, url: string) => {
    if (!audioCtx.value) return;
    const response = await fetch(url);
    const arrayBuffer = await response.arrayBuffer();
    const audioBuffer = await audioCtx.value.decodeAudioData(arrayBuffer);
    samples.value.set(padIndex, audioBuffer);
  };

  const triggerPad = (padIndex: number) => {
    if (!audioCtx.value || !masterGain.value || !samples.value.has(padIndex)) return;
    const source = audioCtx.value.createBufferSource();
    source.buffer = samples.value.get(padIndex)!;
    source.connect(masterGain.value);
    source.start(0);
  };

  return { loadSample, triggerPad, samples };
};
EOF

    # 2. THE 16-PAD UI (Space Invaders / Zen-Ink Grid)
    'src/components/SamplerGrid.vue' => <<'EOF',
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
EOF

    # 3. SAMPLE BANK MANAGER (The NFT Product Page)
    'src/pages/SampleManager.vue' => <<'EOF',
<template>
  <q-page class="q-pa-xl">
    <h1 class="text-h2 zen-ink-text">Sample Banks</h1>
    <p class="text-h6 font-mono">Manage your NFT Sound Products</p>

    <div class="row q-col-gutter-xl">
      <div class="col-12 col-md-6">
        <q-card flat bordered class="bg-bone q-pa-md">
          <div class="text-h5 q-mb-md">Mint New Bank</div>
          <q-input filled v-model="bankName" label="Bank Name (e.g. Nairobi Streets Vol 1)" />
          <q-file filled v-model="files" label="Upload .wav Samples" multiple class="q-mt-md" />
          <q-btn color="black" label="Deploy to IPFS / Mint NFT" class="full-width q-mt-lg" />
        </q-card>
      </div>

      <div class="col-12 col-md-6">
        <div class="text-overline">Your Collected Banks</div>
        <q-list bordered separator class="bg-white">
          <q-item v-for="bank in 3" :key="bank" clickable>
            <q-item-section avatar><q-icon name="album" /></q-item-section>
            <q-item-section>
              <q-item-label>Bank #00{{bank}}</q-item-label>
              <q-item-label caption>Verified on Polygon / Solana</q-item-label>
            </q-item-section>
            <q-item-section side><q-btn flat icon="download" /></q-item-section>
          </q-item>
        </q-list>
      </div>
    </div>
  </q-page>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
export default defineComponent({
  name: 'SampleManager',
  setup() {
    return { bankName: ref(''), files: ref(null) };
  }
});
</script>
EOF
);

print "--- Initializing 16-Pad Sampler & Bank Manager ---\n";
foreach my $file_path (keys %sampler_map) {
    patch_file($file_path, $sampler_map{$file_path});
}
print "--- Sampler Stubs Ready. Ready for Stripe/NFT integration tonight. ---\n";
