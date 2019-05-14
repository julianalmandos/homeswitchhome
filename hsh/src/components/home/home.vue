<template>
  <div class="home">
    <h1>Propiedades</h1>
    <b-button v-b-modal.editPropertyModal>Editar</b-button>
    <editProperty :property="dataRegisterProperty"/>
    <listOfProperties/>
  </div>
</template>

<script>
// @ is an alias to /src
import editProperty from '@/components/editProperty/editProperty.vue'
import listOfProperties from '@/components/listOfProperties/listOfProperties.vue'
export default {
  name: 'home',
  components: {
     listOfProperties,
     editProperty
  },
  data() {
    return {
      dataRegisterProperty: {
        id: 1,
        description: 'hola',
      }
    }
  }
}
</script>
