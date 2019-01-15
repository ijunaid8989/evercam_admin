<template>
  <div class="form-main">
    <div class="main-contain">
      <div class="filter-name">
        Search
      </div>
      <div class="input-divs">
        <input type="text" class="first-ins" placeholder="Username" id="username" autocomplete="off">
        <input type="text" class="first-ins" placeholder="Fullname" id="fullname" autocomplete="off">
        <input type="text" class="first-ins" placeholder="email" id="email" autocomplete="off">
      </div>
    </div>
    <div class="main-contain licence-space">
      <div class="filter-name">
        Licence Required
      </div>
      <div class="input-divs-s">
        <input type="text" class="small-ins" placeholder="from" id="licREQ1" autocomplete="off">
        <input type="text" class="small-ins" placeholder="to" id="licREQ2" autocomplete="off">
      </div>
      <div class="filter-second">
        Licence Valid
      </div>
      <div class="input-divs-s">
        <input type="text" class="small-ins" placeholder="from" id="licVALID1" autocomplete="off">
        <input type="text" class="small-ins" placeholder="to" id="licVALID2" autocomplete="off">
      </div>
      <div class="filter-second def-ins">
        Licence Deficient
      </div>
      <div class="input-divs-s">
        <input type="text" class="small-ins" placeholder="from" id="licDEF1" autocomplete="off">
        <input type="text" class="small-ins" placeholder="to" id="licDEF2" autocomplete="off">
      </div>
    </div>
    <div class="main-contain licence-space">
      <div class="filter-name">
        Total Cameras
      </div>
      <div class="input-divs-s">
        <input type="text" class="medium-ins" placeholder="numeric" id="total_cameras" autocomplete="off">
      </div>
      <div class="filter-second">
        Type
      </div>
      <div class="payment-type-divs">
        <select id="user_payment_type" class="first-ins" autocomplete="off">
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
        <input type="text" class="medium-ins" id="created_at_date" autocomplete="off" style="width: 35px;" placeholder="MTs">
      </div>
      <div class="filter-name" style="margin-left: -21px;width: 175px;margin-top: 4px;">
        Last Login Date Older than
      </div>
      <div class="input-divs-s" style="margin-top: 5px;width: 52px;">
        <input type="text" class="medium-ins" id="last_login_at_date" autocomplete="off" style="width: 35px;" placeholder="MTs">
      </div>
      <div class="filter-second" style="margin-top: 3px;">
        Last Login
      </div>
      <div class="payment-type-divs" style="margin-left: -25px;">
        <select id="last_login_at_boolean" class="first-ins" autocomplete="off" style="width: 135px; margin-top: 4px;">
          <option value="true">True</option>
          <option value="false">False</option>
          <option value="whatever" selected="selected">Whatever</option>
        </select>
      </div>
    </div>
    <div class="main-contain licence-space">
      <div class="filter-name" style="margin-left: 32px;">
        Cameras Owned &lt;
      </div>
      <div class="input-divs-s">
        <input type="text" class="medium-ins" placeholder="numeric" id="owned_cameras" autocomplete="off" style="width: 37px;">
      </div>
      <div class="filter-name" style="margin-left: -59px;">
        Cameras Shared &lt;
      </div>
      <div class="input-divs-s">
        <input type="text" class="medium-ins" placeholder="numeric" id="shared_cameras" autocomplete="off" style="width: 37px;">
      </div>
      <div class="filter-second" style="margin-right: 1px; margin-top: 3px;width: 152px;margin-left: -55px;">
        Remembrance Camera
      </div>
      <div class="payment-type-divs" style="margin-left: -25px;">
        <select id="include_erc" class="first-ins" autocomplete="off" style="width: 135px; margin-top: 4px;">
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
        <button class="clear-btn-f" id="btn-modify">Modify</button>
        <button class="clear-btn-f" id="btn-delete">Delete</button>
        <button type="button" class="clear-btn-f" id="filterClear">Clear Filter</button>
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