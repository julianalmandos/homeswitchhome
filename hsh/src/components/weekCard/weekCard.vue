<template>
    <div class="weekCard">
        <b-card v-if= ((!week.reserved)&compare(week.date)&(!week.idle)) border-variant="dark" class="card2" style="max-width: 15rem;margin-bottom:1.25rem">
            <h6>PMA: ${{maxBid}}</h6>
            <h5 slot="header">Semana: {{(week.date).substring(0,10)}}</h5>
            <b-card-text>
                <b-button class="transparentButton btn-block" v-if="week.auction && isAdmin" v-on:click="closeAuction">Cerrar subasta</b-button>
                <b-button class="transparentButton btn-block" v-else-if="isAdmin" v-on:click="openAuction">Abrir subasta</b-button>
                <b-button class="transparentButton btn-block" v-if="week.auction" @click="openPlaceABidModal">Pujar</b-button>
            </b-card-text>
        </b-card>
        <b-card v-if= ((week.reserved)||!compare(week.date)||(week.idle))   class="card1">
            <h5 slot="header">Semana: {{(week.date).substring(0,10)}}</h5>
            <b-card-text>
            </b-card-text>
        </b-card>
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
                maxBid: 0,
                property: {},
                idle: 0,
                reserved: 0,
                ok: true,
                hasBooking: false,
                winner: {},
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
                })
                .catch(error => {
                    console.log(error);
                });
                axios.get("http://localhost:3000/properties/"+ this.$route.params.id)
                    .then(response => {
                    this.property = response.data[0];
                })
                .catch(error => {
                    console.log(error);
                });
        },
        mounted() {
            this.$root.$on('placeABidModal::hidden', (bvEvent, modalId) => {
                this.reloadMaxBid();
            })
        },
        methods:{
            compare(aDate){
                return aDate > (new Date).toISOString()
            },
            openPlaceABidModal() {
                console.log('esta emitiendose');
                this.$emit('placingBid',this.week);
                console.log('se emitio');
            },
            reloadMaxBid(){
                console.log('reload');
                axios.get("http://localhost:3000/week/"+ this.week.id+'/maxbid')
                .then(response => {
                    this.maxBid=response.data.data;
                    console.log(response.data.data);
                    console.log("relodee")
                })
                .catch(error => {
                    console.log(error);
                });
            },
            reloadMaxBid2(){
                console.log('reload');
                axios.get("http://localhost:3000/week/"+ this.week.id+'/maxbid')
                .then(response => {
                    this.maxBid=response.data.data;
                    console.log(response.data.data);
                    console.log("relodee")
                    this.closeAuction()
                })
                .catch(error => {
                    console.log(error);
                });
            },
            closeAuction: function (){
                if (this.maxBid==this.property.base_price){
                    this.reserved= 0;
                    this.idle= 1;
                    this.closeAu();
                } else {
                    axios.get("http://localhost:3000/week/"+this.week.id+"/winner")
                        .then(response => {
                            this.winner=response.data[0];
                            console.log("consulte el winner y es: ", this.winner.email)
                            this.checkWinner();
                    })
                         .catch(error => {
                          console.log(error);
                   })                            
                }
        
            },

            closeAu(){
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

            checkWinner(){
                axios.post("http://localhost:3000/checkWinner",{
                        data:{
                            winner: this.winner.email,
                            date: (this.week.date).substring(0,10),
                        }
                    })
                        .then(response => {
                            this.hasBooking=response.data.data;
                            console.log("Me fije si el ganador tiene otras reservas para la misma semana: ", this.hasBooking)
                            this.makeReservation()
                    })
                         .catch(error => {
                          console.log(error);
                   })
            },
            makeReservation(){
                if (!this.hasBooking){
                        this.idle = 0;
                        this.reserved = 1;
                        console.log(this.winner.id);
                        axios.get("http://localhost:3000/makeReservation/"+this.winner.id)
                        .then(response => {
                            console.log("guarde la reserva")
                    })
                         .catch(error => {
                          console.log(error);
                   })
                    this.closeAu()

                    }else{
                        this.deleteBid();
                    }
          
            },
            deleteBid(){
                axios.get("http://localhost:3000/deleteBid/"+ this.winner.id)
                .then(response => {
                    console.log("elimine maxBid");
                    this.reloadMaxBid2();
                })
                .catch(error => {
                    console.log(error);
                })        
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
<style>
  .card1 {
    background-color:#bfbfbf;
    color:#f2f2f2;
    box-shadow: 0px 6px 3px -4px rgba(0,0,0,0.75);
    
  }
  .card2 {
    box-shadow: 0px 6px 3px -4px rgba(0,0,0,0.75);
  }
</style>