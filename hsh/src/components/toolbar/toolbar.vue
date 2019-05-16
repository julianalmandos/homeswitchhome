<template>
  <div class="toolbar">
    <b-navbar toggleable="lg" type="dark" style="background-color:#f2f2f2">
      <b-navbar-brand to="/">
        <img src="@/assets/HSH-Logo.svg" alt="" style="height:30px">
        <img src="@/assets/HSH-Text.svg" alt="" style="height:30px">
      </b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
          <b-nav-form>
            <b-input-group>
              <b-form-input size="sm" style="width:400px;" placeholder="Buscar propiedad..."></b-form-input>
              <b-input-group-append>
                <b-button size="sm" class="my-2 my-sm-0 botonAzul" type="submit">Buscar</b-button>
              </b-input-group-append>              
            </b-input-group>
          </b-nav-form>
        </b-navbar-nav>

        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">
          <!--<b-nav-item to="/acerca-de">Acerca De</b-nav-item>
          <b-nav-item to="/contacto">Contacto</b-nav-item>-->
          <b-nav-item-dropdown v-if="user==null" right>
            <template slot="button-content">Acceder</template>
            <access/>
          </b-nav-item-dropdown>
          <b-nav-item-dropdown v-else right>
            <!-- Using 'button-content' slot -->
            <template slot="button-content">{{user.surname}}, {{user.name}}</template>
            <!--<b-dropdown-item href="#">Perfil</b-dropdown-item>
            <b-dropdown-item href="#">Configuración</b-dropdown-item>-->
            <b-dropdown-item @click="viewAdministrationPanel"><font-awesome-icon icon="book"></font-awesome-icon> Panel de Administracion</b-dropdown-item>
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
        this.$router.push('/administration');
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

.botonAzul{
  background-color:#00a1e1!important;
}

.botonAzul:hover{
  background-color:white!important;
  color:black!important;
}

</style>