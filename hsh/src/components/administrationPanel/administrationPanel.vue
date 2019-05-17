<template>
  <div class="administration-panel">
    <b-container>
      <h1>Panel de Administración</h1><br>
      <b-card-group deck>
          <b-card class="tarjeta text-center" style="width:500px;" @click="openPropertiesList" bg-variant="light" border-variant="dark">
              <font-awesome-icon class="fa-5x" icon="list-alt"></font-awesome-icon>
              <b-card-text style="font-size:25px">Ver listado de propiedades</b-card-text>
          </b-card>
          <b-card class="tarjeta text-center" @click="openBookingList" bg-variant="light" border-variant="dark">
              <font-awesome-icon class="fa-5x" icon="calendar-alt"></font-awesome-icon>
              <b-card-text style="font-size:25px">Ver listado de reservas</b-card-text>
          </b-card>
          <b-card class="tarjeta text-center" @click="openPublishProperty" bg-variant="light" border-variant="dark">
              <font-awesome-icon class="fa-5x" icon="home"></font-awesome-icon>
              <b-card-text style="font-size:25px">Publicar propiedad</b-card-text>
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
      this.$router.push('/administration/listOfProperties');
    },
    openBookingList() {
      this.$router.push('/administration/listOfBookings');
    },
    openPublishProperty() {
      this.$router.push('/properties/publish');
    }
  }
}

</script>

<style scoped>
  .tarjeta:hover {
    background-color:#EEEEEE!important;
    cursor: pointer;
  }

  /*.tarjeta:hover {
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    cursor: pointer;
  }*/
</style>


