<template>
  <div class="form-main">
    <div class="main-contain">
      <div class="filter-name">
        Search
      </div>
      <div class="input-divs">
        <input type="text" v-model="username" @keyup="userFilterGlobal" class="first-ins" placeholder="Username" id="username" autocomplete="off">
        <input type="text" v-model="fullname" @keyup="userFilterGlobal" class="first-ins" placeholder="Fullname" id="fullname" autocomplete="off">
        <input type="text" v-model="email" @keyup="userFilterGlobal" class="first-ins" placeholder="email" id="email" autocomplete="off">
      </div>
    </div>
    <div class="main-contain licence-space">
      <div class="filter-name">
        Licence Required
      </div>
      <div class="input-divs-s">
        <input type="text" v-on:keypress="isNumber($event)" v-model="licREQ1" @keyup="userFilterGlobal" class="small-ins" placeholder="from" id="licREQ1" autocomplete="off">
        <input type="text" v-on:keypress="isNumber($event)" v-model="licREQ2" @keyup="userFilterGlobal" class="small-ins" placeholder="to" id="licREQ2" autocomplete="off">
      </div>
      <div class="filter-second">
        Licence Valid
      </div>
      <div class="input-divs-s">
        <input type="text" v-on:keypress="isNumber($event)" v-model="licVALID1" @keyup="userFilterGlobal" class="small-ins" placeholder="from" id="licVALID1" autocomplete="off">
        <input type="text" v-on:keypress="isNumber($event)" v-model="licVALID2" @keyup="userFilterGlobal" class="small-ins" placeholder="to" id="licVALID2" autocomplete="off">
      </div>
      <div class="filter-second def-ins">
        Licence Deficient
      </div>
      <div class="input-divs-s">
        <input type="text" v-model="licDEF1" @keyup="userFilterGlobal" v-on:keypress="isNumber($event)" class="small-ins" placeholder="from" id="licDEF1" autocomplete="off">
        <input type="text" v-model="licDEF2" @keyup="userFilterGlobal" v-on:keypress="isNumber($event)" class="small-ins" placeholder="to" id="licDEF2" autocomplete="off">
      </div>
    </div>
    <div class="main-contain licence-space">
      <div class="filter-name">
        Total Cameras
      </div>
      <div class="input-divs-s">
        <input type="text" v-on:keypress="isNumber($event)" v-model="total_cameras" @keyup="userFilterGlobal" class="medium-ins" placeholder="numeric" id="total_cameras" autocomplete="off">
      </div>
      <div class="filter-second">
        Type
      </div>
      <div class="payment-type-divs">
        <select id="user_payment_type" v-model="payment_method" @change="userFilterGlobal" class="first-ins" autocomplete="off">
          <option value="">All</option>
          <option value="0">Stripe</option>
          <option value="1">Custom</option>
          <option value="2">Construction</option>
          <option value="3">Gardai</option>
          <option value="4">Smart Cities</option>
          <option value="5">Unknown</option>
        </select>
      </div>
    </div>
    <div class="main-contain licence-space">
      <div class="filter-name" style="width: 148px;margin-top: 4px;">
        Created Date Older than
      </div>
      <div class="input-divs-s" style="width: 68px;margin-top: 4px;">
        <input type="text" v-model="created_at_date" @keyup="userFilterGlobal" v-on:keypress="isNumber($event)" class="medium-ins" id="created_at_date" autocomplete="off" style="width: 35px;" placeholder="MTs">
      </div>
      <div class="filter-name" style="margin-left: -21px;width: 175px;margin-top: 4px;">
        Last Login Date Older than
      </div>
      <div class="input-divs-s" style="margin-top: 5px;width: 52px;">
        <input type="text" v-model="last_login_at_date" @keyup="userFilterGlobal" class="medium-ins" id="last_login_at_date" autocomplete="off" style="width: 35px;" placeholder="MTs" v-on:keypress="isNumber($event)">
      </div>
      <div class="filter-second" style="margin-top: 3px;">
        Last Login
      </div>
      <div class="payment-type-divs" style="margin-left: -25px;">
        <select id="last_login_at_boolean" v-model="last_login_at_boolean" @change="userFilterGlobal" class="first-ins" autocomplete="off" style="width: 135px; margin-top: 4px;">
          <option value="true">True</option>
          <option value="false">False</option>
          <option value="whatever" selected="selected">Whatever</option>
        </select>
      </div>
    </div>
    <div class="main-contain licence-space">
      <div class="filter-name" style="margin-left: 32px;">
        Cameras Owned <
      </div>
      <div class="input-divs-s">
        <input type="text" v-on:keypress="isNumber($event)" v-model="cameras_owned" @keyup="userFilterGlobal" class="medium-ins" placeholder="numeric" id="owned_cameras" autocomplete="off" style="width: 37px;">
      </div>
      <div class="filter-name" style="margin-left: -59px;">
        Cameras Shared <
      </div>
      <div class="input-divs-s">
        <input type="text" v-on:keypress="isNumber($event)" v-model="camera_shares" @keyup="userFilterGlobal" class="medium-ins" placeholder="numeric" id="shared_cameras" autocomplete="off" style="width: 37px;">
      </div>
      <div class="filter-second" style="margin-right: 1px; margin-top: 3px;width: 152px;margin-left: -55px;">
        Remembrance Camera
      </div>
      <div class="payment-type-divs" style="margin-left: -25px;">
        <select id="include_erc" v-model="include_erc" @change="userFilterGlobal" class="first-ins" autocomplete="off" style="width: 135px; margin-top: 4px;">
          <option value="true">True</option>
          <option value="false">False</option>
          <option value="whatever" selected="selected">Whatever</option>
        </select>
      </div>
    </div>
    <div class="main-contain licence-space">
      <div class="filter-second" style="margin-left: 44px;text-align: right;">
        Actions
      </div>
      <div class="btn-div" style="width: 235px;margin-left: 10px;">
        <button v-on:click="onModifyClick" class="clear-btn-f" id="btn-modify">Modify</button>
        <modal :usersModify="usersModify" />
        <button class="clear-btn-f" id="btn-delete" @click="deletUsers">Delete</button>
        <button type="button" @click="resetUserFilter" class="clear-btn-f" id="filterClear">Clear Filter</button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.form-main {
  width: 700px;
  overflow: hidden;
  height: auto;
  float: left;
  text-align: center;
  margin-top: 2px;
}

