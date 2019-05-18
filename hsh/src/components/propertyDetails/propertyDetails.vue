<template>
  <div class="container">
    <editProperty :property="this.property" @edited="reloadProperty"/>
    <b-button v-if="isAdmin" v-b-modal.editPropertyModal block variant="outline-primary">Editar Propiedad</b-button> 
    <br>
    <b-row>
      <b-col>
        <div class="center-block">
          <b-carousel
            id="carousel-fade"
            fade
            controls
            background="#ababab"
            img-width="200"
            img-height="100"
            class="center-block"
          >
          <div v-for="image of images" :key="image.id">
            <b-carousel-slide>
              <img
                slot="img"
                width="600"
                height="400"
                :src="image.image"
                alt="image slot"
              >
            </b-carousel-slide>
          </div>           
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
    <br>
    <b-card-group deck>
      <div v-for="(week, index) of this.weeks" :key="index" >
        <div class="mb-3">
          <weekCard :week="week" @edited="reloadWeeks" @placingBid="openPlaceABidModal"></weekCard>
        </div>
      </div>
    </b-card-group>
    <placeABid v-if="showPlaceABidModal" :week="actualWeek" @placed="reloadWeeks"/>
  </div>
</template>

<script>
import Vuex from 'vuex';
import axios from 'axios';
import weekCard from "@/components/weekCard/weekCard.vue";
import editProperty from "@/components/editProperty/editProperty.vue";
import placeABid from '@/components/placeABid/placeABid.vue';

    export default {
      name: 'propertyDetails',
      components: {
        weekCard,
        editProperty,
        placeABid
      },
      data() {
        return{
          property: {},
          weeks: {}, 
          images: {},
          actualWeek: {},
          showPlaceABidModal: false,
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
        axios.get("http://localhost:3000/images/"+ this.$route.params.id)
          .then(response => {
            this.images = response.data; 
            console.log(response.data)
          })
          .catch(error => {
            console.log(error);
          }); 
      },
      methods: {
        togglePlaceABidModal() {
          this.showPlaceABidModal=true;
        },
        async openPlaceABidModal(week) {
          this.actualWeek=week;
          await this.togglePlaceABidModal();
          this.$bvModal.show('placeABidModal');
        },
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


