<template>
    <div class= "weekCard">
        <b-card v-if= ((!week.reserved)&compare(week.date)) border-variant="light" class="text-center">
            <h6>PMA: ${{maxBid}}</h6>
            <h5 slot="header">Semana: {{(week.date).substring(0,10)}}</h5>
            <b-card-text>
                <b-button v-if="week.auction" v-on:click="closeAuction" block variant="outline-primary">Cerrar subasta</b-button>
                <b-button v-else v-on:click="openAuction" block variant="outline-primary">Abrir subasta</b-button>
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
                property: {},
                idle: 0,
                reserved: 0,
            }
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
                axios.get("http://localhost:3000/properties/"+ this.$route.params.id)
                    .then(response => {
                    this.property = response.data[0];
                })
                .catch(error => {
                    console.log(error);
                });
                if (this.maxBid==this.property.base_price){
                    this.reserved= 0;
                    this.idle= 1;
                    console.log ("hola");
                } else {
                    // Mandar mail de superación de puja
                    this.idle = 0;
                    this.reserved = 1;
                    console-log("chau");
                }
                // no hace el post
                axios
                    .post("http://localhost:3000/closeAuction/" + this.week.id , {
                        data: {
                            reserved: this.reserved,
                            idle: this.idle,
                        }
                    })
                    .then(response => {
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