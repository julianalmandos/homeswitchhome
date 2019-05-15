<template>
  <div class="placeABid">
    <b-modal
      id="placeABidModal"
      :title="'Pujar para la fecha:'+this.week.date"
      ok-title="Pujar"
      @ok="placeABidForAWeek"
    >
      <b-form-group id="bid" label="Ingrese una puja" label-for="input-1">
        <b-form-input id="input-1" v-model="price" required></b-form-input>
      </b-form-group>
      <b-form-group id="email" label="Ingrese su email" label-for="input-2">
        <b-form-input id="input-2" required></b-form-input>
      </b-form-group>
    </b-modal>
  </div>
</template>

<script>
import Vuex from "vuex";
import axios from "axios";
export default {
  name: "placeABid",
  props: ["week"],
  data() {
    return {
      property: {},
      price: 0,
      max : 12
    }
  },
  beforeCreate() { 
    
  },
  methods: {
    placeABidForAWeek() { 
      console.log(this.week.idProperty);
      axios
      .get("http://localhost:3000/propiedades/" + this.week.idProperty)
      .then(response => {
        this.property = response.data[0]; 
      })
      .catch(error => {
        console.log(error);
      }); 
      /*axios
      .get("http://localhost:3000/pepe/" + this.week.id )
      .then(response => {
        this.max = response.data;  
      })
      .catch(error => {
        console.log(error);
      }); 
      console.log("soy el maximo");
      console.log(this.max)*/
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
          console.log("Propiedad editada correctamente");
        })
        .catch(error => {
          console.log(error);
        });

    }, 
  }
};
</script>