<template>
  <b-container class="editProperty"> 
      <div class="titulo"><h1>Editar Propiedad</h1><h3> '{{this.property.name}}'</h3></div><br>
      <form @submit.prevent="propertyEdition" v-if="imagesLoaded">
        <b-form-group id="descripcion" label="Descripcion" label-for="input-1">
            <b-form-input id="input-1" v-model="property.description" required></b-form-input>
        </b-form-group>
        
        <b-form-group id="descripcion" :label="'Imagen N°1'" label-for="input-1">
          <b-form-input id="input-1" v-model="img[0]" required></b-form-input>
        </b-form-group>
        <b-form-group id="descripcion" :label="'Imagen N°2'" label-for="input-1">
          <b-form-input id="input-1" v-model="img[1]"></b-form-input>
        </b-form-group>
        <b-form-group id="descripcion" :label="'Imagen N°3'" label-for="input-1">
          <b-form-input id="input-1" v-model="img[2]"></b-form-input>
        </b-form-group>
        <b-form-group id="descripcion" :label="'Imagen N°4'" label-for="input-1">
          <b-form-input id="input-1" v-model="img[3]"></b-form-input>
        </b-form-group>
        <b-form-group id="descripcion" :label="'Imagen N°5'" label-for="input-1">
          <b-form-input id="input-1" v-model="img[4]"></b-form-input>
        </b-form-group>
        <b-row align-h="between">
            <b-button :to="{ name: 'details', params: { id: this.$route.params.id }}" class="blueButton" style="float:left;"><font-awesome-icon icon="list-alt"></font-awesome-icon> Volver a la Propiedad</b-button>
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
    }
  },
  created() {
    axios.get('//localhost:3000/properties/'+this.$route.params.id)
        .then(response => {
            this.property=response.data[0];
        })
    axios.get('//localhost:3000/images/'+this.$route.params.id)
        .then(response => {
            this.images=response.data;
            for (var i=0; i<this.images.length;i++){
                this.img[i]= this.images[i].image
            }
            this.img.fill(null,this.images.length,this.img.length);
            console.log(this.img);
            this.imagesLoaded=true;
        })
  },
  methods: {
    propertyEdition() { 
      console.log("entre a esto")
      console.log(this.property.description)
      console.log(this.img)
      if(confirm('¿Está seguro que desea editar esta propiedad?')){
        axios
            .post("http://localhost:3000/properties/" + this.property.id + "/edit", {
            data: {
                description: this.property.description,
                files: this.img,    
            } 
            })
            .then(response => {
                        
            })
            .catch(error => {
            console.log(error);
            }); 
            this.$bvToast.toast('La propiedad se editó correctamente',{
                title: 'Operación exitosa',
                variant: 'success',
                autoHideDelay: 5000,
                toaster: 'b-toaster-bottom-right',
            })
      }
    }
  }  
};
</script>
