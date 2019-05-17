<template>
    <div class= "weekCard">
        <b-card v-if= ((!week.reserved)&compare(week.date)) border-variant="light" class="text-center">
            <h6>PMA: ${{maxBid}}</h6>
            <h5 slot="header">Semana: {{(week.date).substring(0,10)}}</h5>
            <b-card-text>
                <b-button v-if="week.auction && isAdmin" v-on:click="closeAuction" block variant="outline-primary">Cerrar subasta</b-button>
                <b-button v-else-if="isAdmin" v-on:click="openAuction" block variant="outline-primary">Abrir subasta</b-button>
                <b-button v-if="week.auction" v-b-modal.placeABidModal block variant="outline-primary">Pujar</b-button>
            </b-card-text>
        </b-card>
        <b-card v-if= ((week.reserved)||!compare(week.date)) bg-variant="secondary" text-variant="white" class="text-center">
            <h5 slot="header">Semana: {{(week.date).substring(0,10)}}</h5>
            <b-card-text>
            </b-card-text>
        </b-card>
        <placeABid :week="this.week"/>
    </div>
</template>
<script>
import Vuex from 'vuex';
import axios from 'axios';
import placeABid from '@/components/placeABid/placeABid.vue';

    export default {
        name: "weekCard",
        props: ["week"],
        components: {
            placeABid,
        },
        data() {
            return {
                maxBid: '',
            }
        },
        computed: {
            isAdmin() {
                return (this.$store.state.user!=null && this.$store.state.user.role==2);
            },
        },
        created(){
            axios.get("http://localhost:3000/week/"+ this.week.id+'/maxbid')
                .then(response => {
                    this.maxBid=response.data.data;
                    console.log(response.data.data);
                    this.$emit('edited');
                })
                .catch(error => {
                    console.log(error);
                });
        },
        methods:{
            compare(aDate){
                return aDate > (new Date).toISOString()
            },
            closeAuction: function (){
                axios.get("http://localhost:3000/closeAuction/"+ this.week.id)
                .then(response => {
                    console.log(response.data);
                    this.$emit('edited');
                })
                .catch(error => {
                    console.log(error);
                });
            },
            openAuction: function (){
                axios.get("http://localhost:3000/openAuction/"+ this.week.id)
                .then(response => {
                    console.log(response.data);
                    this.$emit('edited');
                })
                .catch(error => {
                    console.log(error);
                }); 

            },

        }

    }

</script>