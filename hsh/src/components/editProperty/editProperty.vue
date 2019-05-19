<template>
  <div class="editProperty">
    <b-modal
      id="editPropertyModal"
      :title="'Editar Propiedad N°'+property.id"
      ok-title="Editar"
      @ok.prevent="propertyEdition"
    >
      <b-form-group id="descripcion" label="Descripcion" label-for="input-1">
        <b-form-input id="input-1" v-model="description" required></b-form-input>
      </b-form-group>

      <b-card-group class="row">
        <div v-for="(file,index) in images" :key="index">
          <img :src="file" width="125" height="100">
          <b-button
            v-if="file=='https://lightwidget.com/widgets/empty-photo.jpg'"
            size="sm"
            class="my-2 my-sm-3"
            type="submit"
            variant="outline-primary"
            v-on:click="editImage(index)"
          >Agregar</b-button>
          <b-button
            v-if="file!=='https://lightwidget.com/widgets/empty-photo.jpg'"
            size="sm"
            class="my-2 my-sm-3"
            type="submit"
            variant="outline-primary"
            v-on:click="deleteImage(index)"
          >Eliminar</b-button>

          <div id="urlImageInput" style="display:none">
            <form >
              <div class="form-group"> 
                <input type="images[index]" id="images[index]" v-model="images[index]">
              </div>
            </form>

            <b-button
              size="sm"
              class="my-2 my-sm-3"
              type="submit"
              variant="outline-primary"
              v-on:click="confirmImageChange(index)"
            >Confirmar</b-button>
            <b-button
              size="sm"
              class="my-2 my-sm-3"
              type="submit"
              variant="outline-primary"
              v-on:click="displayNone(index)"
            >Cancelar</b-button> 

          </div>

        </div>
      </b-card-group>
      <b-alert class="mt-sm-3" v-model="successfulEdition" variant="success" dismissible>
        <font-awesome-icon icon="check"></font-awesome-icon>La edición fue realizada correctamente
      </b-alert>
      <b-alert class="mt-sm-3" v-model="failEdition" variant="danger" dismissible>
        <font-awesome-icon icon="exclamation-triangle"></font-awesome-icon>No se pudo realizar la edición
      </b-alert>

      <!-- 
        <div class="form-group" v-for="(image, index) of this.imagesArray" :key="index">
        <label for="property-files[index]">Ingrese el link de la imagen</label>
        <input
          v-if="index==0"
          type="files[index]"
          id="files[index]"
          v-model="dataRegisterProperty.files[index]" 
          required
        >
        <input 
          v-else
          type="files[index]"
          id="files[index]"
          v-model="dataRegisterProperty.files[index]"
        >
      -->
    </b-modal>
  </div>
</template>

<script>
import Vuex from "vuex";
import axios from "axios";
export default {
  name: "editProperty",
  props: ["property", "images"],
  data() {
    return {
      description: this.property.description,
      successfulEdition: false,
      failEdition: false,
      arrayAux: new Array(5),
    };
  },
  beforeMount() { 
    for (var i = this.images.length; i < 5; i++) {
      this.images[i] = "https://lightwidget.com/widgets/empty-photo.jpg";
    }
    axios
          .post(
            "http://localhost:3000/sendMail",
            {
                hola: "Hola"
            }
          )
  },
  mounted() {
    this.$root.$on("bv::modal::hidden", (bvEvent, modalId) => {
      this.resetModal();
    });
  },
  methods: {
    confirmImageChange(index){
      this.images[index]=this.arrayAux[index];
      this.arrayAux[index]="";
      var element = document.getElementById("urlImageInput");
     element.style.display = "none";
     axios
          .post(
            "http://localhost:3000/properties/" + this.property.id + "/edit/images",
            {
              data: {
                image: this.images[index]
              }
            }
          )
    },
    displayNone(index){
      this.images[index]="https://lightwidget.com/widgets/empty-photo.jpg";
     var element = document.getElementById("urlImageInput");
     element.style.display = "none";
     axios
          .post(
            "http://localhost:3000/properties/" + this.property.id + "/edit/images",
            {
              data: {
                image: this.images[index]
              }
            }
          )
   },
    editImage(index) {
      var element = document.getElementById("urlImageInput");
     element.style.display = "block";
    },
    deleteImage(index) {
      this.images[index] = "https://lightwidget.com/widgets/empty-photo.jpg";
    },
    propertyEdition() {
      var contador = 0;
      this.images.forEach(element => {
        if (element == "https://lightwidget.com/widgets/empty-photo.jpg") {
          contador++;
        }
      });
      if (contador !== 5) {
        this.successfulEdition = true;
        axios
          .post(
            "http://localhost:3000/properties/" + this.property.id + "/edit",
            {
              data: {
                description: this.description,
                files: this.images
              }
            }
          )
          .then(response => {
            console.log("Propiedad editada correctamente");
            this.$emit("edited");
          })
          .catch(error => {
            console.log(error);
          });
      } else {
        this.failEdition = true;
      }
    },
    resetModal() {
      this.successfulEdition = false;
      this.failEdition = false;
      this.description = this.property.description;
      this.arrayAux = new Array(5)
    }
  }
};
</script>


