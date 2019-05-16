<template>
  <div class="home">
    <listOfProperties/>
  </div>
</template>

<script>
// @ is an alias to /src 
import listOfProperties from '@/components/listOfProperties/listOfProperties.vue'
export default {
  name: 'home',
  components: {
     listOfProperties, 
  }, 
}
</script>
