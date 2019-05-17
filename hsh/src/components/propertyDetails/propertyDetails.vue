<template>
  <div class="container">
    <editProperty :property="this.property" @edited="reloadProperty"/>
    <b-button v-if="isAdmin" v-b-modal.editPropertyModal block variant="outline-primary">Editar Propiedad</b-button> 
    <b-row>
      <b-col>
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
      </b-col>
      <b-col>
        <div>
          <h1>{{this.property.name}}</h1>
          <p>Descripción: {{this.property.description}}</p>
          <p>Ubicación: {{this.property.address}}</p>
          <p>Precio base: {{this.property.base_price}}</p>
        </div>
      </b-col>
    </b-row>
    <b-card-group deck>
      <div v-for="(week, index) of this.weeks" :key="index" >
        <div class="">
          <weekCard :week="week" @edited="reloadWeeks"></weekCard>
        </div>
      </div>
    </b-card-group>
  </div>
</template>

<script>
import Vuex from 'vuex';
import axios from 'axios';
import weekCard from "@/components/weekCard/weekCard.vue";
import editProperty from "@/components/editProperty/editProperty.vue";

    export default {
      name: 'propertyDetails',
      components: {
        weekCard,
        editProperty
      },
      data() {
        return{
          property: {},
          weeks: {}, 
        }
      },
      computed: {
        isAdmin() {
          return (this.$store.state.user!=null && this.$store.state.user.role==2);
        },
      },
      beforeCreate(){
        axios.get("http://localhost:3000/properties/"+ this.$route.params.id)
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
      },
      updated(){
        /*  
        axios.get("http://localhost:3000/properties/"+ this.$route.params.id)
          .then(response => {
            this.property = response.data[0];
          })
          .catch(error => {
            console.log(error);
          });*/ 
      },
      methods: {
        reloadProperty() {
          axios.get("http://localhost:3000/properties/"+ this.$route.params.id)
            .then(response => {
              this.property = response.data[0];
            })
            .catch(error => {
              console.log(error);
            });
        },
        reloadWeeks() {
          axios.get("http://localhost:3000/weeks/"+ this.$route.params.id)
            .then(response => {
              this.weeks = response.data; 
            })
            .catch(error => {
              console.log(error);
            });
        },
      },
    }    
</script>


