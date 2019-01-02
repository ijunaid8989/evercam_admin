import "../../src/application.scss"

console.log('Hello World from Webpacker')

import Vue from 'vue/dist/vue.esm';
import router from '../routes.js';
import "jquery/dist/jquery"
import "popper.js"
import "bootstrap/dist/js/bootstrap";
import "@coreui/coreui/dist/js/coreui";

import Gravatar from 'vue-gravatar';
Vue.component('v-gravatar', Gravatar);

import Header from "../components/shared/Header";
Vue.component("v-header", Header);

import Sidebar from "../components/shared/Sidebar";
Vue.component("v-sidebar", Sidebar);

import Layout from "../components/shared/Layout";
Vue.component("v-layout", Layout);

import App from "../App";

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('hello'))
  const app = new Vue({
    el: '#app',
    router,
    template: '<App />',
    components: { App }
  }).$mount('#app')
  console.log(app)
})