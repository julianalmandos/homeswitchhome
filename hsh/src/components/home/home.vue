<template>
  <div class="home">
    <h1>Propiedades</h1>
    <listOfProperties/>
    <publishProperty/>
  </div>
</template>

<script>
// @ is an alias to /src
import publishProperty from '@/components/publishProperty/publishProperty.vue';
import listOfProperties from '@/components/listOfProperties/listOfProperties.vue';
export default {
  name: 'home',
  components: {
     listOfProperties,
     publishProperty
  }
}
</script>
