<template>
    <b-container>
        <h1 class="titulo">Precios de Suscripción</h1>
        <br>
        <div class="formulario">
            <form @submit.stop.prevent="changeSuscriptionPrices()" style="width:30%">
                <label for="normalPrice">Precios Usuario Normal</label>
                <b-form-group id="normalPrice">
                    <b-form-input type="number" v-model="prices[0].price" required/>
                </b-form-group>
                <label for="premiumPrice">Precios Usuario Normal</label>
                <b-form-group id="premiumPrice">
                    <b-form-input type="number" v-model="prices[1].price" required></b-form-input>
                </b-form-group>
                <br>  
                <b-button type="submit" class="blueButton">Modificar!</b-button>
            </form>
        </div>
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
                if(this.prices[0].price<=0 || this.prices[1].price<=0){
                    this.$bvToast.toast('Los precios deben ser mayores a 0.', {
                        title: 'Modificación fallida!',
                        variant: 'danger',
                        autoHideDelay: 5000,
                        toaster: 'b-toaster-bottom-right',
                    });
                    return false;
                }
                if(this.prices[0].price>=this.prices[1].price){
                    this.$bvToast.toast('El precio de la suscripción Premium debe ser mayor al de la suscripción común.', {
                        title: 'Modificación fallida!',
                        variant: 'danger',
                        autoHideDelay: 5000,
                        toaster: 'b-toaster-bottom-right',
                    });
                    return false;
                }
                if(confirm('¿Está seguro que desea modificar los precios de suscripción?')){
                    axios.post('//localhost:3000/suscriptionPrices',{
                        data: {
                            normalPrice: this.prices[0].price,
                            premiumPrice: this.prices[1].price,
                        },
                    })
                    .then(response => {
                        this.$bvToast.toast('Los precios de las suscripciones fueron modificados con éxito!', {
                            title: 'Modificación exitosa!',
                            variant: 'success',
                            autoHideDelay: 5000,
                            toaster: 'b-toaster-bottom-right',
                        });
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

<style scoped>

    .formulario {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

</style>


