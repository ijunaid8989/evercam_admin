<template>
  <ul class="nav navbar-nav ml-auto">
    <li class="nav-item dropdown">
      <a class="nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
        <v-gravatar email="junaid@evercam.io" class="img-avatar" :size="40" />
      </a>
      <div class="dropdown-menu dropdown-menu-right">
        <a class="dropdown-item" href="/users/sign_out">
          <i class="fa fa-lock"></i>  {{ this.$root.user.email }}
        </a>
      </div>
    </li>
  </ul>
</template>
