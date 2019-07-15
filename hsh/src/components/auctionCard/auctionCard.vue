<template>
    <div class=auctionCard>
    <b-card no-body class="overflow-hidden" style="max-width: 540px;margin-left:1.25rem">
        <b-row no-gutters>
            <b-col md="6">
            <b-card-img :src="image.image" class="rounded-0"></b-card-img>
            </b-col>
            <b-col md="6">
            <b-card-body >
                <b-card-text>
                    <h4 slot="header">{{property.name}} </h4>
                    <br>
                    <h4>Semana: {{(auction.date).substring(0,10)}}</h4>
                    <br>
                    <b-button class="transparentButton btn-block" :to="'/details/'+auction.idProperty+'/no/no'">Ver Propiedad</b-button>
                </b-card-text>
            </b-card-body>
            </b-col>
        </b-row>
    </b-card>
    </div>
</template>

<script>
import axios from "axios";
import placeABid from '@/components/placeABid/placeABid.vue';

export default {
  name: "auctionCard",
  props: ["auction"],
  components: {
            placeABid,
  },
  data() {
    return {
      image: {},
      property: {}
    };
  },
  methods:{
    openPlaceABidModal() {
        this.$emit('placingBid',this.auction);
    },
   },
  created() {
    axios
      .get("http://localhost:3000/images/" + this.auction.idProperty)
      .then(response => {
        this.image = response.data[0];
      })
      .catch(error => {
        console.log(error);
      });
    axios
      .get("http://localhost:3000/properties/" + this.auction.idProperty)
      .then(response => {
        this.property = response.data[0];
      })
      .catch(error => {
        console.log(error);
      });
}
};
</script>
