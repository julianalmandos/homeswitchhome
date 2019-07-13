<template>
  <div class="toolbar">
    <b-navbar id="navigationBar" toggleable="lg" type="dark">
      <b-navbar-brand to="/">
        <img src="@/assets/HSH-Logo.svg" alt="" style="height:30px">
        <img src="@/assets/HSH-Text.svg" alt="" style="height:30px">
      </b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
          <b-nav-item class="navLink" to="/"><strong><font-awesome-icon icon="home"></font-awesome-icon> Inicio</strong></b-nav-item>
          <b-nav-item v-if="user!=null" class="navLink" to="/auctions"><strong><font-awesome-icon icon="gavel"></font-awesome-icon> Subastas</strong></b-nav-item>
          <b-nav-item class="navLink" to="/faq"><strong><font-awesome-icon icon="question-circle"></font-awesome-icon> Preguntas Frecuentes</strong></b-nav-item>
          <b-nav-item class="navLink" to="/contact"><strong><font-awesome-icon icon="archway"></font-awesome-icon> ¿Quiénes somos?</strong></b-nav-item>
        </b-navbar-nav>

        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">
          <!--<b-nav-item to="/acerca-de">Acerca De</b-nav-item>
          <b-nav-item to="/contacto">Contacto</b-nav-item>-->
          <b-nav-item-dropdown ref="dropdown" v-if="user!==null" right>
            <template slot="button-content" >Buscar</template>
            <b-alert class="mt-sm-3" v-model="showErrorEmptyFields" variant="danger" dismissible>
          <font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> Por favor, complete los campos antes de buscar.
        </b-alert> 
        <b-alert class="mt-sm-3" v-model="showErrorWrongDates" variant="danger" dismissible>
          <font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> La fecha ingresada es inválida.
        </b-alert>
            <b-col>
            <h4>Localidad:</h4>
            <b-form-input size="sm" style="width:300px;" v-model="locality"></b-form-input>
            <br>
            <h4>Fecha inicial:</h4>
            <b-form @submit.stop.prevent="check()">
              <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                        id="range"
                        type="date"
                        v-model="startDate"
                        :min="minDate()"
                        :max="maxDate()"
                        style="width:300px"
                    ></b-form-input>
                    <h4>Fecha final:</h4>
              <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                        id="range"
                        type="date"
                        v-model="finishDate"
                        :min="minDate()"
                        :max="maxDate()"
                        style="width:300px"
                    ></b-form-input>
              <b-input-group-append>
                 <!-- <b-button size="sm" class="my-2 my-sm-0 blueButton" :to="{ name: 'searchProperties', params: { locality: this.locality, startDate:this.startDate, finishDate:this.finishDate }}" type="submit">Buscar</b-button>-->
                  <b-button size="sm" class="my-2 my-sm-0 blueButton" type="submit">Buscar</b-button>
                  <b-button size="sm" class="my-2 my-sm-0 blueButton" type="button" @click="resetModal">Cancelar</b-button>
              </b-input-group-append>  
            </b-form>
              </b-col>
          </b-nav-item-dropdown>
          <b-nav-item-dropdown ref="dropdown" v-if="user==null" right>
            <template slot="button-content">Acceder</template>
            <access @closeDropdown="closeDropdown"/>
          </b-nav-item-dropdown>
          <b-nav-item-dropdown ref="dropdown" v-else right>
            <!-- Using 'button-content' slot -->
            <template slot="button-content">{{user.surname}}, {{user.name}}
              <b-badge v-if="isNormal()" class="blueBadge"> Común</b-badge>
              <b-badge v-if="isPremium()" class="blueBadge"><font-awesome-icon icon="star"></font-awesome-icon> Premium</b-badge>
              <b-badge v-if="isAdmin()" class="blueBadge"><font-awesome-icon icon="medal"></font-awesome-icon> Administrador</b-badge>
            </template>

            <b-dropdown-item to="/profile"><font-awesome-icon icon="user-alt"></font-awesome-icon> Perfil</b-dropdown-item>
            <!--<b-dropdown-item href="#">Configuración</b-dropdown-item>-->
            <!--<b-dropdown-item v-if="isPremium()" to="/become_normal"><font-awesome-icon icon="book"></font-awesome-icon> Convertirse en Normal</b-dropdown-item>
            <b-dropdown-item v-if="isNormal()" to="/become_premium"><font-awesome-icon icon="star"></font-awesome-icon> Convertirse en Premium</b-dropdown-item> -->
            <b-dropdown-item v-if="isAdmin()" to="/panel"><font-awesome-icon icon="book"></font-awesome-icon> Panel de Administracion</b-dropdown-item> 
            <b-dropdown-item @click="logoutUser"><font-awesome-icon icon="sign-out-alt"></font-awesome-icon> Cerrar Sesión</b-dropdown-item>
          </b-nav-item-dropdown>

        </b-navbar-nav>
      </b-collapse>
    </b-navbar>

  </div>

