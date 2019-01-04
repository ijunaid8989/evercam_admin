<template>
  <ul class="nav navbar-nav ml-auto">
    <li class="nav-item dropdown">
      <a class="nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
        <v-gravatar v-bind:email="this.$root.user.email" class="img-avatar" :size="40" /> <div class="current-user-fullname">{{ this.$root.user.firstname }} {{ this.$root.user.lastname }}</div>
      </a>
      <div class="dropdown-menu dropdown-menu-right">
        <a class="dropdown-item" href="/users/sign_out">
          <i class="fa fa-lock"></i> Logout
        </a>
      </div>
    </li>
  </ul>
</template>
