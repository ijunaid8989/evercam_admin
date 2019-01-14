<template>
 <div id="table-wrapper" class="ui container">
  <vuetable ref="vuetable"
    api-url="https://vuetable.ratiw.net/api/users"
    :fields="fields"
    :per-page="5"
    :sort-order="sortOrder"
  >
    </vuetable>
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
  }
}
</script>