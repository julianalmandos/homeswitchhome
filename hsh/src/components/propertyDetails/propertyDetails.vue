<template>
  <div class="container">
    <!--<b-button v-if="isAdmin" v-on:click="chargeImages" v-b-modal.editPropertyModal block class="blueButton">Editar Propiedad</b-button>--> 
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
        <div class="profile">
          <h3 class="titulo">{{this.property.name}}</h3> 
          <b-col class="mt-5">
            <p class="text"><strong>Descripción: </strong>{{this.property.description}}</p>
            <p class="text"><strong>Ubicación: </strong>{{this.property.address}}</p>
            <p class="text"><strong>Localidad: </strong>{{this.property.locality}}</p>
            <p class="text"><strong>Provincia: </strong>{{this.property.province}}</p>
            <p class="text"><strong>País: </strong>{{this.property.country}}</p>
            <p class="text"><strong>Precio Base: </strong>${{this.property.base_price}}</p>
            <b-button v-if="isAdmin" :to="{ name: 'edit', params: { id: this.$route.params.id }}" block class="blueButton">Editar Propiedad</b-button>
          </b-col>
        </div>
      </b-col>
    </b-row>
    <br>
    <b-card-group deck>
      <div v-for="(week, index) of this.weeks" :key="index" >
        <div class="mb-3">
          <weekCard :week="week" @edited="reloadWeeks" @placingBid="openPlaceABidModal" @openingHotSale="openHotSaleModal"></weekCard>
        </div>
      </div>
    </b-card-group>
    <placeABid v-if="showPlaceABidModal" :week="actualWeek" @placed="reloadWeeks"/>
    <openHotSale v-if="showOpenHotSaleModal" :week="actualWeek" @placed="reloadWeeks"/>
  </div>
</template>

<script>
import Vuex from 'vuex';
import axios from 'axios';
import weekCard from "@/components/weekCard/weekCard.vue";
import placeABid from '@/components/placeABid/placeABid.vue';
import openHotSale from '@/components/openHotSale/openHotSale.vue';

    export default {
      name: 'propertyDetails',
      components: {
        weekCard,
        placeABid,
        openHotSale,
      },
      data() {
        return{
          property: {},
          weeks: {}, 
          images: {},
          actualWeek: {},
          showPlaceABidModal: false,
          showOpenHotSaleModal:false,
          description: '',
          img: new Array(5),
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
        chargeImages(){
          for (var i=0; i<this.images.length;i++){
            this.img[i]= this.images[i].image
          }
          this.description= this.property.description;
        },
        togglePlaceABidModal() {
          this.showPlaceABidModal=true;
        },
        async openPlaceABidModal(week) {
          this.actualWeek=week;
          await this.togglePlaceABidModal();
          this.$bvModal.show('placeABidModal');
        },
        toggleOpenHotSaleModal() {
          this.showOpenHotSaleModal=true;
        },
        async openHotSaleModal(week) {
          this.actualWeek=week;
          await this.toggleOpenHotSaleModal();
          this.$bvModal.show('openHotSaleModal');
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
              console.log('recarga semanas');
              console.log(this.weeks);
              this.weeks = response.data; 
            })
            .catch(error => {
              console.log(error);
            });
        },
      },
    }    
</script>
<style>
  .profile {
    background-color: rgb(242,242,242);
    border-radius:10px;
    height: 400px;
    
  }
  .title {
    color:black;
  }
  .text {
    color:black;
  }
</style>


