<template>
  <div v-if="usersModify">
    <transition name="modal">
     <div class="modal modal-mask" style="display: block">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title">
              Modify Users
            </h3>
          </div>
          <div class="modal-body">
            <div class="form-group row">
              <label class="col-md-4 col-form-label cntry">Country</label>
              <div class="col-md-7">
                <select class="form-control is-required" autocomplete="off" v-model="selectedCountry">
                  <option v-for="country in countries" v-bind:value="country.id">
                    {{ country.name }}
                  </option>
                </select>
              </div>
            </div>
            <div class="form-group row">
              <label class="col-md-4 col-form-label">Payment Type</label>
              <div class="col-md-7">
                <select class="form-control is-required" autocomplete="off" v-model="selectPMethod">
                  <option value="0">Stripe</option>
                  <option value="1">Custom</option>
                  <option value="2">Construction</option>
                  <option value="3">Gardai</option>
                  <option value="4">Smart Cities</option>
                  <option value="5">Unknown</option>
                </select>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-success" @click="saveAndHideUserModify()"> Save </button>
            <button type="button" class="btn btn-primary" @click="hideUserModify()"> Close </button>
          </div>
        </div>
      </div>
    </div>
    </transition>
  </div>
</template>

<style>
.modal-mask {
   position: fixed;
   z-index: 9998;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background-color: rgba(0, 0, 0, .5);
   display: table;
   transition: opacity .3s ease;
}

.modal-dialog {
  width: 350px;
  margin-top: 114.5px;
}

.modal-body .cntry {
  text-align: left;
}
</style>

<script>
  export default {
    props: ["usersModify"],
    data: () => {
      return {
        selectedCountry: 1,
        selectPMethod: 0,
        countries: []
      }
    },
    mounted(){
      this.fetchCountries()
    },
    methods: {
      hideUserModify () {
        this.selectedCountry = 1
        this.selectPMethod = 0
        this.$events.fire("close-user-modify", false)
      },
      fetchCountries () {
        this.$http.get("/v1/countries").then(response => {
          this.countries = response.body;
        }, error => {
          console.error(error);
        });
      },
      saveAndHideUserModify () {
        const params = {
          country: this.selectedCountry,
          payment_type: this.selectPMethod
        }
        this.selectedCountry = 1
        this.selectPMethod = 0
        this.$events.fire("users-modify", params)
      }
    }
  }
</script>