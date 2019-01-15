<template>
 <div id="table-wrapper" class="">
  <img v-if="loading" src="/images/loading.gif" id="api-wait">
  <div class="handle">
    <vuetable ref="vuetable"
      api-url="/v1/users"
      :fields="fields"
      pagination-path=""
      data-path="data"
      :per-page="perPage"
      :sort-order="sortOrder"
      :show-sort-icons="true"
      :css="css.table"
      @vuetable:pagination-data="onPaginationData"
      @vuetable:initialized="onInitialized"
      @vuetable:loading="showLoader"
      @vuetable:loaded="hideLoader"
    />
    </div>
    <div style="margin-top:10px;">
      <component :is="paginationComponent" ref="pagination"
        @vuetable-pagination:change-page="onChangePage"
      ></component>
      <div class="field perPage-margin">
        <label>View records</label>
        <select class="ui simple dropdown" v-model="perPage">
          <option :value="50">50</option>
          <option :value="100">100</option>
          <option :value="500">500</option>
          <option :value="1000">1000</option>
        </select>
      </div>
    </div>
  </div>
</template>

<style scoped>
  .perPage-margin {
    margin-top: 5px;
  }
  .handle {
    overflow-x: scroll;
  }
  .custom-paging {
    margin-top: 3px;
  } 
  #table-wrapper {
    margin: 10px;
  }
</style>

<script>
import FieldsDef from "./FieldsDef.js";
import CssConfig from "./VuetableBootstrap4Config.js";

export default {
  data: function() {
    return {
      paginationComponent: "vuetable-pagination",
      loading: true,
      perPage: 60,
      sortOrder: [
        {
          field: 'name',
          direction: 'desc',
        }
      ],
      css: CssConfig,
      fields: FieldsDef
    }
  },
  watch: {
    perPage(newVal, oldVal) {
      this.$nextTick(() => {
        this.$refs.vuetable.refresh();
      });
    },

    paginationComponent(newVal, oldVal) {
      this.$nextTick(() => {
        this.$refs.pagination.setPaginationData(
          this.$refs.vuetable.tablePagination
        );
      });
    }
  },

  methods: {
    onPaginationData(tablePagination) {
      this.$refs.pagination.setPaginationData(tablePagination);
    },

    onChangePage(page) {
      this.$refs.vuetable.changePage(page);
    },

    onInitialized(fields) {
      this.vuetableFields = fields.filter(field => field.togglable);
    },

    showLoader() {
      console.log("i am here")
      this.loading = true;
    },

    hideLoader() {
      console.log("i am hideing")
      this.loading = false;
    }
  }
}
</script>