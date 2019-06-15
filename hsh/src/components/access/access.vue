<template>  
    <div style="width:450px;">
        <b-col align-self="start">
            <h3 style="text-align:center;">Iniciar Sesión</h3>
            <b-nav-form class="mx-sm-3 form" @submit.prevent="loginUser">
                <b-col>
                    <b-form-input size="sm" class="mr-sm-2 my-sm-3"
                        id="email"
                        type="email"
                        v-model="dataLogin.email"
                        required
                        placeholder="Ingrese un email"
                        style="width:100%"
                    ></b-form-input>
                    <b-form-input size="sm" class="mr-sm-2"
                        id="password"
                        type="password"
                        v-model="dataLogin.password"
                        required
                        placeholder="Ingrese una contraseña"
                        style="width:100%"
                    ></b-form-input>
                
                    <b-alert class="mt-sm-3" v-model="showInvalidLoginData" variant="danger" dismissible>
                        <font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> El e-mail o la contraseña son incorrectos.
                    </b-alert>
                    <b-button size="sm" class="my-2 my-sm-3 mr-3 btn-block" type="submit" variant="dark">Iniciar Sesión</b-button>
                </b-col>
            </b-nav-form>
        </b-col>
        <b-col align-self="start">
            <h3 style="text-align:center;">Registrarse</h3>
            <b-nav-form class="mx-sm-3 form" @submit.prevent="registerUser">
                <b-col>
                    <b-form-input size="sm" class="mr-sm-2 my-sm-3"
                        id="email"
                        type="email"
                        v-model="dataRegister.email"
                        required
                        placeholder="Ingrese un email"
                        style="width:100%"
                    ></b-form-input>
                    <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                        id="password"
                        type="password"
                        v-model="dataRegister.password"
                        required
                        placeholder="Ingrese una contraseña"
                        style="width:100%"
                    ></b-form-input>
                    <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                        id="confirmPassword"
                        type="password"
                        v-model="dataRegister.confirmPassword"
                        required
                        placeholder="Ingrese de nuevo la contraseña"
                        style="width:100%"
                    ></b-form-input>
                    <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                        id="name"
                        type="text"
                        v-model="dataRegister.name"
                        required
                        placeholder="Ingrese un nombre"
                        style="width:100%"
                    ></b-form-input>
                    <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                        id="surname"
                        type="text"
                        v-model="dataRegister.surname"
                        required
                        placeholder="Ingrese un apellido"
                        style="width:100%"
                    ></b-form-input>
                    <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                        id="birthday"
                        type="text"
                        v-model="dataRegister.birthday"
                        required
                        placeholder="Ingrese una fecha de nacimiento"
                        style="width:100%"
                    ></b-form-input>
                    <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                        id="cardNumber"
                        type="text"
                        v-model="dataRegister.cardNumber"
                        required
                        placeholder="Ingrese el número de su tarjeta"
                        style="width:100%"
                    ></b-form-input>
                    <b-form-input size="sm" class="mr-sm-2 mb-sm-3"
                        id="cardSecurityNumber"
                        type="password"
                        v-model="dataRegister.cardSecurityNumber"
                        required
                        placeholder="Ingrese el código de seguridad de su tarjeta"
                        style="width:100%"
                    ></b-form-input>
                    <b-row align-h="center">
                        <label for="" class="mr-2"><strong>Fecha de Vencimiento</strong></label>
                        <b-form-select required class="mr-2" v-model.number="dataRegister.cardExpirationDate.month" :options="months()">
                            <template slot="first">
                                <option :value="null" disabled>Mes</option>
                            </template>
                        </b-form-select>
                        <b-form-select required v-model.number="dataRegister.cardExpirationDate.year" :options="years()">
                            <template slot="first">
                                <option :value="null" disabled>Año</option>
                            </template>
                        </b-form-select>
                    </b-row>
                    <b-alert class="mt-sm-3" v-model="showInvalidRegisterPassword" variant="danger" dismissible>
                        <font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> Las contraseñas no coinciden
                    </b-alert>
                    <b-alert class="mt-sm-3" v-model="showInvalidRegisterCard" variant="danger" dismissible>
                        <font-awesome-icon icon="exclamation-triangle"></font-awesome-icon> Los datos de la tarjeta son inválidos
                    </b-alert>
                    <b-button size="sm" class="my-2 my-sm-3 btn-block" type="submit" variant="dark">Registrarse</b-button>
                </b-col>
            </b-nav-form>
        </b-col>
        
    </div>
