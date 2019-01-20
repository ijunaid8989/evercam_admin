import moment from "moment"
import accounting from "accounting"

export default [
  {
    name: "checkbox-slot",
    titleClass: "user-checkbox"
  },
  {
    name: 'payment_method', 
    title: "Type",
    sortField: 'payment_method',
    togglable: true,
    formatter: (value) => {
      return paymentMethod(value)
    },
  },
  {
    name: 'username',
    title: 'Username',
    sortField: 'username',
    togglable: true,
    visible: false
  },
  {
    name: 'name_link',
    title: 'Name',
    sortField: 'name',
    togglable: true
  },
  {
    name: 'email',
    title: 'Eamil',
    sortField: 'email',
    togglable: true
  },
  {
    name: 'api_id',
    title: 'API ID',
    sortField: 'api_id',
    togglable: true,
    visible: false
  },
  {
    name: 'api_key',
    title: 'API Key',
    sortField: 'api_key',
    togglable: true,
    visible: false
  },
  {
    name: 'cameras_owned',
    title: 'Cameras Owned',
    sortField: 'cameras_owned',
    togglable: true
  },
  {
    name: 'camera_shares',
    title: 'Cameras Shared',
    sortField: 'camera_shares',
    togglable: true
  },
  {
    name: 'total_cameras',
    title: 'Total Cameras',
    sortField: 'total_cameras',
    togglable: true
  },
  {
    name: 'snapmail_count',
    title: 'Snapmail Count',
    sortField: 'snapmail_count',
    togglable: true
  },
  {
    name: 'country',
    title: 'Country',
    sortField: 'country',
    togglable: true
  },
  {
    name: 'created_at',
    title: 'Registered',
    sortField: 'created_at',
    togglable: true
  },
  {
    name: 'last_login_at',
    title: 'Last Login At',
    sortField: 'last_login_at',
    togglable: true
  },
  {
    name: 'required_licence',
    title: 'Required Licence',
    sortField: 'required_licence',
    togglable: true
  },
  {
    name: 'valid_licence',
    title: 'Licence Valid',
    sortField: 'valid_licence',
    togglable: true
  },
  {
    name: 'def',
    title: 'Deficient Licence',
    sortField: 'def',
    togglable: true
  },
  {
    name: 'referral_url',
    title: 'Referral URL',
    sortField: 'referral_url',
    togglable: true
  }
]

var paymentMethod;

paymentMethod = function(name) {
  switch (name) {
    case 0:
      return "Stripe";
    case 1:
      return "Custom";
    case 2:
      return "Construction";
    case 3:
      return "Gardai";
    case 4:
      return "Smart Cities";
    default:
      return "Unknown";
  }
};