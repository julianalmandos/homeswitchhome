<template>
  <div class="list-of-properties">
    <div class="row">
      <div v-for="(property, index) of properties" :key="property.id">
        <div class="col-6 col-sm-9"> 
          <PropertyCard :index="index"></PropertyCard>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";
import PropertyCard from "@/components/propertyCard/PropertyCard.vue";

export default {
  name: "listOfProperties",
  components: {
    PropertyCard
  },
  computed: {
    ...mapState(["properties"])
  }
};
</script>


