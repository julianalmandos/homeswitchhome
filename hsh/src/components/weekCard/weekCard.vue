<template>
    <div class= "weekCard">
        <b-card border-variant="light" header="Semana"  class="text-center">
            <b-card-text>

                <b-button block variant="outline-primary">Abrir subasta</b-button>
                <b-button block variant="outline-primary">Pujar</b-button>
            </b-card-text>
        </b-card>
    </div>
</template>
<script>
    import { mapState } from "vuex";

    export default {
        name: "weekCard",
        data() {
        return{
          week:{},      
        }
      },
    };
</script>