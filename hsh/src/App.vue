<template>
  <div id="pageBackground">
    <div id="app">
      <toolbar/>
      <router-view class="mt-sm-5 pb-sm-5"/>
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
    box-shadow: 0px 10px 25px 3px rgba(0,0,0,0.75);
    background-color:white;
  }
  #pageBackground {
    background-color:rgba(0,161,225,0.5);
  }
</style>
