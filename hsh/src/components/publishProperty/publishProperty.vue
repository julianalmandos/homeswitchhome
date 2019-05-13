<template>
  <div class="publish-property">
     <form @submit.prevent="registerProperty">
      <div class="form-group">
       <label for="property-name">Ingrese el nombre de la propiedad</label>
       <input type="name" id="name" v-model="dataRegisterProperty.name" required>
     </div>

     <div class="form-group">
       <label for="property-description">Ingrese la descripción de la propiedad</label>
       <input
         type="description"
         id="description"
         v-model="dataRegisterProperty.description"
         required
       >
     </div>

     <div class="form-group">
       <label for="property-address">Ingrese la dirección de la propiedad</label>
       <input type="address" id="address" v-model="dataRegisterProperty.address" required>
     </div>

     <div class="form-group">
       <label for="property-base-price">Ingrese el precio base de la propiedad</label>
       <input type="base_price" id="base_price" v-model="dataRegisterProperty.base_price" required>
     </div>

     <div class="form-group">
       <label for="property-country">Ingrese el país de la propiedad</label>
       <input type="country" id="country" v-model="dataRegisterProperty.country" required>
     </div>

     <div class="form-group">
       <label for="property-province">Ingrese la provincia de la propiedad</label>
       <input type="province" id="province" v-model="dataRegisterProperty.province" required>
     </div>

     <div class="form-group">
       <label for="property-locality">Ingrese la localidad de la propiedad</label>
       <input type="locality" id="locality" v-model="dataRegisterProperty.locality" required>
     </div>
      <b-button size="sm" class="my-2 my-sm-3" type="submit" variant="dark">Registrar</b-button>
    </form>
  </div>
</template>

<script>
import { mapState } from "vuex";
import axios from 'axios';

export default {
  name: "publishProperty",
  data() {
    return {
      dataRegisterProperty: {
        name: "",
        description: "",
        address: "",
        base_price: "",
        country: "",
        province: "",
        locality: ""
      }
    };
  },
  methods: {
    registerProperty() {
      axios.post("http://localhost:3000/propiedades", {
        data: this.dataRegisterProperty
      });
    }
  }
};
</script>

