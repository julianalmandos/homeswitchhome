<template>
  <div class="openHotSale">
    <b-form @submit.stop.prevent="openHotSaleForAWeek">
      <b-modal
        id="openHotSaleModal"
        :title="'Ponga un monto para la semana: '+this.week.date.substring(0,10)"
        ok-title="Guardar"
        @hide="resetModal"
        @open="resetModal"
      >
        <b-alert class="mt-sm-3" v-model="showErrorPrice" variant="danger" dismissible>
          <font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> El monto debe ser mayor a 0
        </b-alert>
        <b-alert class="mt-sm-3" v-model="showCorrectPrice" variant="success" dismissible>
          <font-awesome-icon icon="check"></font-awesome-icon> El cambio fue realizado correctamente.
        </b-alert>
        <b-alert class="mt-sm-3" v-model="showErrorEmptyFields" variant="danger" dismissible>
          <font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> El monto debe ser mayor a 0
        </b-alert>
        
        <b-form-group id="price" label="Ingrese el monto" label-for="input-1">
          <b-form-input id="input-1" v-model="price" required/>
        </b-form-group>
        
        <template slot="modal-footer" slot-scope="{  hide }">
          <b-button class="blueButton" @click="hide()">Cancelar</b-button>
          <b-button class="blueButton" type="submit">Guardar</b-button>          
        </template>
      </b-modal>
    </b-form>
  </div>
</template>

<script>
import Vuex from "vuex";
import axios from "axios";
export default {
  name: "openHotSale",
  props: {
    week: Object,
    weekModal: String,
  },
  data() {
    return {
      property: {},
      price: '',
      showCorrectPrice: false,
      showErrorPrice: false,
      showErrorEmptyFields: false,
    }
  },
  beforeMount() { 
      console.log("llegue hasta aca")
  },
  methods: {
    openHotSaleForAWeek() { 
      this.resetAlerts(); 
      if(this.$store.state.user !== null && this.price != '' && this.price > 0){ 
        axios
          .post("http://localhost:3000/weeks/" + this.week.id + "/hotSale/price", {
            data: {
              id: this.week.id,
              price: this.price,  
              idProperty: this.week.idProperty, 
            }
          })
          .then(response => {
            this.showCorrectPrice=true;
            this.$emit('placed'); 
          })
          .catch(error => {
            this.showErrorPrice=true;
            console.log(error);
          });
      }else{
        this.showErrorEmptyFields=true;
      }      
    },
    resetModal() {
      this.showCorrectPrice=false;
      this.showErrorPrice=false; 
      this.price='';
    },
    handleOk(bvModalEvt) {
      bvModalEvt.preventDefaul();
      this.openHotSaleForAWeek();
    },
    resetAlerts() {
      this.showCorrectPrice=false;
      this.showErrorPrice=false;
      this.showErrorEmptyFields=false;
    }
  }
};
</script>