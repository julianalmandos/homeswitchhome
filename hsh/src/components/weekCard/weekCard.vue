<template>
    <div class= "weekCard">
        <b-card v-if= ((!week.reserved)&compare(week.date)) border-variant="light" class="text-center">
            <h5 slot="header">Semana: {{(week.date).substring(0,10)}}</h5>
            <b-card-text>
                <b-button v-if= week.auction v-on:click="closeAuction" block variant="outline-primary">Cerrar subasta</b-button>
                <b-button v-else v-on:click="openAuction" block variant="outline-primary">Abrir subasta</b-button>
                <b-button v-if= week.auction block variant="outline-primary">Pujar</b-button>
            </b-card-text>
        </b-card>
        <b-card v-if= ((week.reserved)||!compare(week.date)) bg-variant="secondary" text-variant="white" class="text-center">
            <h5 slot="header">Semana: {{(week.date).substring(0,10)}}</h5>
            <b-card-text>
            </b-card-text>
        </b-card>

    </div>
</template>
<script>
import Vuex from 'vuex';
import axios from 'axios';

    export default {
        name: "weekCard",
        props: ["week"],
        methods:{
            compare(aDate){
                return aDate > (new Date).toISOString()
            },
            closeAuction: function (event){
                axios.get("http://localhost:3000/closeAuction/"+ this.week.id)
                .then(response => {
                    console.log(response.data);
                })
                .catch(error => {
                    console.log(error);
                });
            },
            openAuction: function (event){
                axios.get("http://localhost:3000/openAuction/"+ this.week.id)
                .then(response => {
                    console.log(response.data);
                })
                .catch(error => {
                    console.log(error);
                }); 

            },

        }

    }

</script>