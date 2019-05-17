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

      <div class="form-group" v-for="(image, index) of this.imagesArray" :key="index">
        <label for="property-files[index]">Ingrese el link de la imagen</label>
        <input
          v-if="index==0"
          type="files[index]"
          id="files[index]"
          v-model="dataRegisterProperty.files[index]" 
          required
        >
        <input 
          v-else
          type="files[index]"
          id="files[index]"
          v-model="dataRegisterProperty.files[index]"
        >
      </div>

      <b-button size="sm" class="my-2 my-sm-3" type="submit" variant="outline-primary">Publicar propiedad</b-button>
    </form>
  </div>
</template>

<script>
import vuex from "vuex";
import axios from "axios";

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
        locality: "",
        files: [], 
      },
      imagesArray: new Array(5)
    };
  },
  methods: {
    registerProperty() {
      axios.post("http://localhost:3000/properties/publish", {
        data: this.dataRegisterProperty
      });
    }
  }
};
</script>

