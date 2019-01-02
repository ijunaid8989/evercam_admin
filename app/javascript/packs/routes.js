import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
import BootstrapVue from 'bootstrap-vue'
import VueResource from 'vue-resource'

Vue.use(VueRouter);
Vue.use(VueResource)
Vue.use(BootstrapVue);

import Users from "./components/users"

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: Users, name: 'users' },
    // { path: '/users', component: UserIndex, name: 'users_path' },
  ]
});

export default router;