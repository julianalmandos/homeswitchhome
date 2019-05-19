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
      <div v-for="index in 5" :key="index">
        <b-form-group id="descripcion" :label="'Imagen N°'+index" label-for="input-1">
          <b-form-input v-if="index==0" id="input-1" v-model="images[index-1]" required></b-form-input>
          <b-form-input v-else id="input-1" v-model="images[index-1]"></b-form-input>
        </b-form-group>
        
        </div> 
    </b-modal>
  </div>
</template>

<script>
import Vuex from "vuex";
import axios from "axios";

export default {
  name: "editProperty",
  props: ["property", "description", "images"],
  
  methods: {
    

    propertyEdition() { 
      console.log("entre a esto")
      console.log(this.description)
      console.log(this.images)
      axios
        .post("http://localhost:3000/properties/" + this.property.id + "/edit", {
          data: {
            description: this.description,
            files: this.images,
    
          } 
        })
        .then(response => {
          this.$emit('edited');
          
        })
        .catch(error => {
          console.log(error);
        }); 
    }
  }  
};
</script>
