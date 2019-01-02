<template>
  <div>
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
      <ul class="nav navbar-nav ml-auto">
        <li class="nav-item dropdown">
          <a class="nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
            <!-- <img class="img-avatar" src="/images/avatar.png"> -->
            <div><v-gravatar email="junaid@evercam.io" class="img-avatar" :size="40" /></div>
          </a>
          <div class="dropdown-menu dropdown-menu-right">
            <a class="dropdown-item" href="#">
              <i class="fa fa-lock"></i> Logout</a>
          </div>
        </li>
      </ul>
    </header>
    <div class="app-body">
      <div class="sidebar">
        <nav class="sidebar-nav">
          <ul class="nav">
            <li class="nav-item">
              <router-link class="nav-link" v-bind:to="'/'">
                <i class="nav-icon icon-drop fa fa-users"></i>
                Users
              </router-link>
            </li>
          </ul>
        </nav>
        <button class="sidebar-minimizer brand-minimizer" type="button"></button>
      </div>
      <main id="app" class="main">
        <div id="remote_data">
          <router-view></router-view>
        </div>
      </main>
    </div>
  </div>
</template>


<script>
export default {
  name: "app"
}
</script>