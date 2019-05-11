<template>
  <div class="list-of-properties">
    <div class="container">
      <b-card-group deck>
        <div v-for="(property, index) of properties" :key="property.id">
          <div class="">
            <propertyCard :index="index"></propertyCard>
          </div>
        </div>
      </b-card-group>
    </div>
  </div>
</template>

<script>
import Vuex from "vuex";
import { mapState } from "vuex";
import axios from "axios";
import propertyCard from "@/components/propertyCard/propertyCard.vue";

export default {
  name: "listOfProperties",
  components: {
    propertyCard
  },
  computed: {
    ...mapState(["properties"])
  },
  beforeCreate(){
    axios
      .get("http://localhost:3000/propiedades")
      .then(response => {
        this.listProperties(response.data);
      })
      .catch(error => {
        console.log(error);
      });
  },
  methods: {
    ...Vuex.mapActions(["listProperties"]),
  }
};
</script>


