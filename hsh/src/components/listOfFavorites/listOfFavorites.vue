<template>
    <b-container>
        <h1 class="titulo">Lista de Favoritos</h1><br>
        <br>
        <b-table 
            show-empty
            striped 
            hover 
            small
            :items="favorites" 
            :fields="fields"
            stacked="md"
        >
            <template slot="empty">
                <h5>Usted no posee semanas favoritas</h5>
            </template>
            <template slot="date" slot-scope="data">
                {{ data.value.substring(0,10) }}
            </template>
            <template slot="state" slot-scope="data">
                <span v-if="isInAuction(data.item.date) && data.item.auction==1">SUBASTA ABIERTA</span>
                <span v-else-if="isInAuction(data.item.date) && (data.item.auction==2 || data.item.auction==0)">SUBASTA CERRADA</span>
                <span v-else-if="isInHotSale(data.item.date) && data.item.idle==0">EN HOTSALE</span>
                <span v-else-if="isInHotSale(data.item.date) && data.item.idle==1">OCIOSA</span>
                <span v-else-if="isExpired(data.item.date)">EXPIRADA</span>
                <span v-else>RESERVA DIRECTA</span>
            </template>
            <template slot="until" slot-scope="data">
                {{ until(data.item.date) }}
            </template>
            <template slot="options" slot-scope="data">
                <b-button v-if="data.item.role!=2" class="redButton btn-sm" @click="deleteFavorite(data.item.week_id)"><font-awesome-icon icon="heart-broken" style="color:#ff6e6e;stroke:black;stroke-width:20;"></font-awesome-icon> Quitar de favoritos</b-button>
                <span v-else>No hay opciones.</span>
            </template>
        </b-table>
    </b-container>
</template>

<script>
    import axios from 'axios'

    export default {
        name: 'listOfFavorites',
        data(){
            return {
                favorites: [],
                fields: [
                    {
                        key: 'name',
                        label: 'Propiedad',
                        sortable: true,
                    },
                    {
                        key: 'date',
                        label: 'Desde',
                        sortable: true,
                    },
                    {
                        key: 'until',
                        label: 'Hasta',
                        sortable: true,
                    },
                    {
                        key: 'state',
                        label: 'Estado',
                    },
                    {
                        key: 'options',
                        label: 'Opciones'
                    }                     
                ],
            }
        },
        mounted() {
            this.reloadFavorites();
        },
        methods: {
            isInAuction(date) {
                date=new Date(date).toISOString().substring(0, 10);
                var actualDate = new Date();
                var actualDate2 = new Date();
                actualDate.setMonth(actualDate.getMonth() + 6);
                actualDate2.setMonth(actualDate2.getMonth() + 6);
                actualDate2.setDate(actualDate2.getDate() - 3);
                return (
                    (date <= actualDate.toISOString().substring(0, 10)) &
                    (date >= actualDate2.toISOString().substring(0, 10))
                );
            },
            isInHotSale(date) {
                date=new Date(date).toISOString().substring(0, 10);
                var actualDate = new Date();
                var actualDate2 = new Date();
                actualDate.setMonth(actualDate.getMonth() + 6);
                actualDate.setDate(actualDate.getDate() - 3);
                return (
                    (date < actualDate.toISOString().substring(0, 10)) &
                    (date >= actualDate2.toISOString().substring(0, 10))
                );
            },
            isExpired(date) {
                date=new Date(date).toISOString().substring(0, 10);
                var actualDate = new Date();
                if(date<actualDate){return true;}
                return false;
            },
            until(date) {
                var result=new Date(date);
                result.setDate(result.getDate()+6);
                return result.toISOString().substring(0,10);
            },
            deleteFavorite(weekId){
                axios.post('//localhost:3000/deleteFavorite',{
                    data: {
                        userId: this.$store.state.user.id,
                        weekId: weekId,
                    }
                })
                    .then(response => {
                        this.$bvToast.toast('La semana fue quitada de favoritos exitosamente.', {
                            title: 'Operacion exitosa!',
                            variant: 'success',
                            autoHideDelay: 5000,
                            toaster: 'b-toaster-bottom-right',
                        });
                        this.reloadFavorites();
                    })
                    .catch(error => {
                        console.log(error);
                    })
            },
            reloadFavorites(){
                axios.get('//localhost:3000/getFavorites/'+this.$store.state.user.id)
                    .then(response => {
                        this.favorites=response.data;
                    })
                    .catch(error => {
                        console.log(error);
                    })
            }
        },
    }

</script>

<style scoped>

    .redButton {
      background-color:white!important;
      color:black!important;
    }
    .redButton:hover {
        background-color: rgba(255, 135, 135, 0.5)!important;
        color:black!important;
    }

</style>
