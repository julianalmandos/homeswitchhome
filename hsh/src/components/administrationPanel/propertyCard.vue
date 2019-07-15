<template>
  <b-card
    :img-src="this.image.image"
    img-width="300"
    img-height="200"
    img-alt="Card image"
    img-left
    class="mb-3"
    style="text-align:start;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);"
  >
    <b-card-text>
      <b-row>
        <b-col sm="10">
          <b-row>
            <b-col sm="4">
              <strong>Nombre</strong>
              <br>
              <span
                class="d-inline-block text-truncate"
                style="overflow:hidden;white-space:inherit;"
              >{{this.property.name}}</span>
              <br>
              <strong>Localidad</strong>
              <br>
              <span
                class="d-inline-block"
                style="overflow:hidden;white-space:inherit;"
              >{{this.property.locality}}</span>
            </b-col>
            <b-col sm="3">
              <strong>Ubicación</strong>
              <br>
              <span
                class="d-inline-block"
                style="overflow:hidden;white-space:inherit;"
              >{{this.property.address}}</span>
              <br>
              <strong>Provincia</strong>
              <br>
              <span
                class="d-inline-block"
                style="overflow:hidden;white-space:inherit;"
              >{{this.property.province}}</span>
            </b-col>
            <b-col sm="3">
              <strong>Monto Base</strong>
              <br>
              <span
                class="d-inline-block"
                style="overflow:hidden;white-space:inherit;"
              >${{this.property.base_price}}</span>
              <br>
              <strong>País</strong>
              <br>
              <span
                class="d-inline-block"
                style="overflow:hidden;white-space:inherit;"
              >{{this.property.country}}</span>
            </b-col>
          </b-row>
          <b-row align-h="start">
            <b-col>
              <strong>Descripción:</strong>
              <span style="overflow:hidden;white-space:inherit;">{{this.property.description }}</span>
            </b-col>
          </b-row>
        </b-col>
        <b-col sm="2" align-self="center">
          <b-row>
            <!--
                    <b-button class="btn-block mb-2 blueButton" v-b-modal.editPropertyModal>Editar</b-button>
            -->
            <b-button
              class="btn-block mb-2 blueButton"
              :to="'/details/'+property.id+'/no/no'"
            >
              <font-awesome-icon icon="list-alt"></font-awesome-icon>Ver detalle
            </b-button>
          </b-row>
          <b-row>
            <b-button class="btn-block mb-2 redButton" @click="eliminarPropiedad">
              <font-awesome-icon icon="cog"></font-awesome-icon>Eliminar
            </b-button>
          </b-row>
          <b-row>
            <b-button class="btn-block mb-2 redButton" v-if="!property.disabled" @click="disableProperty">
              <font-awesome-icon icon="cog"></font-awesome-icon>Deshabilitar
            </b-button>
          </b-row>
        </b-col>
      </b-row>
    </b-card-text>
  </b-card>
</template>

<script>
import editProperty from "@/components/editProperty/editProperty.vue";
import axios from "axios";

export default {
  name: "adminPropertyCard",
  components: {
    editProperty
  },
  props: {
    property: {}
  },
  data() {
    return {
      image: {}
    };
  },
  created() {
    axios
      .get("http://localhost:3000/images/" + this.property.id)
      .then(response => {
        this.image = response.data[0];
      })
      .catch(error => {
        console.log(error);
      });
  },
  methods: {
    eliminarPropiedad() {
      if (confirm("¿Esta seguro que desea eliminar esta propiedad?")) {
        axios
          .post("//localhost:3000/properties/" + this.property.id + "/delete")
          .then(response => {
            response.data.forEach(element => {
              axios
                .post("//localhost:3000/cancelBooking", {
                  data: {
                    booking: element,
                    email: element.email,
                  }
                })
            });
            this.$emit("deleted");
          })
      }
    },
    disableProperty(){
      if(confirm("¿Está seguro que desea deshabilitar esta propiedad?")){
          axios.get("http://localhost:3000/disableProperty/" + this.property.id)
          axios.get("http://localhost:3000/eraseFavorites/"+ this.property.id)
          this.$bvToast.toast('La propiedad se deshabilitó exitosamente!', {
            title: 'Operación exitosa',
            variant: 'success',
            autoHideDelay: 5000,
            toaster: 'b-toaster-bottom-right',
          })
          this.$emit("disabled")
      }    
    }
  }
};
</script>

<style scoped>
</style>

