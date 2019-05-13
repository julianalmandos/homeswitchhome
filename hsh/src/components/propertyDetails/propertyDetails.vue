<template>
  <div class="container">
    <h1>{{property.name}}</h1>
    <b-carousel
      id="carousel-fade"
      fade
      img-width="600px"
      img-height="480px"
    >

    <b-carousel-slide
      img-src="https://i.blogs.es/8e8f64/lo-de-que-comprar-una-casa-es-la-mejor-inversion-hay-generaciones-que-ya-no-lo-ven-ni-de-lejos---1/450_1000.jpg" style="width:600px;height:410px;"
    ></b-carousel-slide>
    <b-carousel-slide
      img-src="https://www.alonsorodriguez.org/images/articles/comprar-casa-sin-contratiempos.jpg" style="width:600px;height:410px;"
    ></b-carousel-slide>
  </b-carousel>
  <p>Descripción: {{property.description}}</p>
  <p>Ubicación: {{property.address}}</p>
  <p>Precio base: {{property.base_price}}</p>

  </div>
</template>

<script>
import Vuex from 'vuex'
import axios from 'axios'
    export default {
      name: 'propertyDetails',
      data() {
        return{
          property: {},
          
        }
      },
      beforeCreate(){
        axios.get("http://localhost:3000/propiedades/"+ this.$route.params.id)
          .then(response => {
            this.property = response.data[0];
            console.log(response.data);
          })
          .catch(error => {
            console.log(error);
          });
      }
    }    
</script>


