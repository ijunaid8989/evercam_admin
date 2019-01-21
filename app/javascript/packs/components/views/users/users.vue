<template>
  <div>
    <div class="overflow-forms">
      <v-user-filters :selectedUsers="selectedUsers" />
    </div>
    <div>
      <v-user-show-hide :vuetable-fields="vuetableFields" />
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
          :append-params="moreParams"
          @vuetable:pagination-data="onPaginationData"
          @vuetable:initialized="onInitialized"
          @vuetable:loading="showLoader"
          @vuetable:loaded="hideLoader"
          :css="css.table"
        >
        <div slot="checkbox-slot" slot-scope="props">
          <input type="checkbox" @click="onCheckBoxClick($event, props.rowData)" />
        </div>
        </vuetable>
      </div>
      <div class="vuetable-pagination ui bottom segment grid">
        <div class="field perPage-margin">
          <label>Per Page:</label>
          <select class="ui simple dropdown" v-model="perPage">
            <option :value="60">60</option>
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

.overflow-forms {
  overflow: hidden;
}

#table-wrapper {
  margin-top: 3px;
}
</style>

<script>
import FieldsDef from "./FieldsDef.js";
import TableWrapper from "./TableWrapper.js";

export default {
  data: () => {
    return {
      selectedUsers: [],
      paginationComponent: "vuetable-pagination",
      loading: "",
      vuetableFields: false,
      perPage: 60,
      sortOrder: [
        {
          field: 'created_at',
          direction: 'desc',
        }
      ],
      css: TableWrapper,
      moreParams: {},
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

  mounted() {
    this.$events.$on('user-filter-set', eventData => this.onFilterSet(eventData))
    this.$events.$on('user-filter-reset', e => this.onFilterReset())
    this.$events.$on('user-modify-refresh', e => this.onUserModifyRefresh())
  },

  methods: {
    onFilterSet (filters) {
      this.moreParams = {
        "username": filters.username,
        "fullname": filters.fullname,
        "email": filters.email,
        "payment_method": filters.payment_method,
        "last_login_at_boolean": filters.last_login_at_boolean,
        "last_login_at_date": filters.last_login_at_date,
        "created_at_date": filters.created_at_date,
        "total_cameras": filters.total_cameras,
        "include_erc": filters.include_erc,
        "cameras_owned": filters.cameras_owned,
        "camera_shares": filters.camera_shares,
        "licREQ1": filters.licREQ1,
        "licREQ2": filters.licREQ2,
        "licVALID1": filters.licVALID1,
        "licVALID2": filters.licVALID2,
        "licDEF1": filters.licDEF1,
        "licDEF2": filters.licDEF2
      }
      this.$nextTick( () => this.$refs.vuetable.refresh())
    },

    onUserModifyRefresh () {
      this.selectedUsers = []
      this.$nextTick( () => this.$refs.vuetable.refresh())
    },

    onFilterReset () {
      this.moreParams = {}
      this.$nextTick( () => this.$refs.vuetable.refresh())
    },

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
    },

    onCheckBoxClick(event, data) {
      const userAttributes = {
        id: data.id,
        email: data.email,
        api_key: data.api_key,
        api_id: data.api_id
      }

      this.$nextTick(() => {
        if(event.target.checked) {
          this.selectedUsers.push(userAttributes);
        } else {
          this.selectedUsers = this.selectedUsers.filter(user => user.id !== data.id)
        }      
      })
    }
  }
}
</script>