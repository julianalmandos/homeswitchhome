<template>
    <div class= "weekCard">
        <b-card v-if= ((!week.reserved)) border-variant="light" class="text-center">
            <h5 slot="header">Semana: {{week.date + (new Date).toISOString()}}</h5>
            <b-card-text>
                <b-button v-if= week.auction block variant="outline-primary">Cerrar subasta</b-button>
                <b-button v-else block variant="outline-primary">Abrir subasta</b-button>
                <b-button v-if= week.auction block variant="outline-primary">Pujar</b-button>
            </b-card-text>
        </b-card>
        <b-card v-if= ((week.reserved)) bg-variant="secondary" text-variant="white" class="text-center">
            <h5 slot="header">Semana: {{week.id}}</h5>
            <b-card-text>
            </b-card-text>
        </b-card>

    </div>
</template>
<script>

    export default {
        name: "weekCard",
        props: ["week"],
    };
</script>