.form-main {
  width: 700px;
  overflow: hidden;
  height: auto;
  float: left;
  text-align: center;
}

.main-contain {
  width: 750px;
  height: auto;
  overflow: hidden;
}

.filter-name {
  width: 115px;
  padding: 9px 2px;
  height: auto;
  float: left;
  text-align: right;
  font-size: 13px;
}

.filter-second {
  width: 87px;
  padding: 9px 2px;
  height: auto;
  float: left;
  text-align: left;
  font-size: 13px;
}

.input-divs {
  width: 600px;
  float: left;
  height: auto;
  overflow: hidden;
  padding: 3px 1px;
}

.input-divs-s {
  width: 105px;
  float: left;
  height: auto;
  overflow: hidden;
  padding: 3px 1px;
}

.payment-type-divs {
  width: 175px;
  float: left;
  height: auto;
  overflow: hidden;
  padding: 3px 1px;
}

.btn-div {
  width: 146px;
  float: left;
  height: auto;
  overflow: hidden;
  padding: 3px 1px;
}

.first-ins {
  background-color: #EEEEEE;
  width: 164px;
  padding: 7px;
  margin-left: 5px;
  border: none;
  float: left;
}

.small-ins {
  width: 45px;
  padding: 7px;
  border: none;
  margin-left: 5px;
  float: left;
  background-color: #EEEEEE;
}

.medium-ins {
  width: 95px;
  padding: 7px;
  border: none;
  margin-left: 5px;
  float: left;
  background-color: #EEEEEE;
}

.btn-margin-clear {
  margin-left: 5px;
}

.def-ins {
  width: 111px;
}

.licence-space {
  width: 900px;
}

