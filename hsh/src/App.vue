<template>
  <div id="pageBackground">
    <div id="app">
      <toolbar/>
      <router-view class="mt-sm-5"/>
    </div>
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

<style scoped>
  #app {
    margin: 0px 100px 0px 100px;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    background-color:white;
  }
  #pageBackground {
    background-color:rgba(0,161,225,0.7);
  }
</style>
