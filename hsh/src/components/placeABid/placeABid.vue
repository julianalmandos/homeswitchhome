<template>
  <div class="placeABid">
    <b-modal
      id="placeABidModal"
      :title="'Pujar para la fecha: '+this.week.date.substring(0,10)"
      ok-title="Pujar"
      @ok.prevent="placeABidForAWeek"
    >
      <b-form-group id="bid" label="Ingrese una puja" label-for="input-1">
        <b-form-input id="input-1" v-model="price" required></b-form-input>
      </b-form-group>
      <b-form-group id="email" label="Ingrese su email" label-for="input-2">
        <b-form-input id="input-2" v-model="email" required></b-form-input>
      </b-form-group>
      <b-alert class="mt-sm-3" v-model="showPlacedBid" variant="success" dismissible>
        <font-awesome-icon icon="check"></font-awesome-icon> La puja fue realizada correctamente.
      </b-alert>
      <b-alert class="mt-sm-3" v-model="showErrorPlacingBid" variant="danger" dismissible>
        <font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> El monto de la puja es demasiado bajo.
      </b-alert>
    </b-modal>
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
      email: "", 
      showPlacedBid: false,
      showErrorPlacingBid: false,
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
  mounted() {
    this.$root.$on('bv::modal::hidden', (bvEvent, modalId) => {
      this.resetModal()
    })
  },
  methods: {
    placeABidForAWeek() {  
     axios
        .post("http://localhost:3000/week/" + this.week.id + "/bid", {
          data: {
            id: this.week.id,
            price: this.price,
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
    },
    resetModal() {
      this.showPlacedBid=false;
      this.showErrorPlacingBid=false;
      this.email='';
      this.price='';
    },
  }
};
</script>
