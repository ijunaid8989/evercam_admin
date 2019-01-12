<template>
  <section>
  <vue-table class="box"
    path="/init_users"
    id="users">
  </vue-table>
  </section>
</template>

<script>
import VueTable from '../../../components/enso/vuedatatable/VueTable.vue';
export default {
  components: { VueTable }
};
</script>