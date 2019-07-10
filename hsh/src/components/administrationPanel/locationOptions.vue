<template>
  <div class="location-options">
    <b-container>
      <h1 class="titulo">Agregar Ubicación</h1>
      <br>
      <b-card-group deck>
        <b-card class="tarjeta text-center" bg-variant="light">
          <font-awesome-icon class="fa-5x" icon="list-alt"></font-awesome-icon>
          <b-card-text style="font-size:25px">Agregar país</b-card-text>
        </b-card>
        <b-card class="tarjeta text-center" bg-variant="light">
          <font-awesome-icon class="fa-5x" icon="calendar-alt"></font-awesome-icon>
          <b-card-text style="font-size:25px">Agregar provincia</b-card-text>
        </b-card>
        <b-card class="tarjeta text-center" bg-variant="light">
          <font-awesome-icon class="fa-5x" icon="home"></font-awesome-icon>
          <b-card-text style="font-size:25px">Agregar localidad</b-card-text>
        </b-card>
      </b-card-group>
    </b-container>
  </div>
</template>

<script>

//export default {
 // name: "locationOptions",
 // methods: {
    
  //}
//};
</script>

<style scoped>

.tarjeta:hover {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
  cursor: pointer;
}
</style>