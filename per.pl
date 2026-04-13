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
    print "Inked UI: $path\n";
}

my %missing_ui = (
    # 1. NAIROBI CHECKOUT (The M-Pesa Bridge)
    'src/pages/NairobiCheckout.vue' => <<'EOF',
<template>
  <q-page class="flex flex-center bg-bone">
    <q-card flat bordered class="q-pa-xl border-black" style="width: 100%; max-width: 450px">
      <div class="text-h4 zen-ink-text q-mb-md">M-Pesa Checkout</div>
      <p class="font-mono text-caption">KES to $BARS Conversion for Nairobi Studio</p>
      
      <q-input filled v-model="phone" label="Phone (+254...)" mask="### ### ####" class="q-mb-md" />
      <q-input filled v-model="amount" label="Amount (KES)" type="number" />
      
      <q-btn unelevated color="black" label="Send STK Push" class="full-width q-mt-xl q-py-lg" @click="handleMpesa" />
    </q-card>
  </q-page>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
export default defineComponent({
  name: 'NairobiCheckout',
  setup() {
    const phone = ref('');
    const amount = ref(100);
    const handleMpesa = () => console.log('Initiating Africa\'s Talking STK Push...');
    return { phone, amount, handleMpesa };
  }
});
</script>
EOF

    # 2. STRIPE CHECKOUT (The Global Bridge)
    'src/pages/StripeCheckout.vue' => <<'EOF',
<template>
  <q-page class="flex flex-center bg-bone">
    <q-card flat bordered class="q-pa-xl border-black" style="width: 100%; max-width: 450px">
      <div class="text-h4 zen-ink-text q-mb-md">Stripe Checkout</div>
      <p class="font-mono text-caption">USD Global Support / Consultancy Fee</p>
      
      <div id="stripe-element-mount" class="q-my-xl" style="min-height: 100px;">
        <div class="text-center text-grey-6 font-mono">[ STRIPE ELEMENTS PLACEHOLDER ]</div>
      </div>
      
      <q-btn unelevated color="black" label="Complete Payment" class="full-width q-py-lg" />
    </q-card>
  </q-page>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
export default defineComponent({ name: 'StripeCheckout' });
</script>
EOF

    # 3. AUDIO POWER OVERLAY (The "User Gesture" Fix)
    'src/components/AudioPowerOverlay.vue' => <<'EOF',
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
EOF
);

foreach my $path (keys %missing_ui) {
    patch_file($path, $missing_ui{$path});
}
