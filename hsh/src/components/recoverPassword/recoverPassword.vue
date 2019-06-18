<template>
    <b-container>
        <h1 class="titulo">Cambiar Contraseña</h1>
        <br>
        <h3>Para poder recuperar su contraseña debe seguir los siguientes pasos: </h3>
        <h6>
            <li>Ingresar su e-mail en el formulario que esta más abajo</li>
            <li>Hacer click en el botón "Recuperar Contraseña" </li>
            <li>Ingresar a la página web que le enviaremos por correo a la casilla que usted haya ingresado</li>
        </h6>
        <b-form  @submit.prevent="recoverPassword">
            <b-row align-h="center">
                <b-form-input
                    style="width:500px;"
                    placeholder="Ingrese su e-mail"
                    v-model="email"
                >
                </b-form-input>
            </b-row><br>
            <b-button class="blueButton" type="submit">Recuperar Contraseña</b-button>
        </b-form>
    </b-container>
</template>

<script>
    import axios from 'axios';

    export default {
        name: 'recoverPassword',
        data() {
            return {
                email: '',
            }
        },
        methods: {
            recoverPassword() {
                axios.post('//localhost:3000/recoverPassword',{
                    data: {
                        email: this.email,
                    }
                })
                .then(response => {
                    this.$bvToast.toast('Por favor, revise su casilla de correo.', {
                        title: 'Solicitud exitosa!',
                        variant: 'success',
                        autoHideDelay: 5000,
                        toaster: 'b-toaster-bottom-right',
                    });
                })
                .catch(err => {
                    this.$bvToast.toast('Esa dirección de e-mail no corresponde a una cuenta registrada en este sistema.', {
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

