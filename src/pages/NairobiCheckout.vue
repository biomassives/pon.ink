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
