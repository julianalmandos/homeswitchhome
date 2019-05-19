<template>
    <b-card :img-src="this.images[0].image" img-alt="Card image" img-left class="mb-3" style="text-align:start;height:200px;width:350px;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
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
                    <b-button class="btn-block redButton">Eliminar</b-button>
                </b-row>
            </b-col>
        </b-row>
      </b-card-text>
    </b-card>
</template>

<script>
    import editProperty from '@/components/editProperty/editProperty.vue'

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
        }
        
    }
</script>

<style scoped>

</style>

