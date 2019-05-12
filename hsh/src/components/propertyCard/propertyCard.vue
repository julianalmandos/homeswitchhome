<template>
  <div class="property-card">
    <b-button href = "#" variant = "link" to="/detalle">
      <b-card
        no-body
        style="max-width: 15rem;margin-bottom:1.25rem"
        img-src="https://i.blogs.es/8e8f64/lo-de-que-comprar-una-casa-es-la-mejor-inversion-hay-generaciones-que-ya-no-lo-ven-ni-de-lejos---1/450_1000.jpg"
        img-alt="Image"
        img-top
      >
        <h7
          slot="header"
          class="d-inline-block text-truncate"
          style="max-width: 200px;"
        >{{ properties[index].name }}</h7>
        <b-card-body>
          <b-card-sub-title
            class="mb-2 d-inline-block text-truncate"
            style="max-width: 200px;"
          >Ubicación : {{ properties[index].address }}</b-card-sub-title>
        </b-card-body>
      </b-card>
    </b-button>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "propertyCard",
  props: ["index"],
  computed: {
    ...mapState(["properties"])
  }
};
</script>

