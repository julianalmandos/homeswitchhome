<template>
  <div class="property-card"> 
  
  <b-card
    no-body
    style="max-width: 20rem;"
    img-src="https://i.blogs.es/8e8f64/lo-de-que-comprar-una-casa-es-la-mejor-inversion-hay-generaciones-que-ya-no-lo-ven-ni-de-lejos---1/450_1000.jpg"
    img-alt="Image"
    img-top
  >
    <h4 slot="header">Mi hotel</h4>

    <b-card-body> 
      <b-card-sub-title class="mb-2">Ubicación: 172 n° 3750</b-card-sub-title>
    </b-card-body>
  </b-card>
  </div>
</template>

<script>
  export default {
    name: 'PropertyCard',
  }
</script>

