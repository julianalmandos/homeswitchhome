<template>
<<<<<<< HEAD
    <b-container>
        <h1 class="titulo">Lista de Reservas</h1><br>
        <b-table 
            striped 
            hover 
            small
            :items="bookings" 
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
                        key: 'email',
                        label: 'Locatario',
                        sortable: true,
                    },
                    {
                        key: 'price',
                        label: 'Precio de Reserva',
                        sortable: true,
                    }                    
                ],
                bookings: [],
            }
        },
        beforeCreate() {
            axios.get('//localhost:3000/bookings')
                .then(response => {
                    this.bookings=response.data;
                })
                .catch(error => {
                    console.log(error);
                })
        }
    }
</script>

=======
    
</template>

<script>
    import axios from 'axios';

    export default {
        name: 'listOfBookings',
    }

</script>

<style scoped>
    
</style>
>>>>>>> master
