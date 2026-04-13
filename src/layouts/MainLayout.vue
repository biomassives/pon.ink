<template>
  <q-layout view="hHh lpR fFf">

    <q-header class="layout-header bg-black">
      <q-toolbar class="q-px-lg toolbar-ink">
        <router-link to="/" class="logo-link">
          <span class="logo-text font-mono">
            pon<span class="logo-dot">.</span>ink
          </span>
        </router-link>

        <q-space />

        <RoleSelector />
      </q-toolbar>
    </q-header>

    <q-page-container>
      <router-view />
    </q-page-container>

  </q-layout>
</template>

<script setup lang="ts">
import RoleSelector from 'components/RoleSelector.vue';
</script>

<style scoped>
.layout-header {
  border-bottom: 1px solid #141414;
}
.toolbar-ink {
  height: 54px;
  min-height: 54px;
}
.logo-link {
  text-decoration: none;
}
.logo-text {
  font-size: 1.05rem;
  font-weight: 800;
  letter-spacing: -2px;
  color: #e8e8e8;
  transition: color 0.2s;
}
.logo-text:hover {
  color: #ffffff;
}
.logo-dot {
  color: #3d5afe;
}
</style>
