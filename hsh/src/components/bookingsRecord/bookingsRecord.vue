<template>
    <b-container>
        <h1 class="titulo">Mis reservas</h1><br>
        <b-table 
            show-empty
            striped 
            hover 
            small
            :items="bookings" 
            :fields="fields"
            stacked="md"
        >
            <template slot="empty">
                <h5>No hay reservas disponibles</h5>
            </template>
            <template slot="date" slot-scope="data">
                {{ data.value.substring(0,10) }}
            </template>
            <template slot="price" slot-scope="data">
                ${{ data.value }}
            </template>
        </b-table>
        <b-table 
            show-empty
            striped 
            hover 
            small
            :items="bids" 
            :fields="fields"
            stacked="md"
        >
            <template slot="date" slot-scope="data">
                {{ data.value.substring(0,10) }}
            </template>
            <template slot="price" slot-scope="data">
                ${{ data.value }}
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
                fields: [
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
                        label: 'Precio de Reserva/Puja',
                        sortable: true,
                    }                    
                ],
                bookings: [],
                bids:[], 
            }
        }, 
        beforeCreate() { 
            axios.post('//localhost:3000/bookingsOfUser',{
                data:{
                      email: this.$store.state.user.email,
                }
            })
                .then(response => {
                    this.bookings=response.data;
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
        }
    }
</script>