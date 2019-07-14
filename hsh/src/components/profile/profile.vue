<template>
  <b-container>
    <div class="profile">
        <h3 class="titulo">{{user.surname}}, {{user.name}}</h3> 
        <br><br>
        <b-row>
            <b-col>
                <p class="text"><strong>Fecha de nacimiento: </strong>{{user.birthday.substring(0,10)}}</p>
                <p class="text"><strong>Tarjeta de crédito: </strong>**** **** **** ***{{user.card_number.substring(15,18)}}</p>
                <p class="text"><strong>Fecha de vencimiento: </strong>{{user.card_expiration_month}}/{{user.card_expiration_year}}</p>
                <p class="text"><strong>Créditos: </strong>{{user.credits}}</p>
                <p class="text" v-if="isPremium()"><strong>Tipo de cuenta: </strong>Premium</p>
                <p class="text" v-if="isAdmin()"><strong>Tipo de cuenta: </strong>Administrador</p>
                <p class="text" v-if="isNormal()"><strong>Tipo de cuenta: </strong>Común</p>
            </b-col>
            <b-col>
                <b-col>
                <b-button block v-if="isNormal()" to="/become_premium" class="blueButton">Convertirse en Premium</b-button>
                <b-button block v-if="isPremium()" to="/become_normal" class="blueButton">Convertirse en Común</b-button>
                <b-button block v-if="!isAdmin()" @click="disableAccount()" class="blueButton">Deshabilitar cuenta</b-button>
                <b-button block to="/edit/profile" class="blueButton">Editar perfil</b-button>
                <b-button block @click="viewBookingsRecord" class="blueButton">Ver mi historial</b-button>
                </b-col>
            </b-col>
        </b-row>
    </div>
  </b-container>
</template>

<script>
  import Vuex from 'vuex';
  import { mapState } from "vuex";
  import axios from 'axios'

  export default {
    name: "profile",
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
      viewBookingsRecord(){
        this.$router.push('/bookings');
      },
      cancelBookings(bookings){
        bookings.forEach(element => {
          axios.post('//localhost:3000/cancelBooking',{
            data:{booking: element}
          }) 
        });
      },
      disableAccount(){
        //cancelar las reservas que tiene
        axios.post('//localhost:3000/bookingsOfUser',{
          data:{
           email: this.$store.state.user.email,
           }
        })
        .then(response => {
          this.cancelBookings(response.data)
        })
        .catch(error => {
        console.log(error);
        })
        
        //poner en 1 disabled
        console.log("llegue aca")
        axios.post('//localhost:3000/disableUser',{
          data:{
           email: this.$store.state.user.email,
           }
        })
        .catch(error => {
        console.log(error);
        })
        //cerrar sesión
        this.logoutUser();
      }
    }
  }
</script>