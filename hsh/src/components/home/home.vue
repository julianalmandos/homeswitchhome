<template>
  <div class="home">
    <h1>Propiedades</h1>
    <b-button v-b-modal.placeABidModal>Pujar</b-button>
    <placeABid :week="dataRegisterWeek"/>
    <listOfProperties/>
  </div>
</template>

<script>
// @ is an alias to /src
import placeABid from '@/components/placeABid/placeABid.vue'
import listOfProperties from '@/components/listOfProperties/listOfProperties.vue'
export default {
  name: 'home',
  data (){
    return{
      dataRegisterWeek:{
        id:3,
        idProperty:1,
        date:23
      }
    }
  },
  components: {
     listOfProperties,
     placeABid
  }
}
</script>
