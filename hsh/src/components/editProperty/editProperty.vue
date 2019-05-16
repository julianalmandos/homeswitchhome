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
    </b-modal>
  </div>
</template>

<script>
import Vuex from "vuex";
import axios from "axios";

export default {
  name: "editProperty",
  props: ["property"],
  data() {
    return {
      description: '',
    };
  },
  methods: {
    propertyEdition() { 
      axios
        .post("http://localhost:3000/properties/" + this.property.id + "/edit", {
          data: {
            description: this.description,
          } 
        })
        .then(response => {
          console.log("Propiedad editada correctamente");
          this.$emit('edited');
        })
        .catch(error => {
          console.log(error);
        });      
    }
  }
};
</script>
