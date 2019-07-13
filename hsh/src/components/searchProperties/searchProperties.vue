<template>
  <div class="list-of-properties">
    <div class="container">
      <h1 class="titulo">Propiedades</h1>
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
    console.log(this.$route.params.locality)
    if(this.$route.params.locality==''){
      console.log("localidad vacia")
       axios
          .post("http://localhost:3000/searchRange", {
            data: {
              startDate: this.$route.params.startDate,
              finishDate: this.$route.params.finishDate
            }
          })
      .then(response => {
        this.properties = response.data;
        console.log(response.data);
      })
      .catch(error => {
        console.log(error);
      });
  }else{
    if (this.$route.params.startDate==''){
      console.log("fechas vacias")
       axios
          .post("http://localhost:3000/properties/searchLocality", {
            data: {
              locality: this.$route.params.locality,
            }
          })
      .then(response => {
        this.properties = response.data;
        console.log(response.data);
      })
      .catch(error => {
        console.log(error);
      });
  }else{
    console.log("todo")
     axios
          .post("http://localhost:3000/properties/searchAll", {
            data: {
              locality: this.$route.params.locality,
              startDate: this.$route.params.startDate,
              finishDate: this.$route.params.finishDate
            }
          })
      .then(response => {
        this.properties = response.data;
        console.log(response.data);
      })
      .catch(error => {
        console.log(error);
      });
  }
  }
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

