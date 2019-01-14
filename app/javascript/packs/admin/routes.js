import Vue from "vue/dist/vue.esm";
import VueRouter from "vue-router";
import VueResource from "vue-resource";

Vue.use(VueRouter);
Vue.use(VueResource);

import Login from "./Login"

const adminRouter = new VueRouter({
  mode: 'history',
  routes: [
    { path: "/users/sign_in", component: Login, name: "login", meta: { title: "Login"}}
  ]
});

adminRouter.beforeEach((to, from, next) => {
  document.title = to.meta.title
  next()
});

export default adminRouter;