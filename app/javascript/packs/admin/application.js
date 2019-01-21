import "../../src/application.scss"
import "semantic-ui-css/semantic.css";

console.log('Hello World from Webpacker')

import Vue from 'vue/dist/vue.esm';
import adminRouter from './routes.js';
import router from '../routes.js';
import "jquery/dist/jquery"
import "popper.js"
import "bootstrap/dist/js/bootstrap";
import "@coreui/coreui/dist/js/coreui";

import Notifications from "vue-notification";
Vue.use(Notifications);

import Gravatar from 'vue-gravatar';
Vue.component('v-gravatar', Gravatar);

import Header from "../components/shared/_header";
Vue.component("v-header", Header);

import CurrentUser from "../components/shared/_current_user";
Vue.component("v-current-user", CurrentUser);

import Sidebar from "../components/shared/_sidebar";
Vue.component("v-sidebar", Sidebar);

import Layout from "../components/shared/Layout";
Vue.component("v-layout", Layout);

import UserFilters from "../components/views/users/user_filters";
Vue.component("v-user-filters", UserFilters);

import UserShowHide from "../components/views/users/users_show_hide";
Vue.component("v-user-show-hide", UserShowHide);

// import ModifyUsers from "../components/views/users/modify_users";
// Vue.component("v-modify-users", ModifyUsers);

import App from "../App";
import Login from "./Login";

import {Vuetable, VuetablePagination, VuetablePaginationDropDown, VuetablePaginationInfo, VuetableFieldCheckbox} from "vuetable-2";
Vue.component("vuetable", Vuetable);
Vue.component("vuetable-pagination", VuetablePagination);
Vue.component("vuetable-pagination-dropdown", VuetablePaginationDropDown);
Vue.component("vuetable-pagination-info", VuetablePaginationInfo);
Vue.component('vuetable-field-checkbox', VuetableFieldCheckbox);

document.addEventListener('DOMContentLoaded', () => {
  if(document.getElementById("app")){
    const node = document.getElementById('app');
    const current_user = JSON.parse(node.getAttribute('current_user'));
    const api_url = node.getAttribute('api_url');

    const app = new Vue({
      el: '#app',
      router,
      template: '<App />',
      data: {
        user: current_user,
        api_url: api_url
      },
      components: { App }
    }).$mount('#app');
  }

  if(document.getElementById("login")){
    const login = new Vue({
      el: '#login',
      adminRouter,
      template: '<Login />',
      components: { Login }
    }).$mount('#login');
  }
});
