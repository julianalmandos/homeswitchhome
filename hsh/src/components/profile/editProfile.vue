<template>
  <b-container class="editProperty"> 
      <div class="titulo"><h1>Editar Perfil</h1><h3> '{{user.name}} {{user.surname}}'</h3></div><br>
      <form @submit.prevent="profileEdition">
  
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
        <b-col>
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
        </b-col>
        <b-row align-h="between">
            <b-button class="blueButton" to="/profile" style="float:left;"><font-awesome-icon icon="list-alt"></font-awesome-icon> Volver al Perfil</b-button>
            <b-button type="submit" class="blueButton" style="float:right;"><font-awesome-icon icon="home"></font-awesome-icon> Editar</b-button> 
        </b-row>
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
      },
      profileEdition(){
        if(confirm('¿Está seguro que desea editar su perfil?')){
        axios
            .post("http://localhost:3000/user/edit", {
            data: {
                user: this.user
            } 
            })
            .then(response => {
                        
            })
            .catch(error => {
            console.log(error);
            }); 
            this.$bvToast.toast('El perfil se editó correctamente',{
                title: 'Operación exitosa',
                variant: 'success',
                autoHideDelay: 5000,
                toaster: 'b-toaster-bottom-right',
            })
      }
      }
    }
  }
</script>