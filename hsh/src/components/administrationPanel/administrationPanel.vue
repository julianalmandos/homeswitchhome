<template>
  <div class="administration-panel">
    <b-container>
      <h1 class="titulo">Panel de Administración</h1><br>
      <b-card-group deck>
          <b-card class="tarjeta text-center" @click="openPropertiesList" bg-variant="light" >
              <font-awesome-icon class="fa-5x" icon="list-alt"></font-awesome-icon>
              <b-card-text style="font-size:25px">Ver listado de propiedades</b-card-text>
          </b-card>
          <b-card class="tarjeta text-center" @click="openBookingList" bg-variant="light" >
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
        <b-card class="tarjeta text-center" bg-variant="light">
            <font-awesome-icon class="fa-5x" icon="money-check"></font-awesome-icon>
            <b-card-text style="font-size:25px">Cobrar suscripcion</b-card-text>
        </b-card>
      </b-card-group>
      <br>
      <b-card-group deck>
        <b-card class="tarjeta text-center" bg-variant="light" >
            <font-awesome-icon class="fa-5x" icon="gavel"></font-awesome-icon>
            <b-card-text style="font-size:25px">Abrir subastas</b-card-text>
        </b-card>
        <b-card class="tarjeta text-center" bg-variant="light" >
            <font-awesome-icon class="fa-5x" icon="gavel"></font-awesome-icon>
            <b-card-text style="font-size:25px">Cerrar subastas</b-card-text>
        </b-card>
        <b-card class="tarjeta text-center" bg-variant="light">
            <font-awesome-icon class="fa-5x" icon="calendar-plus"></font-awesome-icon>
            <b-card-text style="font-size:25px">Generar semanas</b-card-text>
        </b-card>
      </b-card-group>
    </b-container>
  </div>
</template>

<script>

export default {
  name: 'administrationPanel',
  methods: {
    openPropertiesList() {
      this.$router.push('/panel/properties');
    },
    openBookingList() {
      this.$router.push('/panel/bookings');
    },
    openPublishProperty() {
      this.$router.push('/properties/publish');
    },
    openNormalRequests() {
      this.$router.push('/panel/normal_requests');
    },
    openPremiumRequests() {
      this.$router.push('/panel/premium_requests');
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


