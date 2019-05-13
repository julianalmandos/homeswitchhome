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
      <b-card-group deck>
        <div v-for= "week of weeks" :key="week.id">
          <b-card border-variant="light" header="Semana 15.07.19 - 22.07.19" class="text-center">
            <b-card-text>
              <b-button block variant="outline-primary">Abrir subasta</b-button>
             <b-button block variant="outline-primary">Pujar</b-button>
           </b-card-text>
          </b-card>
        </div>
    </b-card-group>
</div>
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
          weeks:{},
          
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
        axios.get("http://localhost:3000/semanas/"+ this.$route.params.id)
          .then(response => {
            this.weeks = response.data[0];
            console.log(response.data);
          })
          .catch(error => {
            console.log(error);
          });
      }
    }    
</script>


