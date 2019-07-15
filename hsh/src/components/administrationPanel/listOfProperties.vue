<template>
    <b-container>
        <h1 class="titulo">Lista de Propiedades</h1><br>
        <h5 v-if="!properties.length">No hay propiedades disponibles.</h5>
        <propertyCard v-else v-for="property in properties" :key="property.id" :property="property" @disabled="reloadProperties2" @deleted="reloadProperties"/>
    </b-container>
</template>

<script>
    import axios from 'axios';
    import propertyCard from '@/components/administrationPanel/propertyCard.vue'

    export default {
        name: 'adminListOfProperties',
        components: {
            propertyCard,
        },
        data() {
            return {
                properties: [],
            }
        },
        beforeCreate() {
            axios.get('//localhost:3000/properties/admin')
                .then(response => {
                    this.properties=response.data;
                })
                .catch(error => {
                    console.log(error);
                })
        },
        methods: {
            reloadProperties(sizeOfBookings) {
                axios.get('//localhost:3000/properties/admin')
                    .then(response => {
                        this.properties=response.data;
                        this.$bvToast.toast(`Propiedad eliminada con éxito!. La cantidad de reservas canceladas fue ${sizeOfBookings}`, {
                            title: 'Operación exitosa',
                            variant: 'success',
                            autoHideDelay: 5000,
                            toaster: 'b-toaster-bottom-right',
                        });
                    })
                    .catch(error => {

                    })
            },
             reloadProperties2() {
                axios.get('//localhost:3000/properties/admin')
                    .then(response => {
                        this.properties=response.data;
                    })
            }
        }
    }

</script>

<style scoped>

</style>
