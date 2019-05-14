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
          v-model="imagesArray[0]"
          :state="Boolean(imagesArray[0])"
          placeholder="Seleccione una imagen para subir"
          drop-placeholder="Arrastre una imagen para subir"
        ></b-form-file>
        <div
          class="mt-3"
        >Selected file: {{ imagesArray[0] ? imagesArray[0].name : '' }}</div>
        <b-form-file
          accept="image/*"
          v-model="imagesArray[1]"
          :state="Boolean(imagesArray[1])"
          placeholder="Seleccione una imagen para subir"
          drop-placeholder="Arrastre una imagen para subir"
        ></b-form-file>
        <div
          class="mt-3"
        >Selected file: {{ imagesArray[1] ? imagesArray[1].name : '' }}</div>
        <b-form-file
          accept="image/*"
          v-model="imagesArray[2]"
          :state="Boolean(imagesArray[2])"
          placeholder="Seleccione una imagen para subir"
          drop-placeholder="Arrastre una imagen para subir"
        ></b-form-file>
        <div
          class="mt-3"
        >Selected file: {{ imagesArray[2] ? imagesArray[2].name : '' }}</div>
        <b-form-file
          accept="image/*"
          v-model="imagesArray[3]"
          :state="Boolean(imagesArray[3])"
          placeholder="Seleccione una imagen para subir"
          drop-placeholder="Arrastre una imagen para subir"
        ></b-form-file>
        <div
          class="mt-3"
        >Selected file: {{ imagesArray[3] ? imagesArray[3].name : '' }}</div>
        <b-form-file
          accept="image/*"
          v-model="imagesArray[4]"
          :state="Boolean(imagesArray[4])"
          placeholder="Seleccione una imagen para subir"
          drop-placeholder="Arrastre una imagen para subir"
        ></b-form-file>
        <div
          class="mt-3"
        >Selected file: {{ imagesArray[4] ? imagesArray[4].name : '' }}</div>
      </div>
      <b-button size="sm" class="my-2 my-sm-3" type="submit" variant="dark">Registrar</b-button>
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
      imagesArray: [],
    };
  },
  methods: {
    getArray() {
      var archivos=[];
      this.dataRegisterProperty.files=[];
      this.imagesArray.forEach((archivo,index) => {
          var reader = new FileReader();
          reader.onloadend = () => {
            //this.$set(this.dataRegisterProperty.files,index,reader.result);
            archivos.push(reader.result);
          };
          reader.readAsDataURL(archivo);
          console.log('pasada ');
          console.log(this.dataRegisterProperty.files);
          console.log(archivos);
      });
      console.log(this.imagesArray);
      this.dataRegisterProperty.files=archivos;
      console.log(this.dataRegisterProperty.files);
    },
    registerProperty() {
      this.getArray();
      axios.post("http://localhost:3000/properties/publish", {
        data: this.dataRegisterProperty,
      });
    }
  }
};
</script>