.clear-btn-f {
  padding: 7px;
  display: inline-block;
  background-color: #428bca;
  float: left;
  color: white;
  border: none;
  margin-left: 10px;
}
</style>
<script>
  import Modal from './modify_users';
  export default {
    components: {
      Modal
    },
    props: ["selectedUsers"],
    data () {
      return {
        usersModify: false,
        usersDelete: false,
        username: "",
        fullname: "",
        email: "",
        payment_method: "",
        last_login_at_date: "",
        last_login_at_boolean: "whatever",
        created_at_date: "",
        total_cameras: "",
        include_erc: "whatever",
        cameras_owned: "",
        camera_shares: "",
        licREQ1: "",
        licREQ2: "",
        licVALID1: "",
        licVALID2: "",
        licDEF1: "",
        licDEF2: "",
        allParams: {}
      }
    },
    mounted() {
      this.$events.$on("close-user-modify", eventData => this.onModifyClose(eventData))
      this.$events.$on("users-modify", eventData => this.onModifySave(eventData))
    },
    methods: {
      isNumber (evt) {
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if ((charCode > 31 && (charCode < 48 || charCode > 57))) {
          evt.preventDefault();;
        } else {
          return true;
        }
      },

      userFilterGlobal () {
        this.allParams.username = this.username
        this.allParams.fullname = this.fullname
        this.allParams.email = this.email
        this.allParams.payment_method = this.payment_method
        this.allParams.last_login_at_boolean = this.last_login_at_boolean
        this.allParams.last_login_at_date =  this.last_login_at_date
        this.allParams.created_at_date = this.created_at_date
        this.allParams.total_cameras = this.total_cameras
        this.allParams.include_erc = this.include_erc
        this.allParams.cameras_owned = this.cameras_owned
        this.allParams.camera_shares = this.camera_shares
        this.allParams.licREQ1 = this.licREQ1
        this.allParams.licREQ2 = this.licREQ2
        this.allParams.licVALID1 = this.licVALID1
        this.allParams.licVALID2 = this.licVALID2
        this.allParams.licDEF1 = this.licDEF1
        this.allParams.licDEF2 = this.licDEF2
        this.$events.fire('user-filter-set', this.allParams)
      },

      resetUserFilter () {
        this.username = ""
        this.fullname = ""
        this.email = ""
        this.payment_method = ""
        this.last_login_at_boolean = "whatever"
        this.last_login_at_date = ""
        this.created_at_date = ""
        this.total_cameras = ""
        this.include_erc = "whatever"
        this.cameras_owned = ""
        this.camera_shares = ""
        this.licREQ1 = ""
        this.licREQ2 = ""
        this.licVALID1 = ""
        this.licVALID2 = ""
        this.licDEF1 = ""
        this.licDEF2 = ""
        this.$events.fire('user-filter-reset')
      },
      onModifyClick () {
        let self = this

        if (Object.keys(self.selectedUsers).length === 0) {
          this.$notify({
            group: "admins",
            title: "Error",
            type: "error",
            text: "At least select one user!",
          });
        } else {
          this.usersModify = true
        }
      },
      onModifyClose(modal) {
        this.usersModify = modal
      },
      onModifySave (params) {
        let self = this
        let ids = ""
        self.selectedUsers.map((user) => {
          if (ids === "") {
            ids += "" + user.id +""
          } else {
            ids += "," + user.id +""
          }
        });

        this.$http.patch("/v1/update_multiple_users", {...params, ...{ids: ids}}).then(response => {
          this.usersModify = false
          this.$router.go()
          // this.$events.fire("user-modify-refresh", true)
          this.$notify({
            group: "admins",
            title: "Info",
            type: "success",
            text: "Users have been updated!",
          });
        }, error => {
          this.$notify({
            group: "admins",
            title: "Error",
            type: "error",
            text: "Something went wrong!",
          });
          this.usersModify = true
        });
      },
      deletUsers () {
        let self = this
        if (Object.keys(self.selectedUsers).length === 0) {
          this.$notify({
            group: "admins",
            title: "Error",
            type: "error",
            text: "At least select one user!",
          });
        } else {
          if (window.confirm("Are you sure you want to delete this event?")) {
            console.log(self.selectedUsers)
            self.selectedUsers.forEach((user) => {
              this.$http.delete(`${this.$root.api_url}/v1/users/${user.email}?api_id=${user.api_id}&api_key=${user.api_key}`).then(response => {
                console.log(response.body)
              }, error => {
                console.log(error)
                this.$notify({
                  group: "admins",
                  title: "Error",
                  type: "error",
                  text: `${error.body.message}`,
                });
              });
            });
            this.$notify({
              group: "admins",
              title: "Info",
              type: "success",
              text: "Users have been deleted.",
            });
            this.$router.go()
            // this.$events.fire("user-modify-refresh", true)
          }
        }
      }
    }
  }
</script>