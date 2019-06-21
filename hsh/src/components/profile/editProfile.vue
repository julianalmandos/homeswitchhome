<template>
  <b-container class="editProperty"> 
      <div class="titulo"><h1>Editar Perfil</h1><h3> '{{user.name}} {{user.surname}}'</h3></div><br>
      <form @submit.prevent="profileEdition">
  
        <br>
        <h4 style="float:left">Datos de la tarjeta: </h4>
        <br>
        <br>
        <b-form-select size="sm" class="mr-sm-2 mb-sm-3"
            id="cardType"
            type="text"
            v-model="card_type"
            required
            style="width:100%"
            :options="types()"
        >
            <template slot="first">
                <option :value="null" disabled>Tipo de Tarjeta</option>
            </template>
        </b-form-select>
        <b-row>
        <b-col>
          <b-form-group id="nombre" label="Número de la tarjeta: " label-for="date">
            <b-form-input id="date" v-model="card_number" required></b-form-input>
        </b-form-group>
        <b-form-group id="nombre" label="Mes de vencimiento: " label-for="date">
            <b-form-input id="date" v-model="card_expiration_month" required></b-form-input>
        </b-form-group>
        </b-col>
        <b-col>
        <b-form-group id="nombre" label="Código de seguridad: " label-for="date">
            <b-form-input id="date" v-model="card_security_number" required></b-form-input>
        </b-form-group>
        <b-form-group id="nombre" label="Año de vencimiento: " label-for="date">
            <b-form-input id="date" v-model="card_expiration_year" required></b-form-input>
        </b-form-group>
        </b-col>
        </b-row>
        <br>
        <h4 style="float:left">Contraseña: </h4>
        <br>
        <br>
        <b-form-group id="nombre" label="Contraseña: " label-for="date">
            <b-form-input id="date" type="password" v-model="newPassword"></b-form-input>
        </b-form-group>
        <b-form-group id="nombre" label="Confirmación: " label-for="date">
            <b-form-input id="date" type="password" v-model="conPassword"></b-form-input>
        </b-form-group>
        
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
  import axios from "axios";

  export default {
    name: "toolbar",
    data(){
      return{
      newPassword: '',
      conPassword: '',
      card_number: this.$store.state.user.card_number,
      card_expiration_month: this.$store.state.user.card_expiration_month,
      card_expiration_year: this.$store.state.user.card_expiration_year,
      card_security_number: this.$store.state.user.card_security_number,
      card_type: this.$store.state.user.card_type,     
      }
    },
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
      validateData(){
        var date = new Date();
        var actual = new Date();
        date.setDate(1);
        date.setMonth(this.card_expiration_month);
        date.setFullYear(this.card_expiration_year);
        return date>actual
  
      },
      checkPassword(){
        return this.newPassword == this.conPassword
      },
      updateUser(){
        this.$store.state.user.card_number=this.card_number
        this.$store.state.user.card_security_number=this.card_security_number
        this.$store.state.user.card_expiration_month=this.card_expiration_month
        this.$store.state.user.card_expiration_year=this.card_expiration_year
        this.$store.state.user.card_type=this.card_type
      },
      types() {
        return ['VISA','MasterCard','American Express'];
      },
      profileEdition(){
          if(this.validateData()){
            if(this.checkPassword()){
            if(confirm('¿Está seguro que desea editar su perfil?')){
            axios
                .post("http://localhost:3000/profile/edit", {
                data: {
                  userid: this.$store.state.user.id,
                  newPassword: this.newPassword,
                  card_number: this.card_number,
                  card_expiration_month: this.card_expiration_month,
                  card_expiration_year: this.card_expiration_year,
                  card_security_number: this.card_security_number,
                  card_type: this.card_type,
                } 
                })
                .then(response => {
                    this.$store.state.user.password = response.data
                    this.$bvToast.toast('El perfil se editó correctamente',{
                    title: 'Operación exitosa',
                    variant: 'success',
                    autoHideDelay: 5000,
                    toaster: 'b-toaster-bottom-right',
                  
              }) 
              this.updateUser()    
                })
                .catch(error => {
                console.log(error);
                }); 
                
          }
          }else{
            this.$bvToast.toast('La contraseña y su confirmación no coinciden',{
                    title: 'Operación fallida',
                    variant: 'danger',
                    autoHideDelay: 5000,
                    toaster: 'b-toaster-bottom-right',
              })
          }
        }else{
          this.$bvToast.toast('La tarjeta está vencida',{
                    title: 'Operación fallida',
                    variant: 'danger',
                    autoHideDelay: 5000,
                    toaster: 'b-toaster-bottom-right',
              })

        }
      }
    }
  }
</script>