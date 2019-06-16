<template>
    <b-container>
        <h1 class="titulo">Convertirse en Normal</h1>
        <br>
        <h3>Para solicitar su baja como usuario Premium debe seguir los siguientes pasos: </h3>
        <h6>
            <li> (Opcional) Rellenar el campo con un breve comentario sobre por qué desea darse de baja como Premium. </li>
            <li>Hacer click en el botón "Convertirme en Normal!" </li>
            <li>Comunicarse por teléfono o acercarse a nuestra oficina para completar la solicitud. </li>
        </h6>
        <b-form v-if="!this.hasRequest" @submit.prevent="convertAccountToNormal">
            <b-row align-h="center">
                <b-form-textarea
                    style="width:500px;"
                    placeholder="Cuentenos brevemente por qué desea darse de baja como Premium"
                    no-resize
                    rows=5
                    v-model="comment"
                >

                </b-form-textarea>
            </b-row>
            <b-button class="blueButton" type="submit">Convertirme en Normal!</b-button>
        </b-form>
        <div v-else>
            <h4 style="color:red;">Usted ya posee una solicitud para darse de baja como Premium.</h4>
        </div>
    </b-container>
</template>

<script>
    import axios from 'axios';
    import Vuex from 'vuex';

    export default {
        name: 'convertAccountToNormal',
        data() {
            return {
                comment: '',
            }
        },
        computed: {
            ...Vuex.mapState([
                'user',
            ])
        },
        beforeCreate() {
            axios.get('//localhost:3000/hasNormalRequest/'+this.user.id)
            .then(response => {
                hasRequest=response.data;
            })
        },
        methods: {
            convertAccountToNormal() {
                axios.post('//localhost:3000/convertToNormal',{
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
                })
                .catch(err => {
                    this.$bvToast.toast('Usted ya posee una solicitud para darse de baja como Premium.', {
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
