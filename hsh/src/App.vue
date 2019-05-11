<template>
  <div id="app">
    <toolbar/>
  </div>

</template>

<script>
  import Vuex from 'vuex';
  import access from '@/components/access/access.vue';
  import listOfProperties from '@/components/listOfProperties/listOfProperties.vue'
  import toolbar from '@/components/toolbar/toolbar.vue'
  export default {
    components: {
      toolbar,
      listOfProperties
    }}
</script>