<template>
    <b-container>
        <h1 class="titulo">Precios de Suscripción</h1>
        <br>
        <form @submit.stop.prevent="changeSuscriptionPrices()">

        </form>
    </b-container>
</template>

<script>
    import axios from 'axios';
    
    export default {
        name: 'suscriptionPrices',
        data(){
            return {
                prices: [],
            }
        },
        mounted(){
            axios.get('//localhost:3000/suscriptionPrices')
                .then(response => {
                    this.prices=response.data;
                })
        },
        methods: {
            changeSuscriptionPrices(){
                if(confirm('¿Está seguro que desea modificar los precios de suscripción?')){
                    axios.post('//localhost:3000/suscriptionPrices',{
                        data: prices,
                    })
                    .then(response => {
                        //toast y recargar precios
                        this.reloadPrices();
                    })
                    .catch(error => {
                        console.log(error);
                    })
                }
            },
            reloadPrices(){
                axios.get('//localhost:3000/suscriptionPrices')
                    .then(response => {
                        this.prices=response.data;
                    })
            }
        }
    }

</script>

