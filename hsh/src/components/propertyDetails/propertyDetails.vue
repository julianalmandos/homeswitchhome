<template>
  <div class="container">
    <b-button block variant="outline-primary">Editar Propiedad</b-button>
    <h1>{{property.name}}</h1>
    <div class="center-block">
      <b-carousel
        id="carousel-fade"
        fade
        img-width="600px"
        img-height="480px"
        class="center-block"
      >
        <b-carousel-slide
          img-src="https://i.blogs.es/8e8f64/lo-de-que-comprar-una-casa-es-la-mejor-inversion-hay-generaciones-que-ya-no-lo-ven-ni-de-lejos---1/450_1000.jpg" style="width:600px;height:410px;"
        ></b-carousel-slide>
        <b-carousel-slide
          img-src="https://www.alonsorodriguez.org/images/articles/comprar-casa-sin-contratiempos.jpg" style="width:600px;height:410px;"
        ></b-carousel-slide>
      </b-carousel>
    </div>
    <div>
      <p>Descripción: {{property.description}}</p>
      <p>Ubicación: {{property.address}}</p>
      <p>Precio base: {{property.base_price}}</p>
    </div>
    <b-card-group deck>
      <div v-for="(week, index) of weeks" :key="index">
        <div class="">
          <weekCard :week="week[index]"></weekCard>
        </div>
      </div>
    </b-card-group>
  </div>
</template>

<script>
import Vuex from 'vuex';
import axios from 'axios';
import { mapState } from "vuex";
import weekCard from "@/components/weekCard/weekCard.vue";

    export default {
      name: 'propertyDetails',
      data() {
        return{
          property: {},
          weeks:{},
          
        }
      },
      beforeCreate(){
        axios.get("http://localhost:3000/propiedades/"+ this.$route.params.id)
          .then(response => {
            this.property = response.data[0];
          })
          .catch(error => {
            console.log(error);
          });
        axios.get("http://localhost:3000/weeks/"+ this.$route.params.id)
          .then(response => {
            this.weeks = response.data;
          })
          .catch(error => {
            console.log(error);
          });
      }
    }    
</script>


