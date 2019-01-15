<template>
  <div>
    <div class="overflow-forms">
      <v-user-filters />
    </div>
    <div id="table-wrapper" :class="['vuetable-wrapper ui basic segment', loading]">
      <div class="handle">
        <vuetable ref="vuetable"
          api-url="/v1/users"
          :fields="fields"
          pagination-path=""
          data-path="data"
          :per-page="perPage"
          :sort-order="sortOrder"
          @vuetable:pagination-data="onPaginationData"
          @vuetable:initialized="onInitialized"
          @vuetable:loading="showLoader"
          @vuetable:loaded="hideLoader"
        />
      </div>
      <div class="vuetable-pagination ui bottom segment grid">
        <div class="field perPage-margin">
          <label>Per Page:</label>
          <select class="ui simple dropdown" v-model="perPage">
            <option :value="50">50</option>
            <option :value="100">100</option>
            <option :value="500">500</option>
            <option :value="1000">1000</option>
          </select>
        </div>
        <vuetable-pagination-info ref="paginationInfo"
        ></vuetable-pagination-info>
        <component :is="paginationComponent" ref="pagination"
          @vuetable-pagination:change-page="onChangePage"
        ></component>
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
  .overflow-forms {
    overflow: hidden;
  }
  #table-wrapper {
    margin-top: 3px;
  }
</style>

<script>
import FieldsDef from "./FieldsDef.js";

export default {
  data: function() {
    return {
      paginationComponent: "vuetable-pagination",
      loading: "",
      perPage: 60,
      sortOrder: [
        {
          field: 'name',
          direction: 'desc',
        }
      ],
      fields: FieldsDef
    }
  },
  watch: {
    perPage(newVal, oldVal) {
      console.log("i am called");
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
      this.$refs.paginationInfo.setPaginationData(tablePagination);
      this.$refs.pagination.setPaginationData(tablePagination);
    },

    onChangePage(page) {
      this.$refs.vuetable.changePage(page);
    },

    onInitialized(fields) {
      this.vuetableFields = fields.filter(field => field.togglable);
    },

    showLoader() {
      this.loading = "loading";
    },

    hideLoader() {
      this.loading = "";
    }
  }
}
</script>