<template>  
    <div style="width:300px;">
        <b-col align-self="start">
            <h3 style="text-align:center;">Iniciar Sesión</h3>
            <b-nav-form class="mx-sm-3" @submit.prevent="loginUser">
                <b-form-input size="sm" class="mr-sm-2 my-sm-3"
                    id="email"
                    type="email"
                    v-model="dataLogin.email"
                    required
                    placeholder="Ingrese un email:"
                ></b-form-input>
                <b-form-input size="sm" class="mr-sm-2"
                    id="password"
                    type="password"
                    v-model="dataLogin.password"
                    required
                    placeholder="Ingrese una contraseña:"
                ></b-form-input>
                <b-alert class="mt-sm-3" v-model="showInvalidData" variant="danger" dismissible>
                    <font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> El e-mail o la contraseña son incorrectos.
                </b-alert>
                <b-button size="sm" class="my-2 my-sm-3 mr-3 btn-block" type="submit" variant="dark">Iniciar Sesión</b-button>
            </b-nav-form>
        </b-col>
        <b-col align-self="start">
            <h3>Registrarse</h3>
            <b-nav-form class="mx-sm-3" @submit.prevent="registerUser">
                <b-form-input size="sm" class="mr-sm-2 my-sm-3"
                    id="email"
                    type="email"
                    v-model="dataRegister.email"
                    required
                    placeholder="Ingrese un email:"
                ></b-form-input>
                <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                    id="password"
                    type="password"
                    v-model="dataRegister.password"
                    required
                    placeholder="Ingrese una contraseña:"
                ></b-form-input>
                <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                    id="name"
                    type="text"
                    v-model="dataRegister.name"
                    required
                    placeholder="Ingrese un nombre:"
                ></b-form-input>
                <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                    id="surname"
                    type="text"
                    v-model="dataRegister.surname"
                    required
                    placeholder="Ingrese un apellido:"
                ></b-form-input>
                <b-button size="sm" class="my-2 my-sm-3" type="submit" variant="dark">Registrarse</b-button>
            </b-nav-form>
        </b-col>    
        
    </div>
</template>

<script>
    import Vuex from 'vuex';
    import axios from 'axios';

    export default {
        name: 'access',
        data() {
            return {
                dataRegister: {
                    email: '',
                    password: '',
                    name: '',
                    surname: '',
                },
                dataLogin: {
                    email: '',
                    password: '',
                },
                showInvalidData: false,
            }
        },
        computed: {

        },
        methods: {
            ...Vuex.mapActions([
                'loginUserAction',
            ]),
            loginUser(){
                axios.post('http://localhost:3000/login', {
                    data: this.dataLogin,
                })
                .then(response => {
                    localStorage.setItem('user',JSON.stringify(response.data.user));
                    localStorage.setItem('jwt',response.data.token);
                    this.loginUserAction(response.data.user);

                    /*if (localStorage.getItem('jwt') != null){
                        if(this.$route.params.nextUrl != null){
                            this.$router.push(this.$route.params.nextUrl); //No esta funcionando no se por qué
                        }else{
                            this.$router.push('/');
                        }
                    }*/
                })
                .catch(error => {
                    console.log(error);
                    this.showInvalidData=true;
                })
            },
            registerUser(){
                axios.post('http://localhost:3000/register', {
                    data: this.dataRegister,
                })
                .then(response => {
                    localStorage.setItem('user',JSON.stringify(response.data.user));
                    localStorage.setItem('jwt',response.data.token);
                    this.loginUserAction(response.data.user);

                    if (localStorage.getItem('jwt') != null){
                        if(this.$route.params.nextUrl != null){
                            this.$router.push(this.$route.params.nextUrl); //No esta funcionando no se por qué
                        }else{
                            this.$router.push('/');
                        }
                    }
                })
            }
        }
    }
</script>

