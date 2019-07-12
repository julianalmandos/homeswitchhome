<template>
  <b-container>
    <h1 class="titulo">Mis reservas</h1>
    <br>
    <b-table
      show-empty
      striped
      hover
      small
      :items="bookings"
      :fields="fieldsForBookings"
      stacked="md"
    >
      <template slot="empty">
        <h5>No haz realizado reservas aún.</h5>
      </template>
      <template slot="date" slot-scope="data">{{ data.value.substring(0,10) }}</template>
      <template slot="price" slot-scope="data">${{ data.value }}</template>
    </b-table>

    <h1 class="titulo">Mis pujas</h1>
    <br>
    <b-table show-empty striped hover small :items="bids" :fields="fieldsForBids" stacked="md">
      <template slot="empty">
        <h5>No haz realizado pujas aún.</h5>
      </template>
      <template slot="date" slot-scope="data">{{ data.value.substring(0,10) }}</template>
      <template slot="price" slot-scope="data">${{ data.value }}</template>
    </b-table>

    <h1 v-if="!isNormal()" class="titulo">Mis reservas directas</h1>
    <br>
    <b-table show-empty striped hover small :items="directBooking" :fields="fieldsDirectBooking" stacked="md">
      <template slot="empty">
        <h5>No haz realizado pujas aún.</h5>
      </template>
      <template slot="date" slot-scope="data">{{ data.value.substring(0,10) }}</template>
      <template slot="price" slot-scope="data">${{ data.value }}</template>
    </b-table>

    <h1 class="titulo">Mis reservas a traves de Hot Sale</h1>
    <br>
    <b-table show-empty striped hover small :items="hotSale" :fields="fieldsHotSale" stacked="md">
      <template slot="empty">
        <h5>No haz realizado pujas aún.</h5>
      </template>
      <template slot="date" slot-scope="data">{{ data.value.substring(0,10) }}</template>
      <template slot="price" slot-scope="data">${{ data.value }}</template>
    </b-table>

  </b-container>
</template>
 

<script>
    import axios from 'axios'
       
    export default {
        name: 'listOfBookings',
        components: {
        },
        data() {
            return {
                fieldsForBookings: [
                    {
                        key: 'date',
                        label: 'Fecha Reservada',
                        sortable: true,
                    },
                    {
                        key: 'name',
                        label: 'Propiedad',
                        sortable: true,
                    }, 
                    {
                        key: 'price',
                        label: 'Precio de Reserva',
                        sortable: true,
                    }                    
                ],
                fieldsForBids: [
                    {
                        key: 'date',
                        label: 'Fecha Reservada',
                        sortable: true,
                    },
                    {
                        key: 'name',
                        label: 'Propiedad',
                        sortable: true,
                    }, 
                    {
                        key: 'price',
                        label: 'Precio de Puja',
                        sortable: true,
                    }                    
                ],
                fieldsHotSale: [
                    {
                        key: 'date',
                        label: 'Fecha Reservada',
                        sortable: true,
                    },
                    {
                        key: 'name',
                        label: 'Propiedad',
                        sortable: true,
                    }, 
                    {
                        key: 'price',
                        label: 'Precio de Puja',
                        sortable: true,
                    }                    
                ],
                fieldsDirectBooking: [
                    {
                        key: 'date',
                        label: 'Fecha Reservada',
                        sortable: true,
                    },
                    {
                        key: 'name',
                        label: 'Propiedad',
                        sortable: true,
                    }, 
                    {
                        key: 'price',
                        label: 'Precio de Puja',
                        sortable: true,
                    }                    
                ],
                bookings: [],
                bids:[], 
                directBooking:[],
                hotSale:[],
            }
        }, 
        beforeCreate() { 
            axios.post('//localhost:3000/bookingsOfUser',{
                data:{
                      email: this.$store.state.user.email,
                      types: 1,
                }
            })
                .then(response => { 
                    this.bookings=response.data
                })
                .catch(error => {
                    console.log(error);
                })
            axios.post('//localhost:3000/bidsOfUser',{
                data:{
                      email: this.$store.state.user.email,
                }
            })
                .then(response => {
                    this.bids=response.data;
                })
                .catch(error => {
                    console.log(error);
                })  
            axios.post('//localhost:3000/bookingsOfUser',{
                data:{
                      email: this.$store.state.user.email,
                      types:0,
                }
            })
                .then(response => {
                    this.directBooking=response.data;
                })
                .catch(error => {
                    console.log(error);
                })  
            axios.post('//localhost:3000/bookingsOfUser',{
                data:{
                      email: this.$store.state.user.email,
                      types:2,
                }
            })
                .then(response => {
                    this.hotSale=response.data;
                })
                .catch(error => {
                    console.log(error);
                })  
        },
        methods: {
            isNormal(){
              return this.$store.state.user != null && this.$store.state.user.role == 0;
             }
        },
    }
</script>