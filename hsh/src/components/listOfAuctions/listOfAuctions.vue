<template>
 <b-container>
        <h1 class="titulo">Lista de Subastas Activas</h1><br>
            
        <h5 v-if="!auctions.length">No hay subastas activas.</h5>
        <b-row  v-else>
        <auctionCard class = "mb-2" v-for="auction in auctions" :key="auction.id" :auction="auction"/>
        </b-row>
 </b-container>
</template>

<script>
    import axios from 'axios';
    import auctionCard from '@/components/auctionCard/auctionCard.vue'

    export default {
        name: 'listOfAuctions',
        components: {
            auctionCard,
        },
        data() {
            return {
                auctions: [],
            }
        },
        beforeCreate() {
            axios.get('//localhost:3000/auctions')
                .then(response => {
                    this.auctions=response.data;
                })
                .catch(error => {
                    console.log(error);
                })
        },
    }

</script>