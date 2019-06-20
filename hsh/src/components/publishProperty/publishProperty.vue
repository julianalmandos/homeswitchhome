<template>
  <b-container class="publish-property">
    <h1 class="titulo">Publicar propiedad</h1><br>
    <form @submit.prevent="registerProperty">
      <b-form-group>
        <label for="property-name">Ingrese el nombre de la propiedad</label>
        <b-form-input type="name" id="name" v-model="dataRegisterProperty.name" required/>
      </b-form-group>

      <b-form-group>
        <label for="property-description">Ingrese la descripción de la propiedad</label>
        <b-form-input
          type="description"
          id="description"
          v-model="dataRegisterProperty.description"
          required
        />
      </b-form-group>

      <b-form-group>
        <label for="property-address">Ingrese la dirección de la propiedad</label>
        <b-form-input type="text" id="property-address" v-model="dataRegisterProperty.address" required/>
      </b-form-group>

      <b-form-group>
        <label for="property-base-price">Ingrese el precio base de la propiedad</label>
        <b-form-input type="text" id="property-base_price" v-model="dataRegisterProperty.base_price" required/>
      </b-form-group>

      <b-form-group>
        <label for="property-country">Ingrese el país de la propiedad</label>
        <b-form-input type="text" id="property-country" v-model="dataRegisterProperty.country" required/>
      </b-form-group>

      <b-form-group>
        <label for="property-province">Ingrese la provincia de la propiedad</label>
        <b-form-input type="text" id="property-province" v-model="dataRegisterProperty.province" required/>
      </b-form-group>

      <b-form-group>
        <label for="property-locality">Ingrese la localidad de la propiedad</label>
        <b-form-input type="text" id="property-locality" v-model="dataRegisterProperty.locality" required/>
      </b-form-group> 

      <b-form-group v-for="(image, index) of this.imagesArray" :key="index">
        <label for="property-files[index]">Ingrese el link de la imagen</label>
        <b-form-input
          v-if="index==0"
          type="text"
          id="files[index]"
          v-model="dataRegisterProperty.files[index]" 
          required
        />
        <b-form-input 
          v-else
          type="text"
          id="files[index]"
          v-model="dataRegisterProperty.files[index]"
        />
      </b-form-group>

      <b-row align-h="between">
        <b-button to="/panel/properties" class="my-2 my-sm-3 blueButton"><font-awesome-icon icon="list-alt"></font-awesome-icon> Ver propiedades </b-button>
        <b-button class="my-2 my-sm-3 blueButton" type="submit"><font-awesome-icon icon="home"></font-awesome-icon> Publicar propiedad</b-button>
      </b-row>
    </form>
  </b-container>
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
      axios.post("http://localhost:3000/properties", {
        data: this.dataRegisterProperty
      })
      .then(response => {
        this.emptyForm();
        this.$bvToast.toast('Propiedad agregada con éxito!', {
          title: 'Operación exitosa',
          variant: 'success',
          autoHideDelay: 5000,
          toaster: 'b-toaster-bottom-right',
        });
      })
      .catch(response => {
        this.$bvToast.toast('Ya existe una propiedad con ese nombre en esa localidad y provincia.', {
          title: 'Operación fallida',
          variant: 'danger',
          autoHideDelay: 5000,
          toaster: 'b-toaster-bottom-right',
        });
      })
    },
    emptyForm() {
      this.dataRegisterProperty.name='';
      this.dataRegisterProperty.description='';
      this.dataRegisterProperty.address='';
      this.dataRegisterProperty.base_price='';
      this.dataRegisterProperty.country='';
      this.dataRegisterProperty.province='';
      this.dataRegisterProperty.locality='';
      this.dataRegisterProperty.files=[];
    }
  }
};
</script>

