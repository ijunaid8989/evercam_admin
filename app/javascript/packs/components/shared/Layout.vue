<template>
  <div id="app">
    <v-header />
    <div class="app-body">
      <v-sidebar />
      <div class="main">
        <slot />
      </div>
    </div>
  </div>
</template>
