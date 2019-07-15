<template>
  <div class="location-options">
    <b-container>
      <h1 class="titulo">Agregar Ubicación</h1>
      <br>
      <b-card-group deck>
        <b-card class="tarjeta text-center" v-b-modal.country bg-variant="light">
          <font-awesome-icon class="fa-5x" icon="map"></font-awesome-icon>
          <b-card-text style="font-size:25px">Agregar país</b-card-text>
        </b-card>
        <b-card class="tarjeta text-center" v-b-modal.province bg-variant="light">
          <font-awesome-icon class="fa-5x" icon="map-marker-alt"></font-awesome-icon>
          <b-card-text style="font-size:25px">Agregar provincia</b-card-text>
        </b-card>
        <b-card class="tarjeta text-center" v-b-modal.locality bg-variant="light">
          <font-awesome-icon class="fa-5x" icon="map-signs"></font-awesome-icon>
          <b-card-text style="font-size:25px">Agregar localidad</b-card-text>
        </b-card>
      </b-card-group> 
      <b-modal id="country" ref= "my-modal" hide-footer title="Agregar país" @hide="resetModal" @open="resetModal">
        <b-alert class="mt-sm-3" v-model="showErrorAdding" variant="danger" dismissible><font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> El país ya existe.</b-alert>
        <b-alert class="mt-sm-3" v-model="showCorrectAdding" variant="success" dismissible><font-awesome-icon icon="check"></font-awesome-icon> El país fue agregado correctamente.</b-alert>
        <b-alert class="mt-sm-3" v-model="showErrorEmptyFields" variant="danger" dismissible><font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> Por favor, complete todos los campos.</b-alert>
        <b-form-group id="country" label="Ingrese un país:" label-for="input-1">
          <b-form-input id="input-1" v-model="country" required/>
        </b-form-group>
        <b-button class="blueButton" type="submit" @click= addCountry >Agregar</b-button>
      </b-modal>
      <b-modal id="province" ref= "my-modal" hide-footer title="Agregar provincia" @hide="resetModal" @open="resetModal">
        <b-alert class="mt-sm-3" v-model="showErrorAdding" variant="danger" dismissible><font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> La provincia ya existe.</b-alert>
        <b-alert class="mt-sm-3" v-model="showCorrectAdding" variant="success" dismissible><font-awesome-icon icon="check"></font-awesome-icon> La provincia fue agregada correctamente.</b-alert>
        <b-alert class="mt-sm-3" v-model="showErrorEmptyFields" variant="danger" dismissible><font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> Por favor, complete todos los campos.</b-alert>
        <b-form-group id="country" label="Ingrese un país:" label-for="input-1">
          <b-form-select id="input-1" v-model="country" :options="countries" required/>
        </b-form-group>
        <b-form-group id="province" label="Ingrese una provincia:" label-for="input-1">
          <b-form-input id="input-1" v-model="province" required/>
        </b-form-group>
        <b-button class="blueButton" type="submit" @click= addProvince>Agregar</b-button>
      </b-modal>
      <b-modal id="locality" ref= "my-modal" hide-footer title="Agregar localidad" @hide="resetModal" @open="resetModal">
        <b-alert class="mt-sm-3" v-model="showErrorAdding" variant="danger" dismissible><font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> La localidad ya existe.</b-alert>
        <b-alert class="mt-sm-3" v-model="showCorrectAdding" variant="success" dismissible><font-awesome-icon icon="check"></font-awesome-icon> La localidad fue agregada correctamente.</b-alert>
        <b-alert class="mt-sm-3" v-model="showErrorEmptyFields" variant="danger" dismissible><font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> Por favor, complete todos los campos.</b-alert>
        <b-form-group id="country" label="Ingrese un país:" label-for="input-1">
          <b-form-select id="input-1" v-model="country" @change="getProvinces(country)" :options="countries" required/>
        </b-form-group>
        <b-form-group id="country" label="Ingrese una provincia:" label-for="input-1">
          <b-form-select id="input-1" v-model="province" :options="provinces" required/>
        </b-form-group>
        <b-form-group id="province" label="Ingrese una localidad:" label-for="input-1">
          <b-form-input id="input-1" v-model="locality" required/>
        </b-form-group>
        <b-button class="blueButton" type="submit" @click= addLocality>Agregar</b-button>
      </b-modal>
    </b-container>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "locationOptions",
   data() {
    return {
      country: '',
      province: '',
      locality: '',
      showCorrectAdding: false,
      showErrorAdding: false,
      showErrorEmptyFields: false,
      countries: [],
      provinces: []
    }
  },
  created(){
    this.getCountries()
  },
  methods: {
    getCountries(){
      axios.get("http://localhost:3000/countries/")
          .then(response => {
            this.countries= [];
            response.data.forEach(country => {
              this.countries.push(country.name);
            })
          })
          .catch(error => {
            console.log(error);
          });
    
    },
    getProvinces(country){
      axios.get("http://localhost:3000/provinces/"+country)
          .then(response => {
            this.provinces=[];
            response.data.forEach(province => {
              this.provinces.push(province.name);
            })
          })
          .catch(error => {
            console.log(error);
          });
    },
    resetModal() {
      this.showCorrectAdding= false;
      this.showErrorAdding=false;
      this.showErrorEmptyFields=false;
      this.country='';
      this.province='';
      this.locality='';
      this.provinces= []
    },
    resetAlerts(){
      this.showCorrectAdding= false;
      this.showErrorAdding=false;
      this.showErrorEmptyFields=false;
    },
    addCountry(){
      this.resetAlerts(); 
      if (this.country!==''){
        axios.post("http://localhost:3000/country/", {
            data: { country: this.country }
          })
          .then(response => {
            this.showCorrectAdding=true;
            this.getCountries();
          })
          .catch(error => {
            this.showErrorAdding=true;
            console.log(error);
          });
      }else{
        this.showErrorEmptyFields=true;
      }
    },
    addProvince(){
      this.resetAlerts(); 
      if ((this.country!=='')&(this.province!=='')){
        axios.post("http://localhost:3000/province/", {
            data: { country: this.country, province: this.province }
          })
          .then(response => {
            this.showCorrectAdding=true;
          })
          .catch(error => {
            this.showErrorAdding=true;
            console.log(error);
          });
      }else{
        this.showErrorEmptyFields=true;
      }
    },
    addLocality(){
      this.resetAlerts(); 
      if ((this.country!=='')&(this.province!=='')&(this.locality!=='')){
        axios.post("http://localhost:3000/locality/", {
            data: { country:this.country, province: this.province, locality: this.locality }
          })
          .then(response => {
            this.showCorrectAdding=true;
          })
          .catch(error => {
            this.showErrorAdding=true;
            console.log(error);
          });
      }else{
        this.showErrorEmptyFields=true;
      }
    }
  }
}
</script>


<style scoped>

.tarjeta:hover {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
  cursor: pointer;
}
</style>