<template>
    <b-container>
        <h1 class="titulo">Convertirse en Premium</h1>
        <br>
        <h3>Para solicitar su pase a usuario Premium debe seguir los siguientes pasos: </h3>
        <h6>
            <li> (Opcional) Rellenar el campo con un breve comentario sobre por qué desea convertirse en Premium. </li>
            <li>Hacer click en el botón "Convertirme en Premium!" </li>
            <li>Comunicarse por teléfono o acercarse a nuestra oficina para completar la solicitud. </li>
        </h6>
        <b-form v-if="!this.hasRequest" @submit.prevent="convertAccountToPremium">
            <b-row align-h="center">
                <b-form-textarea
                    style="width:500px;"
                    placeholder="Cuentenos brevemente por qué desea convertirse en Premium"
                    no-resize
                    rows=5
                    v-model="comment"
                >

                </b-form-textarea>
            </b-row><br>
            <b-button class="blueButton" type="submit">Convertirme en Premium!</b-button>
        </b-form>
        <div v-else>
            <h4 style="color:red;">Usted ya posee una solicitud para convertirse en Premium.</h4>
        </div>
    </b-container>
</template>

<script>
    import axios from 'axios';
    import Vuex from 'vuex';

    export default {
        name: 'convertAccountToPremium',
        data() {
            return {
                comment: '',
                hasRequest: false,
            }
        },
        computed: {
            ...Vuex.mapState([
                'user',
            ])
        },
        created() {
            axios.get('//localhost:3000/hasPremiumRequest/'+this.user.id)
            .then(response => {
                this.hasRequest=response.data;
            })
        },
        methods: {
            convertAccountToPremium() {
                axios.post('//localhost:3000/convertToPremium',{
                    data: {
                        userId: this.user.id,
                        comment: this.comment,
                    },
                })
                .then(response => {
                    this.$bvToast.toast('Su solicitud ha sido enviada con éxito!', {
                        title: 'Solicitud exitosa!',
                        variant: 'success',
                        autoHideDelay: 5000,
                        toaster: 'b-toaster-bottom-right',
                    });
                    this.hasRequest=true;
                })
                .catch(err => {
                    this.$bvToast.toast('Usted ya posee una solicitud para convertirse en Premium.', {
                        title: 'Solicitud fallida!',
                        variant: 'danger',
                        autoHideDelay: 5000,
                        toaster: 'b-toaster-bottom-right',
                    });
                })
            }
        }
    }
</script>
