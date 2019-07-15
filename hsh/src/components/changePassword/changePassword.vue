<template>
    <b-container>
        <h1 class="titulo">Cambiar Contraseña</h1>
        <br>
        <h3>Por favor, siga las siguientes instrucciones para recuperar su contraseña: </h3>
        <h6>
            <li>Ingresar su nueva contraseña en el formulario que se encuentra debajo</li>
            <li>Volver a ingresar su nueva contraseña (deben coincidir)</li>
            <li>Hacer click en el botón "Cambiar Contraseña"</li>
        </h6>
        <b-form  @submit.prevent="changePassword">
            <b-row align-h="center">
                <b-form-input
                    style="width:500px;"
                    placeholder="Ingrese su nueva contraseña"
                    type="password"
                    v-model="password"
                >
                </b-form-input>
            </b-row>
            <br>
            <b-row align-h="center">
                <b-form-input
                    style="width:500px;"
                    placeholder="Ingrese una vez más su nueva contraseña"
                    type="password"
                    v-model="confirmPassword"
                >
                </b-form-input>
            </b-row>
            <br>
            <b-button class="blueButton" type="submit">Cambiar Contraseña</b-button>
        </b-form>
    </b-container>
</template>

<script>
    import axios from 'axios';

    export default {
        name: 'changePassword',
        data() {
            return {
                token: this.$route.params.token,
                password: '',
                confirmPassword: '',
            }
        },
        created() {
            //Chequeo si el token en realidad existe o es uno inventado. Si es inventado, lo llevo a la página principal
            axios.post('//localhost:3000/tokenExists',{
                data: {
                    token: this.token,
                }
            })
            .then(response => {
            })
            .catch(err => {
                this.$router.push('/');
            })
        },
        methods: {
            changePassword() {
                if(this.password==this.confirmPassword){
                    axios.post('//localhost:3000/changePassword',{
                        data: {
                            token: this.token,
                            password: this.password,
                        }
                    })
                    .then(response => {
                        this.$bvToast.toast('Su contraseña ha sido cambiada con éxito!', {
                            title: 'Solicitud exitosa!',
                            variant: 'success',
                            autoHideDelay: 5000,
                            toaster: 'b-toaster-bottom-right',
                        });
                        //Reseteo los campos
                        this.password="";
                        this.confirmPassword="";
                    })
                    .catch(err => {
                        console.log(err);
                    })
                }else{
                    this.$bvToast.toast('Las contraseñas no coinciden. Ingréselas nuevamente.', {
                        title: 'Solicitud fallida!',
                        variant: 'danger',
                        autoHideDelay: 5000,
                        toaster: 'b-toaster-bottom-right',
                    });
                }                
            }
        }
    }
</script>

