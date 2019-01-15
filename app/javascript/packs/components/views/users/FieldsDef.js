import moment from "moment"
import accounting from "accounting"

export default [
  {
    name: 'vuetable-field-checkbox',
    title: "checkbox",
    width: "2%"
  },
  {
    name: 'payment_method', 
    title: "Type",
    sortField: 'payment_method',
    width: '90px'
  },
  {
    name: 'username',
    title: 'Username',
    sortField: 'username',
    width: '95px'
  },
  {
    name: 'name',
    title: 'Name',
    sortField: 'name',
    width: '95px'
  },
  {
    name: 'email',
    title: 'Eamil',
    sortField: 'email',
    width: '150px'
  },
  {
    name: 'api_id',
    title: 'API ID',
    sortField: 'api_id',
    width: '70px'
  },
  {
    name: 'api_key',
    title: 'API Key',
    sortField: 'api_key',
    width: '215px'
  },
  {
    name: 'cameras_owned',
    title: 'Cameras Owned',
    sortField: 'cameras_owned',
    width: '120px'
  },
  {
    name: 'camera_shares',
    title: 'Cameras Shared',
    sortField: 'camera_shares',
    width: '120px'
  },
  {
    name: 'total_cameras',
    title: 'Total Cameras',
    sortField: 'total_cameras',
    width: '120px'
  },
  {
    name: 'snapmail_count',
    title: 'Snapmail Count',
    sortField: 'snapmail_count',
    width: '100px'
  },
  {
    name: 'country',
    title: 'Country',
    sortField: 'country',
    width: '110px'
  },
  {
    name: 'created_at',
    title: 'Registered',
    sortField: 'created_at',
    width: '170px'
  },
  {
    name: 'last_login_at',
    title: 'Last Login At',
    sortField: 'last_login_at',
    width: '170px'
  },
  {
    name: 'required_licence',
    title: 'Required Licence',
    sortField: 'required_licence',
    width: '120px'
  },
  {
    name: 'valid_licence',
    title: 'Licence Valid',
    sortField: 'valid_licence',
    width: '120px'
  },
  {
    name: 'def',
    title: 'Deficient Licence',
    sortField: 'def',
    width: '120px'
  },
  {
    name: 'referral_url',
    title: 'Referral URL',
    sortField: 'referral_url',
    width: '120px'
  }
]