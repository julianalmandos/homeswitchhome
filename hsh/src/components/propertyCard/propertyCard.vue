<template>
  <div class="property-card">
    <router-link v-bind:to= "'/details/' + property.id ">
      <b-card
        no-body
        style="max-width: 15rem;margin-bottom:1.25rem"
        img-src="https://i.blogs.es/8e8f64/lo-de-que-comprar-una-casa-es-la-mejor-inversion-hay-generaciones-que-ya-no-lo-ven-ni-de-lejos---1/450_1000.jpg"
        img-alt="Image"
        img-top
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
    </router-link>
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
};
</script>

