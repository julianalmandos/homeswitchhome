<template>
  <div class="placeABid">
    <b-form @submit.stop.prevent="placeABidForAWeek">
      <b-modal
        id="placeABidModal"
        :title="'Pujar para la fecha: '+this.week.date.substring(0,10)"
        ok-title="Pujar"
        @hide="resetModal"
        @open="resetModal"
      >
        <b-alert class="mt-sm-3" v-model="showErrorPlacingBid" variant="danger" dismissible>
          <font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> El monto de la puja es demasiado bajo.
        </b-alert>
        <b-alert class="mt-sm-3" v-model="showPlacedBid" variant="success" dismissible>
          <font-awesome-icon icon="check"></font-awesome-icon> La puja fue realizada correctamente.
        </b-alert>
        <b-alert class="mt-sm-3" v-model="showErrorEmptyFields" variant="danger" dismissible>
          <font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> Por favor, complete todos los campos antes de pujar.
        </b-alert>
        
        <b-form-group id="bid" label="Ingrese una puja" label-for="input-1">
          <b-form-input id="input-1" v-model="price" required/>
        </b-form-group>
        
        <template slot="modal-footer" slot-scope="{  hide }">
          <b-button class="blueButton" @click="hide()">Cancelar</b-button>
          <b-button class="blueButton" type="submit">Pujar</b-button>          
        </template>
      </b-modal>
    </b-form>
  </div>
</template>

<script>
import Vuex from "vuex";
import axios from "axios";
export default {
  name: "placeABid",
  props: {
    week: Object,
    weekModal: String,
  },
  data() {
    return {
      property: {},
      price: '',
      showPlacedBid: false,
      showErrorPlacingBid: false,
      showErrorEmptyFields: false,
    }
  },
  beforeMount() { 
    console.log(this.week.idProperty);
      axios
      .get("http://localhost:3000/properties/" + this.week.idProperty)
      .then(response => {
        this.property = response.data[0]; 
      })
      .catch(error => {
        console.log(error);
      }); 
  },
  methods: {
    placeABidForAWeek() { 
      this.resetAlerts(); 
      if(this.$store.state.user !== null && this.price != ''){
        axios
          .post("http://localhost:3000/weeks/" + this.week.id + "/bid", {
            data: {
              id: this.week.id,
              price: this.price,
              email: this.$store.state.user.email,
              base_price: this.property.base_price,
              idProperty: this.week.idProperty,
              max: this.max
            }
          })
          .then(response => {
            this.showPlacedBid=true;
            this.$emit('placed');
            console.log("Puja realizada con exito");
          })
          .catch(error => {
            this.showErrorPlacingBid=true;
            console.log(error);
          });
      }else{
        this.showErrorEmptyFields=true;
      }      
    },
    resetModal() {
      this.showPlacedBid=false;
      this.showErrorPlacingBid=false;
      this.email='';
      this.price='';
    },
    handleOk(bvModalEvt) {
      bvModalEvt.preventDefaul();
      this.placeABidForAWeek();
    },
    resetAlerts() {
      this.showPlacedBid=false;
      this.showErrorPlacingBid=false;
      this.showErrorEmptyFields=false;
    }
  }
};
</script>
