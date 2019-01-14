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

import App from "../App";
import Login from "./Login";

import {Vuetable, VuetablePagination, VuetablePaginationDropDown, VuetablePaginationInfo} from "vuetable-2";
Vue.component("vuetable", Vuetable);
Vue.component("vuetable-pagination", VuetablePagination);
Vue.component("vuetable-pagination-dropdown", VuetablePaginationDropDown);
Vue.component("vuetable-pagination-info", VuetablePaginationInfo);

document.addEventListener('DOMContentLoaded', () => {
  if(document.getElementById("app")){
    const node = document.getElementById('app');
    const current_user = JSON.parse(node.getAttribute('current_user'));

    const app = new Vue({
      el: '#app',
      router,
      template: '<App />',
      data: {
        user: current_user
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
