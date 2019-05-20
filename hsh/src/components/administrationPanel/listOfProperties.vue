<template>
    <b-container>
        <h1 class="titulo">Lista de Propiedades</h1><br>
        <propertyCard v-for="property in properties" :key="property.id" :property="property" @deleted="reloadProperties"/>
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
            axios.get('//localhost:3000/properties')
                .then(response => {
                    console.log('anda');
                    this.properties=response.data;
                })
                .catch(error => {
                    console.log(error);
                })
        },
        methods: {
            reloadProperties() {
                axios.get('//localhost:3000/properties')
                    .then(response => {
                        console.log('anda');
                        this.properties=response.data;
                        this.$bvToast.toast('Propiedad eliminada con éxito!', {
                            title: 'Operación exitosa',
                            variant: 'success',
                            autoHideDelay: 5000,
                            toaster: 'b-toaster-bottom-right',
                        });
                    })
                    .catch(error => {

                    })
            }
        }
    }

</script>

<style scoped>

</style>
