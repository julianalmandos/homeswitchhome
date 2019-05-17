<template>
  <div class="editProperty">
    <b-modal
      id="editPropertyModal"
      :title="'Editar Propiedad N°'+property.id"
      ok-title="Editar"
      @ok="propertyEdition"
    >
      <b-form-group id="descripcion" label="Descripcion" label-for="input-1">
        <b-form-input id="input-1" v-model="description" required></b-form-input>
      </b-form-group>

      <b-card-group class="row" >
        <div v-for="file in files" :key="file.id">
       <b-card
          no-body
          style="max-width: 10rem;"
          :img-src="file"  
          img-top
        ></b-card> 
        <!--  <img :src="file" width="125" height="100"> -->
        </div>  
      </b-card-group> 

      <!-- 
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
      --> 
    </b-modal>
  </div>
</template>

<script>
import Vuex from "vuex";
import axios from "axios";

export default {
  name: "editProperty",
  props: ["property", "images"],
  data() {
    return {
      description: this.property.description,
      files: this.images
    };
    imagesArray: new Array(5);
  },
  beforeMount() { 
    console.log("hola");
    for(var i=this.images.length; i<5; i++){
      this.images[i]="https://lightwidget.com/widgets/empty-photo.jpg";
    }
  },
  methods: {
    propertyEdition() {
      axios
        .post(
          "http://localhost:3000/properties/" + this.property.id + "/edit",
          {
            data: {
              description: this.description,
              images: files
            }
          }
        )
        .then(response => {
          console.log("Propiedad editada correctamente");
          this.$emit("edited");
        })
        .catch(error => {
          console.log(error);
        });
    }
  }
};
</script>

<style>
  .card-img-top{
    width:125 ;
    height:100
  }
</style>