</template>

<script>
  import Vuex from 'vuex';
  import access from '@/components/access/access.vue';
  import { mapState } from "vuex";

  export default {
    name: "toolbar",
    components: {
      access
    },
    data(){
      return {
        locality: '',
        startDate: '',
        finishDate: '',
        showErrorEmptyFields: false,
        showErrorWrongDates: false,
      }
    },
    computed: {
      ...Vuex.mapState([
        'user',
      ])
    },
    methods: {
      ...Vuex.mapActions([
        'logoutUserAction',
      ]),
      logoutUser(){
        this.logoutUserAction();
      },
      isAdmin() {
        return this.user.role==2;
      },
      isPremium() {
        return this.user.role==1;
      },
      isNormal() {
        return this.user.role==0;
      },
      closeDropdown() {
        console.log('recibi evento');
        this.$refs.dropdown.hide();
      },
      searchLocality(){
        return (this.locality!==''&&this.startDate==''&&this.finishDate=='')
      },
      searchRange(){
         return (this.locality==''&&this.startDate!==''&&this.finishDate!=='')
      },
      searchAll(){
         return (this.locality!==''&&this.startDate!==''&&this.finishDate!=='')
      },
      checkDate(){
        var actualDate = new Date()
        actualDate= actualDate.toISOString().substring(0,10);
        var controlDate= new Date(this.startDate.substring(0,4),this.startDate.substring(5,7),this.startDate.substring(8,10));
        controlDate.setDate(controlDate.getDate()+60);
        controlDate = controlDate.toISOString().substring(0,10);
        return (this.startDate>this.finishDate)||(controlDate<=this.finishDate)||(this.startDate<actualDate)
      },
      check(){
       
        if(this.searchLocality()||this.searchRange()||this.searchAll()){
          if (!this.searchLocality()&&this.checkDate()){
            this.showErrorWrongDates = true
          }else{
            this.$router.push('/search_properties/'+this.locality+'/'+this.startDate+'/'+this.finishDate);
          }
        }else{
          this.showErrorEmptyFields = true
        }
      },
      minDate(){
        var date = new Date()
        date.setDate(date.getDate() -1)
        return date.toISOString().substring(0,10)
      },
      maxDate(){
        var date = new Date()
        date.setDate(date.getDate() -1)
        date.setMonth(date.getMonth() + 12)
        return date.toISOString().substring(0,10)
      },
      resetModal() {
      this.showErrorEmptyFields=false;
      this.showErrorWrongDates=false;
      this.locality='';
      this.startDate='';
      this.finishDate='';
    },
    handleOk(bvModalEvt) {
      bvModalEvt.preventDefaul();
      this.Subimit();
    },
    resetAlerts() { 
      this.showErrorEmptyFields=false;
      this.showErrorWrongDates = false;
    }
    }
  }
</script>

<style>
  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
  }
  #nav {
    padding: 30px;
  }

  #nav a {
    font-weight: bold;
    color: #2c3e50;
  }

  #nav a.router-link-exact-active {
    color: #42b983;
  }

  .nav-link{
    color: #4c4d4f!important;
  }

  .blueButton{
    background-color:rgba(0,161,225,0.5)!important;
  }

  .blueButton:hover{
    background-color:white!important;
    color:black!important;
  }

  .redButton {
    background-color:rgba(255, 102, 102,0.5)!important;
  }

  .redButton:hover {
    background-color:white!important;
    color:black!important;
  }

  .transparentButton {
    border: 1px solid black;
    color:black!important;
    background-color:white!important;
  }

  .transparentButton:hover {
    background-color:rgba(0,161,225,0.5)!important;
    color:white!important;
  }

  #navigationBar {
    background-color:#f2f2f2;
    box-shadow: 0px 6px 3px -4px rgba(0,0,0,0.75);
  }

  #logo {
    position: relative;
    position: absolute;
    left: 50%;
    margin-left: -206.79px !important;
    display: block;
  }

  .navLink{
    border-radius:5px;
  }

  .navLink:hover {
    background-color: rgba(0,161,225,0.5)!important;
  }

  .blueBadge, .blueBadge:hover {
    background-color: rgba(0,161,225,0.5)!important;
  }

</style>