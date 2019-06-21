<template>
  <div class="administration-panel">
    <b-container>
      <h1 class="titulo">Panel de Administración</h1>
      <br>
      <b-card-group deck>
        <b-card class="tarjeta text-center" @click="openPropertiesList" bg-variant="light">
          <font-awesome-icon class="fa-5x" icon="list-alt"></font-awesome-icon>
          <b-card-text style="font-size:25px">Ver listado de propiedades</b-card-text>
        </b-card>
        <b-card class="tarjeta text-center" @click="openBookingList" bg-variant="light">
          <font-awesome-icon class="fa-5x" icon="calendar-alt"></font-awesome-icon>
          <b-card-text style="font-size:25px">Ver listado de reservas</b-card-text>
        </b-card>
        <b-card class="tarjeta text-center" @click="openPublishProperty" bg-variant="light">
          <font-awesome-icon class="fa-5x" icon="home"></font-awesome-icon>
          <b-card-text style="font-size:25px">Publicar propiedad</b-card-text>
        </b-card>
      </b-card-group>
      <br>
      <b-card-group deck>
        <b-card class="tarjeta text-center" @click="openNormalRequests" bg-variant="light">
            <font-awesome-icon class="fa-5x" icon="star"></font-awesome-icon>
            <b-card-text style="font-size:25px">Solicitudes Normales</b-card-text>
        </b-card>
        <b-card class="tarjeta text-center" @click="openPremiumRequests" bg-variant="light">
            <font-awesome-icon class="fa-5x" icon="star" style="color:#e6e600;"></font-awesome-icon>
            <b-card-text style="font-size:25px">Solicitudes Premium</b-card-text>
        </b-card>
        <b-card class="tarjeta text-center" @click="chargeSubscription" bg-variant="light">
            <font-awesome-icon class="fa-5x" icon="money-check"></font-awesome-icon>
            <b-card-text style="font-size:25px">Cobrar suscripcion</b-card-text>
        </b-card>
      </b-card-group>
      <br>
      <b-card-group deck>
        <b-card class="tarjeta text-center" @click="generateWeeks" bg-variant="light">
          <font-awesome-icon class="fa-5x" icon="calendar-plus"></font-awesome-icon>
          <b-card-text style="font-size:25px">Generar semanas</b-card-text>
        </b-card>
        <b-card class="tarjeta text-center" @click="openAuctions" bg-variant="light">
          <font-awesome-icon class="fa-5x" icon="gavel"></font-awesome-icon>
          <b-card-text style="font-size:25px">Abrir subastas</b-card-text>
        </b-card>
        <b-card class="tarjeta text-center" @click="closeAuction" bg-variant="light" >
            <font-awesome-icon class="fa-5x" icon="gavel"></font-awesome-icon>
            <b-card-text style="font-size:25px">Cerrar subastas</b-card-text>
        </b-card>
      </b-card-group>
    </b-container>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "administrationPanel",
  methods: {
    openPropertiesList() {
      this.$router.push("/panel/properties");
    },
    openBookingList() {
      this.$router.push("/panel/bookings");
    },
    openPublishProperty() {
      this.$router.push('/properties/publish');
    },
    openNormalRequests() {
      this.$router.push('/panel/normal_requests');
    },
    openPremiumRequests() {
      this.$router.push('/panel/premium_requests');
    },
    closeAuction(){
      axios
          .get("http://localhost:3000/closeAuctions")
          .then(response => {
            this.$bvToast.toast(
              `Se cerraron ${response.data.length} subastas`,
              {
                title: "Operación Exitosa",
                variant: "success",
                autoHideDelay: 5000,
                toaster: "b-toaster-bottom-right"
              }
            );
            this.selectWinner(response.data)
          })
          .catch(error => {
            console.error(error);
          });
    },
    selectWinner(closed){
      console.log("entre")
      closed.forEach(element => {
        axios.post("http://localhost:3000/selectWinner",{
          data: {
              week: element
          }
        })
        .then(response => {
           console.log(response.data); 
        })  
      })
    },
    generateWeeks() {
      axios
        .get("http://localhost:3000/properties/generateWeeks")
        .then(response => {
          this.$bvToast.toast(
            `Se generaron ${response.data} semanas`,
            {
              title: "Operación Exitosa",
              variant: "success",
              autoHideDelay: 5000,
              toaster: "b-toaster-bottom-right"
            }
          );
        })
        .catch(error => {
          console.error(error);
        });
    },
    openAuctions() {
      axios
        .get("http://localhost:3000/properties/openAuctions")
        .then(response => {
          this.$bvToast.toast(
            `Se abrieron ${response.data} subastas`,
            {
              title: "Operación Exitosa",
              variant: "success",
              autoHideDelay: 5000,
              toaster: "b-toaster-bottom-right"
            }
          );
        })
        .catch(error => {
          console.error(error);
        });
    },
    chargeSubscription(){
      axios
        .get("http://localhost:3000/chargeSubscription")
        .then(response => {
          if (response.data.data>0){
          this.$bvToast.toast(
            `Se cobró la suscripción: $`+ response.data.data,
            {
              title: "Operación Exitosa",
              variant: "success",
              autoHideDelay: 5000,
              toaster: "b-toaster-bottom-right"
            }
          );
          }else {
            this.$bvToast.toast(
            `Ya se cobró la suscripción este mes`,
            {
              title: "Operación Fallida",
              variant: "danger",
              autoHideDelay: 5000,
              toaster: "b-toaster-bottom-right"
            }
          );
          }
        })
        .catch(error => {
          console.error(error);
        });
      
    }
  }
}
</script>

<style scoped>
/*.tarjeta:hover {
    background-color:#EEEEEE!important;
    cursor: pointer;
  }*/

.tarjeta:hover {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
  cursor: pointer;
}
</style>


