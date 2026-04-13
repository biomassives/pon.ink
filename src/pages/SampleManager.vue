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
