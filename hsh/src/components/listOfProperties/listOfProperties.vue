<template>
  <div class="list-of-properties">
    <div class="container">
      <h1 class="titulo">Propiedades</h1>
      <br>
      <h3>
        Selecciona una propiedad, elegí una semana y pujá.
        <br>¡Nunca había sido tan sencillo!
      </h3>
      <br>
      <h5 v-if="!properties.length">No hay propiedades disponibles.</h5>
      <b-card-group v-else deck>
        <div v-for="property of properties" :key="property.id">
          <div class>
            <propertyCard :property="property"></propertyCard>
          </div>
        </div>
      </b-card-group>
    </div>
  </div>
</template>

<script>
import Vuex from "vuex";
import axios from "axios";
import propertyCard from "@/components/propertyCard/propertyCard.vue";

export default {
  name: "listOfProperties",
  components: {
    propertyCard
  },
  data() {
    return {
      properties: []
    };
  },
  beforeCreate() {
    const isUser = this.$store.state.user != null;
    let response;
    if (isUser) {
      response = axios.get("http://localhost:3000/properties");
    } else {
      response = axios.get(
        "http://localhost:3000/properties/random?quantity=5"
      );
    }
    response
      .then(response => {
        this.properties = response.data;
      })
      .catch(error => {
        console.log(error);
      });
  }
};
</script>

<style>
.titulo {
  background-color: rgba(0, 161, 225, 0.5);
  color: #f2f2f2;
  box-shadow: 0px 6px 3px -4px rgba(0, 0, 0, 0.75);
  text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
  border-bottom-left-radius: 50% 40%;
  border-bottom-right-radius: 50% 40%;
}
</style>



