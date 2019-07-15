<template>
    <b-container>
        <h1 class="titulo">Solicitudes Normales</h1><br>
        <b-table 
            show-empty
            striped 
            hover 
            small
            :items="requests" 
            :fields="fields"
            stacked="md"
        >
            <template slot="empty">
                <h5>No hay solicitudes disponibles</h5>
            </template>
            <template slot="options" slot-scope="data">
                <b-button class="blueButton btn-sm" @click="acceptRequest(data.item.user_id,data.item.email)">Aceptar</b-button>
            </template>
        </b-table>
    </b-container>
</template>

<script>
    import Vuex from 'vuex';
    import axios from 'axios';

    export default {
        name: 'normalRequests',
        data() {
            return {
                requests: [],
                fields: [
                    {
                        key: 'email',
                        label: 'E-Mail',
                        sortable: true,
                    },
                    {
                        key: 'surname',
                        label: 'Apellido',
                        sortable: true,
                    },
                    {
                        key: 'name',
                        label: 'Nombre',
                        sortable: true,
                    },
                    {
                        key: 'comment',
                        label: 'Comentario',
                        sortable: true,
                    },
                    {
                        key: 'options',
                        label: 'Opciones'
                    }                    
                ],
            }
        },
        beforeCreate() {
            axios.get('//localhost:3000/normalRequests')
            .then(response => {
                this.requests=response.data;
            })
        },
        methods: {
            getRequests() {
                axios.get('//localhost:3000/normalRequests')
                .then(response => {
                    this.requests=response.data;
                })
            },
            acceptRequest(id,email){
                axios.post('//localhost:3000/acceptNormalRequest',{
                    data: {
                        userId: id,
                        email: email,
                    },
                })
                .then(response => {
                    this.$bvToast.toast('La solicitud ha sido aceptada con éxito.', {
                        title: 'Solicitud exitosa!',
                        variant: 'success',
                        autoHideDelay: 5000,
                        toaster: 'b-toaster-bottom-right',
                    });
                    this.getRequests();
                })
                .catch(err => {
                    this.$bvToast.toast('El usuario posee reservas directas pendientes.', {
                        title: 'Solicitud fallida!',
                        variant: 'danger',
                        autoHideDelay: 5000,
                        toaster: 'b-toaster-bottom-right',
                    });
                    console.log(err);
                })
            }
        },
    }
</script>
