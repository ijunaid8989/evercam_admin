<template>
  <header class="app-header navbar">
    <button class="navbar-toggler sidebar-toggler d-lg-none mr-auto" type="button" data-toggle="sidebar-show">
      <span class="navbar-toggler-icon"></span>
    </button>
    <a class="navbar-brand" href="#">
      <img class="navbar-brand-full" src="/images/evercam-logo-2.png" alt="Evercam Logo">
      <img class="navbar-brand-minimized" src="/images/Favicon-300.png" width="30" height="30" alt="Evercam Logo">
    </a>
    <button class="navbar-toggler sidebar-toggler d-md-down-none" type="button" data-toggle="sidebar-lg-show">
      <span class="navbar-toggler-icon"></span>
    </button>
    <v-current-user />
  </header>
</template>
