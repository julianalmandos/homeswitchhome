<template>
    <b-container>
        <h1 class="titulo">Lista de Usuarios</h1><br>
        <b-form-group class="mb-0">
          <b-input-group>
            <b-form-input v-model="filter" placeholder="Buscar usuario..."></b-form-input>
          </b-input-group>
        </b-form-group>
        <br>
        <b-table 
            show-empty
            striped 
            hover 
            small
            empty-filtered-text="No hay usuarios que correspondan con su búsqueda."
            :items="users" 
            :fields="fields"
            :filter="filter"
            stacked="md"
        >
            <template slot="empty">
                <h5>No hay usuarios registrados aún</h5>
            </template>
            <template slot="register_date" slot-scope="data">
                {{ data.value.substring(0,10) }}
            </template>
            <template slot="role" slot-scope="data">
                {{data.value==0 ? 'Común' : (data.value==1 ? 'Premium' : 'Administrador')}}
            </template>
            <template slot="credits" slot-scope="data">
                {{ data.value }}
            </template>
            <template slot="options" slot-scope="data">
                <b-button v-if="data.item.role!=2" class="blueButton btn-sm" @click="makeAdministrator(data.item.id)">Convertir en Administrador</b-button>
                <span v-else>No hay opciones.</span>
            </template>
        </b-table>
    </b-container>
</template>

<script>
    import axios from 'axios';

    export default {
        name: 'listOfUsers',
        data() {
            return {
                fields: [
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
                        key: 'email',
                        label: 'E-Mail',
                        sortable: true,
                    },
                    {
                        key: 'role',
                        label: 'Tipo de Usuario',
                        sortable: true,
                    },
                    {
                        key: 'register_date',
                        label: 'Fecha de Registro',
                        sortable: true,
                    },
                    {
                        key: 'credits',
                        label: 'Créditos',
                        sortable: true,
                    },
                    {
                        key: 'options',
                        label: 'Opciones'
                    }                     
                ],
                users: [],
                filter: null,
            }
        },
        mounted(){
            axios.get('//localhost:3000/users')
                .then(response => {
                    this.users=response.data;
                })
        },
        methods: {
            makeAdministrator(userId){
                if(confirm('¿Esta seguro que desea convertir ese usuario en administrador?')){
                    axios.post('//localhost:3000/acceptAdministratorRequest',{
                        data: {
                            userId: userId,
                        }
                    })
                    .then(response => {
                        this.reloadTable();
                    })
                    .catch(error => {
                        console.log(error);
                    })
                }
            },
            reloadTable(){
                axios.get('//localhost:3000/users')
                .then(response => {
                    this.users=response.data;
                })
            }
        }
    }

</script>
