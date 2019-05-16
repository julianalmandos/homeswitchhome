<template>
  <div class="list-of-properties">
    <div class="container">
      <b-card-group deck>
        <div v-for="property of properties" :key="property.id">
          <div class="">
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
      properties: {},
    }
  },
  beforeCreate(){
    axios
      .get("http://localhost:3000/properties")
      .then(response => {
        this.properties=response.data;
        console.log(response.data);
      })
      .catch(error => {
        console.log(error);
      });
  },
};
</script>


