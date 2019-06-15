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
          <b-nav-item class="navLink" to="/"><strong>Inicio</strong></b-nav-item>
        </b-navbar-nav>
        <!--<b-navbar-nav>
          <b-nav-form>
            <b-input-group>
              <b-form-input size="sm" style="width:400px;" placeholder="Buscar propiedad..."></b-form-input>
              <b-input-group-append>
                <b-button size="sm" class="my-2 my-sm-0 blueButton" type="submit">Buscar</b-button>
              </b-input-group-append>              
            </b-input-group>
          </b-nav-form>
        </b-navbar-nav>-->

        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">
          <!--<b-nav-item to="/acerca-de">Acerca De</b-nav-item>
          <b-nav-item to="/contacto">Contacto</b-nav-item>-->
          
          <b-nav-item-dropdown ref="dropdown" v-if="user==null" right>
            <template slot="button-content">Acceder</template>
            <access @closeDropdown="closeDropdown"/>
          </b-nav-item-dropdown>
          <b-nav-item-dropdown ref="dropdown" v-else right>
            <!-- Using 'button-content' slot -->
            <template slot="button-content">{{user.surname}}, {{user.name}}</template>
            <!--<b-dropdown-item href="#">Perfil</b-dropdown-item>
            <b-dropdown-item href="#">Configuración</b-dropdown-item>-->
            <b-dropdown-item v-if="isAdmin()" @click="viewAdministrationPanel"><font-awesome-icon icon="book"></font-awesome-icon> Panel de Administracion</b-dropdown-item>
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
      viewAdministrationPanel() {
        this.$router.push('/panel');
      },
      isAdmin() {
        return this.user.role==2;
      },
      closeDropdown() {
        console.log('recibi evento');
        this.$refs.dropdown.hide();
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

</style>