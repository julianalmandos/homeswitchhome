<template>
  <b-container class="editProperty"> 
      <div class="titulo"><h1>Editar Perfil</h1><h3> '{{user.name}} {{user.surname}}'</h3></div><br>
      <form @submit.prevent="propertyEdition">
        <b-form-group id="nombre" label="Nombre: " label-for="text">
            <b-form-input id="text" v-model="user.name" required></b-form-input>
        </b-form-group>
        <b-form-group id="nombre" label="Apellido: " label-for="text">
            <b-form-input id="text" v-model="user.surname" required></b-form-input>
        </b-form-group>
        <b-form-group id="nombre" label="Fecha de nacimiento: " label-for="date">
            <b-form-input id="date" v-model="user.birthday" required></b-form-input>
        </b-form-group>
        <br>
        <h4 style="float:left">Datos de la tarjeta: </h4>
        <br>
        <br>
        <b-form-group id="nombre" label="Número de la tarjeta: " label-for="date">
            <b-form-input id="date" v-model="user.card_number" required></b-form-input>
        </b-form-group>
        <b-form-group id="nombre" label="Código de seguridad: " label-for="date">
            <b-form-input id="date" v-model="user.card_security_number" required></b-form-input>
        </b-form-group>
        <br>
        <h5 style="float:left">Fecha de vencimiento: </h5>
        <br>
        <br>
        <b-form-group id="nombre" label="Mes: " label-for="date">
            <b-form-input id="date" v-model="user.card_expiration_month" required></b-form-input>
        </b-form-group>
        <b-form-group id="nombre" label="Año: " label-for="date">
            <b-form-input id="date" v-model="user.card_expiration_year" required></b-form-input>
        </b-form-group>
        <!--<b-row align-h="between">
            <b-button class="blueButton" style="float:left;"><font-awesome-icon icon="list-alt"></font-awesome-icon> Volver al Perfil</b-button>
            <b-button type="submit" class="blueButton" style="float:right;"><font-awesome-icon icon="home"></font-awesome-icon> Editar</b-button> 
        </b-row> -->
      </form>
  </b-container>
</template>

<script>
  import Vuex from 'vuex';
  import { mapState } from "vuex";

  export default {
    name: "toolbar",
    computed: {
      ...Vuex.mapState([
        'user',
      ])
    },
    methods: {
      isAdmin() {
        return this.user.role==2;
      },
      isPremium() {
        return this.user.role==1;
      },
      isNormal() {
        return this.user.role==0;
      },
      toString(){
        return this.user.birthday.toISOString();
      }
    }
  }
</script>