<template>
  <div class="property-card">
    <b-card
      no-body
      v-bind:class="getClass()"
      style="max-width: 15rem;margin-bottom:1.25rem"
      @click="viewPropertyDetails"
    >
      <b-card-img :src="this.image.image" alt="Image" top height="150"></b-card-img>
      <h6
        slot="header"
        class="d-inline-block text-truncate"
        style="max-width: 200px;"
      >{{ property.name }}</h6>
      <b-card-body v-if="isUser">
        <b-card-sub-title
          class="mb-2 d-inline-block text-truncate"
          style="max-width: 200px;"
        >Ubicación: {{ property.locality }}, {{property.province}}, {{property.country}}</b-card-sub-title>
      </b-card-body>
    </b-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "propertyCard",
  props: ["property"],
  data() {
    return {
      image: {}
    };
  },
  computed: {
    isUser() {
      return this.$store.state.user != null;
    }
  },
  methods: {
    isLoggedUser() {
      return this.$store.state.user != null;
    },
    viewPropertyDetails() {
      if (this.isLoggedUser()) {
        if(this.$route.params.startDate !== undefined){
          this.$router.push("/details/" + this.property.id+"/"+this.$route.params.startDate+"/"+this.$route.params.finishDate);
        }else{
          this.$router.push("/details/" + this.property.id+"/no/no");
        }
      }
    },
    getClass() {
      return this.isLoggedUser() ? "tarjeta" : "";
    }
  },
  created() {
    axios
      .get("http://localhost:3000/images/" + this.property.id)
      .then(response => {
        this.image = response.data[0];
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


