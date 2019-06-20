<template>
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
            <b-button block v-if="isNormal()" class="blueButton">Convertirse en Premium</b-button>
            <b-button block v-if="isPremium()" class="blueButton">Convertirse en Común</b-button>
            <b-button block to="/edit/profile" class="blueButton">Editar perfil</b-button>
            <b-button block class="blueButton">Ver historiar de reservas</b-button>
            </b-col>
        </b-col>
    </b-row>
</div>
</template>

<script>
  import Vuex from 'vuex';
  import { mapState } from "vuex";

  export default {
    name: "profile",
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
    }
  }
</script>