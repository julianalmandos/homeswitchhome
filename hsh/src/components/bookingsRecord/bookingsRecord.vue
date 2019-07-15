<template>
  <b-container>
    
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
    <b-table
      show-empty
      striped
      hover
      small
      :items="directBooking"
      :fields="fieldsDirectBooking"
      stacked="md"
    >
      <template slot="empty">
        <h5>No haz realizado reservas aún.</h5>
      </template>
      <template slot="date" slot-scope="data">{{ data.value.substring(0,10) }}</template>
      <template slot="price" slot-scope="data">${{ data.value }}</template>
      <template slot="options" slot-scope="data">
        <b-button @click="cancelBooking(data.item)" class="blueButton btn-sm">Cancelar Reserva</b-button>
      </template>
    </b-table>
    <h1 class="titulo">Mis reservas a través de subastas</h1>
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
      <template slot="options" slot-scope="data">
        <b-button @click="cancelBooking(data.item)" class="blueButton btn-sm">Cancelar Reserva</b-button>
      </template>
    </b-table>
    <h1 class="titulo">Mis reservas a traves de Hot Sale</h1>
    <br>
    <b-table show-empty striped hover small :items="hotSale" :fields="fieldsHotSale" stacked="md">
      <template slot="empty">
        <h5>No haz realizado reservas aún.</h5>
      </template>
      <template slot="date" slot-scope="data">{{ data.value.substring(0,10) }}</template>
      <template slot="price" slot-scope="data">${{ data.value }}</template>
      <template slot="options" slot-scope="data">
        <b-button @click="cancelBooking(data.item)" class="blueButton btn-sm">Cancelar Reserva</b-button>
      </template>
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
                    },
                    {
                        key: 'options',
                        label: 'Opciones'
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
                        label: 'Precio de Reserva',
                        sortable: true,
                    },  
                    {
                        key: 'options',
                        label: 'Opciones'
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
                        label: 'Precio de Reserva',
                        sortable: true,
                    },
                    {
                        key: 'options',
                        label: 'Opciones'
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
             },
            cancelBooking(element){
                if(confirm('¿Está seguro que desea cancelar esta reserva?' )){

                axios.post('//localhost:3000/cancelBooking',{
                    data:{booking: element, email: this.$store.state.user.email}
                }) 
                .then(response => {
                    this.reloadBookings()
                    this.$bvToast.toast('La reserva se canceló exitosamente!', {
                        title: 'Operación exitosa',
                        variant: 'success',
                        autoHideDelay: 5000,
                        toaster: 'b-toaster-bottom-right',
                    })
                })
                }
                
            },
            reloadBookings(){
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
        }
    }
</script>