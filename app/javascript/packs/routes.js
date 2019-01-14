import Vue from "vue/dist/vue.esm";
import VueResource from "vue-resource";

Vue.use(VueRouter);
Vue.use(VueResource)

import Users from "./components/views/users/users";
import Page404 from "./components/views/Page404";

Vue.component("v-notfound", Page404);

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: "/", component: Users, name: "users", meta: { title: "Users"} },
    { path: "/users", redirect: '/'}
  ]
});

router.beforeEach((to, from, next) => {
  document.title = to.meta.title
  next()
});

export default router;