</template>

<script>
    import Vuex from 'vuex';
    import axios from 'axios';

    function initialState(){
        return {
            dataRegister: {
                email: '',
                password: '',
                confirmPassword: '',
                name: '',
                surname: '',
                birthday: '',
                cardNumber: '',
                cardSecurityNumber: '',
                cardExpirationDate: {
                    year: null,
                    month: null,
                },
            },
            dataLogin: {
                email: '',
                password: '',
            },
            showInvalidLoginData: false,
            showInvalidRegisterPassword: false,
            showInvalidRegisterCard: false,
        }
    }
    export default {
        name: 'access',
        data() {
            return initialState();
        },
        computed: {
            
        },
        methods: {
            ...Vuex.mapActions([
                'loginUserAction',
            ]),
            years(){
                //Devuelvo los años para el select box
                var currentYear=new Date().getFullYear();
                var years=[];
                for(var i=currentYear;i<=currentYear+10;i++){
                    years.push(i);
                }
                return years;
            },
            months(){
                //Devuelvo los meses para el select box
                return [1,2,3,4,5,6,7,8,9,10,11,12];
            },
            loginUser(){
                axios.post('http://localhost:3000/login', {
                    data: this.dataLogin,
                })
                .then(response => {
                    localStorage.setItem('user',JSON.stringify(response.data.user));
                    localStorage.setItem('jwt',response.data.token);
                    this.loginUserAction(response.data.user);

                    //Recargo la página para que se actualice el listado
                    window.location.reload();

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
                    this.showInvalidLoginData=true;
                })
            },
            registerUser(){
                var validation=this.validateData();
                console.log('pase con error: '+validation.result);
                if(validation.result){
                    console.log(this.dataRegister.cardExpirationDate.year);
                    console.log(this.dataRegister.cardExpirationDate.month);
                    axios.post('http://localhost:3000/register', {
                        data: this.dataRegister,
                    })
                    .then(response => {
                        //crear toast y limpiar formulario
                        this.clearRegistrationForm();
                        this.$bvToast.toast('Su cuenta ha sido creada con éxito.', {
                            title: 'Registro exitoso!',
                            variant: 'success',
                            autoHideDelay: 5000,
                            toaster: 'b-toaster-bottom-right',
                        });
                        this.$emit('closeDropdown');
                    })
                }else{
                    validation.error();
                }
            },
            validateData() {
                //Valido los datos de registro
                //Retorna result - true/false y error - password/card
                if(this.dataRegister.password!=this.dataRegister.confirmPassword) {return {result: false,error: this.showInvalidRegisterPasswordMethod}};
                if(this.dataRegister.cardNumber.length!=18) {return {result: false,error: this.showInvalidRegisterCardMethod}};
                if(this.dataRegister.cardSecurityNumber.length!=3) {return {result: false,error: this.showInvalidRegisterCardMethod}};
                //CHEQUEAR SI ES MAYOR DE EDAD!
                //CHEQUEAR QUE LA TARJETA SEA SOLO DIGITOS AL IGUAL QUE EL CODIGO DE SEGURIDAD!
                if(this.dataRegister.cardExpirationDate.year<new Date().getFullYear()) {return {result: false,error: this.showInvalidRegisterCardMethod}}
                else if(this.dataRegister.cardExpirationDate.year==new Date().getFullYear()){
                    if(this.dataRegister.cardExpirationDate.Month<new Date().getMonth()) {return {result: false,error: this.showInvalidRegisterCardMethod}};
                }
                return {result: true};
            },
            clearRegistrationForm() {
                Object.assign(this.$data, initialState());
            },
            showInvalidRegisterPasswordMethod() {
                this.showInvalidRegisterPassword=true;
            },
            showInvalidRegisterCardMethod() {
                this.showInvalidRegisterCard=true;
            }
        }
    }
</script>

<style>
    .form {
        border:1px solid black;
        border-radius:5px;
        padding:10px;
        margin:10px 0 10px 0;
    }
</style>

