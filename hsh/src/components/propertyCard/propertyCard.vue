<template>
  <div class="property-card">
    <b-card
      no-body
      class="tarjeta"
      style="max-width: 15rem;margin-bottom:1.25rem"
      @click="viewPropertyDetails"
    >
    <b-card-img :src="this.image.image" alt="Image" top height="150"></b-card-img>
      <h6
        slot="header"
        class="d-inline-block text-truncate"
        style="max-width: 200px;"
      >{{ property.name }}</h6>
      <b-card-body>
        <b-card-sub-title
          class="mb-2 d-inline-block text-truncate"
          style="max-width: 200px;"
        >Ubicación: {{ property.locality }}, {{property.province}}, {{property.country}}</b-card-sub-title>
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
      image: {},
    }
  },
  methods: {
    viewPropertyDetails() {
      this.$router.push('/details/'+this.property.id);
    }
  },
  created(){
    axios.get("http://localhost:3000/images/"+ this.property.id)
      .then(response => {
        this.image = response.data[0]; 
        console.log(response.data)
      })
      .catch(error => {
        console.log(error);
      }); 
  }
};
</script>

<style scoped>
  .tarjeta:hover {
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    cursor: pointer;
  }
</style>


