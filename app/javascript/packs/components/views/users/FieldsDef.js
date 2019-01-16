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
    width: '90px',
    togglable: true
  },
  {
    name: 'username',
    title: 'Username',
    sortField: 'username',
    width: '95px',
    togglable: true
  },
  {
    name: 'name',
    title: 'Name',
    sortField: 'name',
    width: '95px',
    togglable: true
  },
  {
    name: 'email',
    title: 'Eamil',
    sortField: 'email',
    width: '150px',
    togglable: true
  },
  {
    name: 'api_id',
    title: 'API ID',
    sortField: 'api_id',
    width: '70px',
    togglable: true,
    visible: false
  },
  {
    name: 'api_key',
    title: 'API Key',
    sortField: 'api_key',
    width: '215px',
    togglable: true,
    visible: false
  },
  {
    name: 'cameras_owned',
    title: 'Cameras Owned',
    sortField: 'cameras_owned',
    width: '120px',
    togglable: true
  },
  {
    name: 'camera_shares',
    title: 'Cameras Shared',
    sortField: 'camera_shares',
    width: '120px',
    togglable: true
  },
  {
    name: 'total_cameras',
    title: 'Total Cameras',
    sortField: 'total_cameras',
    width: '120px',
    togglable: true
  },
  {
    name: 'snapmail_count',
    title: 'Snapmail Count',
    sortField: 'snapmail_count',
    width: '100px',
    togglable: true
  },
  {
    name: 'country',
    title: 'Country',
    sortField: 'country',
    width: '110px',
    togglable: true
  },
  {
    name: 'created_at',
    title: 'Registered',
    sortField: 'created_at',
    width: '170px',
    togglable: true
  },
  {
    name: 'last_login_at',
    title: 'Last Login At',
    sortField: 'last_login_at',
    width: '170px',
    togglable: true
  },
  {
    name: 'required_licence',
    title: 'Required Licence',
    sortField: 'required_licence',
    width: '120px',
    togglable: true
  },
  {
    name: 'valid_licence',
    title: 'Licence Valid',
    sortField: 'valid_licence',
    width: '120px',
    togglable: true
  },
  {
    name: 'def',
    title: 'Deficient Licence',
    sortField: 'def',
    width: '120px',
    togglable: true
  },
  {
    name: 'referral_url',
    title: 'Referral URL',
    sortField: 'referral_url',
    width: '120px',
    togglable: true
  }
]