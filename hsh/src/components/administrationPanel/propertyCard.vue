<template>
    <b-card img-src="data:image/png;base64,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" img-alt="Card image" img-left class="mb-3" style="text-align:start;height:200px;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
      <b-card-text>
        <b-row>
            <b-col sm="10">
                <b-row>
                    <b-col sm="4">
                        <strong>Nombre</strong><br>
                        {{this.property.name}}<br>
                        <strong>Localidad</strong><br>
                        {{this.property.locality}}
                    </b-col>
                    <b-col sm="3">
                        <strong>Ubicación</strong><br>
                        {{this.property.address}}<br>
                        <strong>Provincia</strong><br>
                        {{this.property.province}}
                    </b-col>
                    <b-col sm="3">
                        <strong>Monto Base</strong><br>
                        {{this.property.base_price}}<br>
                        <strong>País</strong><br>
                        {{this.property.country}}
                    </b-col>
                </b-row>
                <b-row align-h="start">
                    <b-col>
                        <strong>Descripción: </strong>
                        {{this.property.description }}
                    </b-col>
                </b-row>
            </b-col>
            <b-col sm="2" align-self="center">
                <b-row>
                    <b-button class="btn-block mb-2 blueButton" v-b-modal.editPropertyModal>Editar</b-button>
                </b-row>
                <b-row>
                    <b-button class="btn-block redButton" @click="eliminarPropiedad">Eliminar</b-button>
                </b-row>
            </b-col>
        </b-row>
      </b-card-text>
    </b-card>
</template>

<script>
    import editProperty from '@/components/editProperty/editProperty.vue'
    import axios from 'axios'

    export default {
        name: 'adminPropertyCard',
        components: {
            editProperty,
        },
        props: {
            property: {},
        },
        data() {
            return {
                images: [],
            }
        },
        beforeCreate() {
            axios.get('//localhost:3000/images/'+this.property.id)
                .then(response => {
                    this.images=response.data;
                })
        },
        methods: {
            eliminarPropiedad() {
                axios.post('//localhost:3000/properties/'+this.property.id+'/delete')
                    .then(response => {
                        this.$bvToast.toast('Propiedad eliminada con éxito!', {
                            title: 'Operación exitosa',
                            variant: 'success',
                            autoHideDelay: 5000,
                            appendToast: 'append',
                            toaster: 'b-toaster-bottom-right',
                        })
                    })
                    .catch(response => {
                        this.$bvToast.toast('La propiedad no se pudo eliminar porque tiene reservas pendientes.', {
                            title: 'Operación fallida',
                            variant: 'danger',
                            autoHideDelay: 5000,
                            appendToast: 'append',
                            toaster: 'b-toaster-bottom-right',
                        })
                    })
            }
        }
        
    }
</script>

<style scoped>

</style>

