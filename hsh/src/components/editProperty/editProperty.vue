<template>
  <div class="editProperty">
    <b-button v-b-modal.modal-1>Launch demo modal</b-button>

    <b-modal id="editPropertyModal" :title="'Editar Propiedad N°'+this.property.id">
      <form @submit.stop.prevent="editProperty">
        <b-form-group id="descripcion" label="Descripcion" label-for="input-2">
        <b-form-input
          id="input-2"
          v-model="this.property.description"
          required
        ></b-form-input>
        <b-button type="submit" variant="dark">Editar!</b-button>
      </b-form-group>
      </form>
    </b-modal>
  </div>
</template>

<script>
import Vuex from "vuex";
import axios from "axios";

export default {
  name: "editProperty",
  props: [
    'property'
  ],
  data() {
    return {
    }
  },
  methods: {
    editProperty(){
      axios
        .post('//localhost:3000/propiedades/'+this.property.id+'/edit', {
          data: this.property,
        }).then(response => {
          console.log('Propiedad editada correctamente');
        }).catch(error => {
          console.log(error);
        })
    }   
  }
};
</script>
