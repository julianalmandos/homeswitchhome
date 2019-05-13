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
    <div class="form-group">
      <b-form-file
        required
        accept="image/*"
        v-model="dataRegisterProperty.files[0]"
        :state="Boolean(dataRegisterProperty.files[0])"
        placeholder="Seleccione una imagen para subir"
        drop-placeholder="Arrastre una imagen para subir"
      ></b-form-file>
      <div class="mt-3">Selected file: {{ dataRegisterProperty.files[0] ? dataRegisterProperty.files[0].name : '' }}</div>
      <b-form-file
        accept="image/*"
        v-model="dataRegisterProperty.files[1]"
        :state="Boolean(dataRegisterProperty.files[1])"
        placeholder="Seleccione una imagen para subir"
        drop-placeholder="Arrastre una imagen para subir"
      ></b-form-file>
      <div class="mt-3">Selected file: {{ dataRegisterProperty.files[1] ? dataRegisterProperty.files[1].name : '' }}</div>
      <b-form-file
        accept="image/*"
        v-model="dataRegisterProperty.files[2]"
        :state="Boolean(dataRegisterProperty.files[2])"
        placeholder="Seleccione una imagen para subir"
        drop-placeholder="Arrastre una imagen para subir"
      ></b-form-file>
      <div class="mt-3">Selected file: {{ dataRegisterProperty.files[2] ? dataRegisterProperty.files[2].name : '' }}</div>
      <b-form-file
        accept="image/*"
        v-model="dataRegisterProperty.files[3]"
        :state="Boolean(dataRegisterProperty.files[3])"
        placeholder="Seleccione una imagen para subir"
        drop-placeholder="Arrastre una imagen para subir"
      ></b-form-file>
      <div class="mt-3">Selected file: {{ dataRegisterProperty.files[3] ? dataRegisterProperty.files[3].name : '' }}</div>
      <b-form-file
        accept="image/*"
        v-model="dataRegisterProperty.files[4]"
        :state="Boolean(dataRegisterProperty.files[4])"
        placeholder="Seleccione una imagen para subir"
        drop-placeholder="Arrastre una imagen para subir"
      ></b-form-file>
      <div class="mt-3">Selected file: {{ dataRegisterProperty.files[4] ? dataRegisterProperty.files[4].name : '' }}</div>
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
        locality: "",
        files: [],
      },
    };
  },
  methods: {
    registerProperty() {
      var imagesArray=[];
      console.log('entra');
      this.dataRegisterProperty.files.forEach(archivo => {
        var reader = new FileReader();
        reader.onloadend = function() {
          imagesArray.push(reader.result);
        }
        reader.readAsDataURL(archivo);
      });
      console.log("hola");
      console.log("soy vacio");
      this.dataRegisterProperty.file = imagesArray;
      axios.post("http://localhost:3000/properties/publish", {
        data: this.dataRegisterProperty
      });
    }
  }
};
</script>

