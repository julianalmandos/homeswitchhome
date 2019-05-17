<template>
  <div class="property-card">
    <b-card
      no-body
      class="tarjeta"
      style="max-width: 15rem;margin-bottom:1.25rem"
      img-src="https://i.blogs.es/8e8f64/lo-de-que-comprar-una-casa-es-la-mejor-inversion-hay-generaciones-que-ya-no-lo-ven-ni-de-lejos---1/450_1000.jpg"
      img-alt="Image"
      img-top
      @click="viewPropertyDetails"
    >
      <h6
        slot="header"
        class="d-inline-block text-truncate"
        style="max-width: 200px;"
      >{{ property.name }}</h6>
      <b-card-body>
        <b-card-sub-title
          class="mb-2 d-inline-block text-truncate"
          style="max-width: 200px;"
        >Ubicación : {{ property.address }}</b-card-sub-title>
      </b-card-body>
    </b-card>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: "propertyCard",
  props: ["property"],
  data(){
    return {
    }
  },
  methods: {
    viewPropertyDetails() {
      this.$router.push('/details/'+this.property.id);
    }
  }
};
</script>

<style scoped>
  .tarjeta:hover {
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    cursor: pointer;
  }
</style>


