<template>
  <b-container class="editProperty"> 
      <div class="titulo"><h1>Editar Propiedad</h1><h3> '{{this.property.name}}'</h3></div><br>
      <form @submit.prevent="propertyEdition" v-if="imagesLoaded">
        <b-form-group v-if="!booked" id="name" :label="'Nombre'" label-for="input-7">
          <b-form-input type="input-7" v-model="property.name" required/>
        </b-form-group>
        <b-form-group id="descripcion" label="Descripcion" label-for="input-1">
            <b-form-input id="input-1" v-model="property.description" required></b-form-input>
        </b-form-group>
        <b-form-group v-if="!booked" id="address" :label="'Dirección'" label-for="input-8">
          <b-form-input type="input-8"  v-model="property.address" required/>
        </b-form-group>
        <b-form-group v-if="!booked" id="price" :label="'Precio base'" label-for="input-9"> 
          <b-form-input type="input-9" v-model="property.base_price" required/>
        </b-form-group>
        <b-form-group v-if="!booked" id="country" :label="'País'" label-for="input-10">  
          <b-form-select type="input-10" v-model="property.country" :options="countries" @change="getProvinces(property.country)" required/>
        </b-form-group>
        <b-form-group v-if="!booked" id="province" :label="'Provincia'" label-for="input-11"> 
          <b-form-select type="input-11" v-model="property.province" :options="provinces" @change="getLocalities(property.province, property.country)" required/>
        </b-form-group>
        <b-form-group v-if="!booked" id="locality" :label="'Localidad'" label-for="input-12">  
          <b-form-select type="input-12" v-model="property.locality" :options="localities" required/>
        </b-form-group>
        <b-form-group id="imagen1" :label="'Imagen N°1'" label-for="input-2">
          <b-form-input id="input-2" v-model="img[0]" required></b-form-input>
        </b-form-group>
        <b-form-group id="imagen2" :label="'Imagen N°2'" label-for="input-3">
          <b-form-input id="input-3" v-model="img[1]"></b-form-input>
        </b-form-group>
        <b-form-group id="imagen3" :label="'Imagen N°3'" label-for="input-4">
          <b-form-input id="input-4" v-model="img[2]"></b-form-input>
        </b-form-group>
        <b-form-group id="imagen4" :label="'Imagen N°4'" label-for="input-5">
          <b-form-input id="input-5" v-model="img[3]"></b-form-input>
        </b-form-group>
        <b-form-group id="imagen5" :label="'Imagen N°5'" label-for="input-6">
          <b-form-input id="input-6" v-model="img[4]"></b-form-input>
        </b-form-group>
        <b-row align-h="between">
            <b-button :to="'/details/'+this.$route.params.id+'/no/no'" class="blueButton" style="float:left;"><font-awesome-icon icon="list-alt"></font-awesome-icon> Volver a la Propiedad</b-button>
            <b-button type="submit" class="blueButton" style="float:right;"><font-awesome-icon icon="home"></font-awesome-icon> Editar</b-button> 
        </b-row>
      </form>
  </b-container>
</template>

<script>
import Vuex from "vuex";
import axios from "axios";

export default {
  name: "editProperty2",
  data() {
    return {
      property: {},
      img: new Array(5), 
      images: {},
      imagesLoaded: false,
      booked: false,
      countries: [],
      provinces: [],
      localities: []
    }
  },
  created() {
    
    axios.get('//localhost:3000/properties/'+this.$route.params.id)
        .then(response => {
            this.property=response.data[0];
            this.getCountries()
            this.getProvinces(response.data[0].country)
            this.getLocalities(response.data[0].province,response.data[0].country)
        })
    axios.get('//localhost:3000/images/'+this.$route.params.id)
        .then(response => {
            this.images=response.data;
            for (var i=0; i<this.images.length;i++){
                this.img[i]= this.images[i].image
            }
            this.img.fill(null,this.images.length,this.img.length);
            this.imagesLoaded=true;
        })

      axios.get('//localhost:3000/properties/'+this.$route.params.id+'/bookings')
      .then(response => {
            this.booked=response.data.data;
        })
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
    getLocalities(province, country){
      axios.get("http://localhost:3000/localities/"+province+"/"+country)
          .then(response => {
            this.localities=[];
            response.data.forEach(locality => {
              this.localities.push(locality.name);
            })
          })
          .catch(error => {
            console.log(error);
          });
    },
    propertyEdition() { 
      if(confirm('¿Está seguro que desea editar esta propiedad?')){
        axios
            .post("http://localhost:3000/properties/" + this.property.id + "/edit", {
            data: {
                property: this.property,
                files: this.img,    
            } 
            })
            .then(response => {
              this.$bvToast.toast('La propiedad se editó correctamente',{
                title: 'Operación exitosa',
                variant: 'success',
                autoHideDelay: 5000,
                toaster: 'b-toaster-bottom-right',
              })
            })
            .catch(error => {
              this.$bvToast.toast('Ya existe una propiedad con ese nombre en esa localidad y provincia.',{
                title: 'Operación fallida',
                variant: 'danger',
                autoHideDelay: 5000,
                toaster: 'b-toaster-bottom-right',
              })
            }); 
            
      }
    }
  }  
};
</script>
