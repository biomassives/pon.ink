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
