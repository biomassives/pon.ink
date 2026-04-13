#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(make_path);
use File::Basename;

my %ui_map = (
    # 1. THE STYLING ENGINE (Zen-Ink & Space Invaders)
    'src/css/quasar.variables.scss' => <<'EOF',
// Quasar SCZ Variables
// Focus: High Contrast, Organic Textures
$primary   : #1a1a1a; // Ink Black
$secondary : #3d5afe; // Electric Blue (Tech/Active)
$accent    : #ff3d00; // Warning/Alert (Soil/Water)

$dark      : #1d1d1d;
$positive  : #21ba45;
$negative  : #c10015;
$info      : #31ccec;
$warning   : #f2c037;

// Custom Worldbridger Colors
$bone-white: #f5f2ed;
EOF

    'src/css/app.scss' => <<'EOF',
// Global Styles
@import url('https://fonts.googleapis.com/css2?family=VT323&family=Zeyada&display=swap');

.zen-ink-text {
  font-family: 'Zeyada', cursive;
  line-height: 1.2;
}

.font-mono {
  font-family: 'VT323', monospace;
  text-transform: uppercase;
  letter-spacing: 1px;
}

body {
  background-color: #f5f2ed;
  color: #1a1a1a;
  -webkit-font-smoothing: antialiased;
}

.glass-panel {
  background: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(0, 0, 0, 0.1);
  border-radius: 8px;
}
EOF

    # 2. BOOT LOGIC (The Interoperable CMS Bridge)
    'src/boot/cms-bridge.ts' => <<'EOF',
import { boot } from 'quasar/wrappers';
// This boot file registers your 'Interoperable CMS' components globally
// so you can use them in any page without manual imports.

export default boot(({ app }) => {
  // Example: app.component('AdminTable', () => import('core/components/AdminTable.vue'))
  console.log("PON.INK: CMS Bridge Initialized");
});
EOF

    # 3. NAIROBI LANDING (The Resonance Page)
    'src/pages/Nairobi.vue' => <<'EOF',
<template>
  <q-page class="q-pa-xl">
    <div class="row q-col-gutter-xl">
      <div class="col-12 col-md-8">
        <h1 class="text-h2 zen-ink-text">Pain in the Ghetto</h1>
        <p class="text-h6 font-mono text-grey-7">Fana Ka x OK Kulcha Studio Collaborative</p>
        
        <div class="q-mt-xl glass-panel q-pa-lg">
          <div class="text-overline">Active Airdrop Series</div>
          <h3 class="text-h4">Resonance Testnet v1.0</h3>
          <p>Supporting artists with digital credit and technical capacity building.</p>
          <q-btn unelevated color="black" label="Claim $BARS (Testnet)" class="q-px-xl" />
        </div>
      </div>
      
      <div class="col-12 col-md-4">
        <div class="q-pa-md bg-white border-black" style="border: 4px solid black">
          <div class="text-h6 font-mono">Status: Live</div>
          <q-separator class="q-my-sm" />
          <div class="text-caption">Nairobi Node: Active</div>
          <div class="text-caption">M-Pesa Bridge: Connected</div>
        </div>
      </div>
    </div>
  </q-page>
</template>

<style scoped>
.border-black { border: 4px solid #1a1a1a; }
</style>
EOF
);

print "--- Expanding Baseline UI Files ---\n";

foreach my $file_path (keys %ui_map) {
    my $dir = dirname($file_path);
    make_path($dir) unless -d $dir;
    
    open(my $fh, '>', $file_path) or die "Could not open $file_path: $!";
    print $fh $ui_map{$file_path};
    close($fh);
    
    print "Updated: $file_path\n";
}

print "--- Baseline Ready. Check pages/Nairobi.vue to see the artist hub. ---\n";
