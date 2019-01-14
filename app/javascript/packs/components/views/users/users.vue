<template>
 <div id="table-wrapper" class="ui container">
  <vuetable ref="vuetable"
    api-url="https://vuetable.ratiw.net/api/users"
    :fields="fields"
    pagination-path=""
    :per-page="perPage"
    :sort-order="sortOrder"
    @vuetable:pagination-data="onPaginationData"
    @vuetable:initialized="onInitialized"
    @vuetable:loading="showLoader"
    @vuetable:loaded="hideLoader"
  >
    </vuetable>
      <div class="vuetable-pagination ui bottom segment grid">
        <vuetable-pagination-info ref="paginationInfo"
        ></vuetable-pagination-info>
        <component :is="paginationComponent" ref="pagination"
          @vuetable-pagination:change-page="onChangePage"
        ></component>
    </div>
  </div>
</template>

<style type="text/css" scoped>
  #table-wrapper {
    margin-top: 5px;
  }
  .orange {
    color: orange;
  }

  th.sortable {
    color: #ec971f;
  }

  span.icon.sort-icon {
    float: right;
  }

</style>

<script>
import moment from "moment";
export default {
  data: function() {
    return {
      paginationComponent: "vuetable-pagination",
      loading: "",
      perPage: 10,
      sortOrder: [
        {
          field: 'name',
          sortField: 'name',
          direction: 'asc',
        }
      ],
      fields: [
        { 
          name: 'name', 
          title: `<span class="icon orange"><i class="fa fa-user"></i></span> Full Name`,
          sortField: 'name',
          width: '20%'
        }, 
        {
          name: 'email',
          title: 'Email',
          sortField: 'email',
          width: '20%'
        },
        {
          name: 'birthdate',
          sortField: 'birthdate',
          width: '10%',
          formatter: (value) => moment(value, 'YYYY-MM-DD').format('D MMM YYYY')
        },
        {
          name: 'nickname',
          sortField: 'nickname',
          width: '12%',
          formatter: (value) => value.toUpperCase()
        },
        {
          name: 'gender',
          title: 'Gender',
          sortField: 'gender',
          width: '8%',
          formatter: (value) => {
            return value === 'F' ? 'Female' : 'Male'
          }
        },
      ]
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

    showSettingsModal() {
      this.$refs.settingsModal.show();
    },

    onCellClicked({ data, field, event }) {
      if (field.name !== this.fieldPrefix + "actions") {
        this.$refs.vuetable.toggleDetailRow(data.id);
      }
    },

    onActionClicked(action, data) {
      sweetAlert(action, data.name);
    },

    onRowHeaderEvent(type, payload) {
      console.log("onRowHeaderEvent:", type, payload);

      let handler = RowEventHandler;

      return typeof handler[type] === "function"
        ? handler[type](this, this.$refs.vuetable, payload)
        : console.log("Unhandled event: ", type, payload);
    },

    onScrollbarVisible(toggle) {
      this.scrollbarVisible = toggle;
    }
  }
}
</script>