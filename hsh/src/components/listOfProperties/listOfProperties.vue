<template>
  <div class="list-of-properties">
    <div class="container">
      <div class="row">
        <div v-for="(property, index) of properties" :key="property.id">
          <div class="col-sm-12 col-md-4 col-lg-3 d-flex p-2">
            <PropertyCard :index="index"></PropertyCard>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Vuex from "vuex";
import { mapState } from "vuex";
import axios from "axios";
import PropertyCard from "@/components/propertyCard/PropertyCard.vue";

export default {
  name: "listOfProperties",
  components: {
    PropertyCard
  },
  computed: {
    ...mapState(["properties"])
  },
  methods: {
    ...Vuex.mapActions(["listProperties"]),
    getlistProperties() {
      axios
        .get("http://localhost:3000/propiedades")
        .then(response => {
          this.listProperties(response.data);
        })
        .catch(error => {
          console.log(error);
        });
    }
  }
};
</script>


