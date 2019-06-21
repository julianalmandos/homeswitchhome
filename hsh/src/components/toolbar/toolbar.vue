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
          <b-nav-item class="navLink" to="/auctions"><strong><font-awesome-icon icon="gavel"></font-awesome-icon> Subastas</strong></b-nav-item>
        </b-navbar-nav>
       <!-- <b-navbar-nav>
          <b-nav-form>
            <b-input-group>
              <b-form-input size="sm" style="width:300px;" placeholder="Escriba una localidad" required></b-form-input>
              <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                        id="range"
                        type="date"
                        required
                        placeholder="Ingrese un rango"
                        style="width:200px"
                    ></b-form-input>
              <b-input-group-append>
                <b-button size="sm" class="my-2 my-sm-0 blueButton" :to="{ name: 'searchProperties', params: { locality: this, range:this }}" type="submit">Buscar</b-button>
              </b-input-group-append>              
            </b-input-group>
          </b-nav-form>
        </b-navbar-nav> -->

        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">
          <!--<b-nav-item to="/acerca-de">Acerca De</b-nav-item>
          <b-nav-item to="/contacto">Contacto</b-nav-item>-->
          <b-nav-item-dropdown ref="dropdown" v-if="user!==null" right>
            <template slot="button-content">Buscar</template>
            <b-col>
            <h4>Localidad:</h4>
            <b-form-input size="sm" style="width:300px;" v-model="locality" required></b-form-input>
            <br>
            <h4>Fecha inicial:</h4>
              <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                        id="range"
                        type="date"
                        v-model="startDate"
                        required
                        style="width:300px"
                    ></b-form-input>
                    <h4>Fecha final:</h4>
              <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                        id="range"
                        type="date"
                        v-model="finishDate"
                        required
                        style="width:300px"
                    ></b-form-input>
              <b-input-group-append>
                  <b-button size="sm" class="my-2 my-sm-0 blueButton" :to="{ name: 'searchProperties', params: { locality: this.locality, startDate:this.startDate, finishDate:this.finishDate }}" type="submit">Buscar</b-button>
              </b-input-group-append>  
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
        finishDate: ''
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