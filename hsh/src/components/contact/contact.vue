<template>
  <b-container>
    <h1 class="titulo">Contacto</h1>
    <br>
    <h5>¿Tenés alguna duda?<br> ¿Te gustaría que publiquemos alguna de tus propiedades? <br>¿Tenés alguna sugerencia? <br></h5><h4><strong>Contactacte con nosotros!</strong></h4>
    <h6 style="color:red;">* Todos los campos son obligatorios</h6>
    <div class="formulario">
      <form @submit.stop.prevent="sendContactForm()" style="width:60%">
        <b-form-group id="name" :label="'Nombre'" label-for="input-7">
          <b-form-input type="text" v-model="contactData.name" required/>
        </b-form-group>
        <b-form-group id="surname" label="Apellido" label-for="input-1">
            <b-form-input id="text" v-model="contactData.surname" required></b-form-input>
        </b-form-group>
        <b-form-group id="email" :label="'E-Mail'" label-for="input-8">
          <b-form-input type="email"  v-model="contactData.email" required/>
        </b-form-group>
        <label for="message">Tu mensaje</label>
        <b-form-textarea id="message" type="text" v-model="contactData.message" max-rows="5" rows="5" no-resize required>
        </b-form-textarea>
        <br>  
        <b-button type="submit" class="blueButton">Enviar!</b-button>
      </form>
    </div>
  </b-container>
</template>

<script>
  import axios from 'axios';

  export default {
    name: 'contact',
    data(){
      return {
        contactData: {
          name: null,
          surname: null,
          email: null,
          message: '',
        }
      }
    },
    methods: {
      sendContactForm(){
        axios.post('//localhost:3000/contact',{
          data: this.contactData,
        })
        .then(response => {
          this.$bvToast.toast('Su mensaje fue enviado con éxito! Nos contactaremos con usted mediante su e-mail.', {
            title: 'Envío exitoso!',
            variant: 'success',
            autoHideDelay: 10000,
            toaster: 'b-toaster-bottom-right',
          });
          this.resetForm();
        })
        .catch(error => {
          console.log(error);
        })
      },
      resetForm(){
        for(const property in this.contactData){
          this.contactData[property]=null;
        }
      }
    }
  }

</script>

<style>

  .formulario {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

</style>

