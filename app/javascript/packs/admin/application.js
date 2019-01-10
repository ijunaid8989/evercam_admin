import "../../src/application.scss"

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

// configure Datatables with Bulma

import axios from 'axios';
import "./errorHandler";
import Toastr from '../components/enso/vuedatatable/toastr';

import fontawesome from '@fortawesome/fontawesome';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';

import { faUsers, faSearch, faSync, faAngleDown, faInfoCircle, faCheck, faTimes, faSignOutAlt }
    from '@fortawesome/fontawesome-free-solid/shakable.es';
fontawesome.library.add(faSearch, faSync, faAngleDown, faInfoCircle, faUsers, faCheck, faTimes, faSignOutAlt);

Vue.component('fa', FontAwesomeIcon);

Vue.use(Toastr, {
    position: 'right',
    duration: 3000,
    closeButton: true,
});

window.axios = axios;

// configure Datatables with Bulma

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
      components: { App },
      methods: {
          clicked({ column, row }) {
              this.$toastr.info(`You just clicked "${row[column.name]}" on column "${column.name}"`, 'Click Event');
          },
      }
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
