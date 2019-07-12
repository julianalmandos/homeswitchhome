<template>
  <div class="weekCard">
    <!-- SUBASTA  SUBASTA  SUBASTA  SUBASTA  -->
    <b-card
      v-if="((isInAuction())&(!week.reserved))"
      border-variant="dark"
      class="card2"
      style="max-width: 15rem;margin-bottom:1.25rem"
    >
      <h6>Puja Más Alta: ${{maxBid}}</h6>
      <h5 slot="header">Semana: {{(week.date).substring(0,10)}}</h5>
      <b-card-text>
        <b-button
          class="transparentButton btn-block"
          v-if="(week.auction==1)&(credits())"
          @click="openPlaceABidModal"
        >Pujar</b-button>
        <h6 v-if="week.auction==1 && (!credits())">Usted no posee creditos para pujar</h6>
      </b-card-text>
    </b-card>

    <!-- RESERVA DIRECTA  RESERVA DIRECTA  RESERVA DIRECTA  RESERVA DIRECTA  -->
    <b-card v-if="((isInDirectReservation())&(!week.reserved))" class="card1">
      <h5 slot="header">Semana: {{(week.date).substring(0,10)}}</h5>
      <b-card-text>
        <b-button
          v-if="((!isNormal())&(credits()))"
          class="transparentButton btn-block"
          @click="bookDirectBooking"
        >Reservar</b-button>
        <h6 v-if="((!isNormal())&(!credits()))" h6>Usted no posee creditos para reservar</h6>
        <h6 v-if="(isNormal())" h6>No puede reservar esta semana (comun)</h6>
      </b-card-text>
    </b-card>

    <!-- HOT SALE  HOT SALE  HOT SALE  HOT SALE  -->
    <b-card v-if="((isInHotSale())&(!week.reserved))" class="card3">
      <h6 v-if="(!week.idle)">Precio: ${{week.price}}</h6>
      <h5 slot="header">Semana: {{(week.date).substring(0,10)}}</h5>
      <b-card-text>
        <b-button
          v-if="(!week.idle)"
          class="transparentButton btn-block"
          @click="bookHotSale"
        >Reservar HotSale</b-button>
        <h6 v-if="(week.idle)">No puede ser reservada (ociosa)</h6>
        <b-button
          v-if="((!week.idle)&(isAdmin))"
          class="transparentButton btn-block"
          @click="closeHotSale"
        >Poner en ociosa</b-button>
        <b-button
          v-if="((week.idle)&(isAdmin))"
          class="transparentButton btn-block"
          @click="openHotSaleModal"
        >Poner en HotSale</b-button>
      </b-card-text>
    </b-card>

    <b-card v-if="(week.reserved)" class="card4">
      <h5 slot="header">Semana: {{(week.date).substring(0,10)}}</h5>
    </b-card>
  </div>
</template>
<script>
import Vuex from "vuex";
import axios from "axios";
import placeABid from "@/components/placeABid/placeABid.vue";
import openHotSale from "@/components/openHotSale/openHotSale.vue";

export default {
  name: "weekCard",
  props: ["week"],
  components: {
    placeABid,
    openHotSale
  },
  data() {
    return {
      maxBid: 0,
      property: {},
      idle: 0,
      reserved: 0,
      ok: true,
      hasBooking: false,
      winner: {}
    };
  },
  computed: {
    isAdmin() {
      return this.$store.state.user != null && this.$store.state.user.role == 2;
    }
  },
  created() {
    axios
      .get("http://localhost:3000/weeks/" + this.week.id + "/maxbid")
      .then(response => {
        this.maxBid = response.data.data;
      })
      .catch(error => {
        console.log(error);
      });
    axios
      .get("http://localhost:3000/properties/" + this.$route.params.id)
      .then(response => {
        this.property = response.data[0];
      })
      .catch(error => {
        console.log(error);
      });
  },
  updated() {
    this.reloadMaxBid();
  },
  methods: {
    isNormal() {
      return this.$store.state.user != null && this.$store.state.user.role == 0;
    },
    credits() {
      return this.$store.state.user.credits > 0;
    },
    isInAuction() {
      var actualDate = new Date();
      var actualDate2 = new Date();
      actualDate.setMonth(actualDate.getMonth() + 6);
      actualDate2.setMonth(actualDate2.getMonth() + 6);
      actualDate2.setDate(actualDate2.getDate() - 3);
      return (
        (this.week.date <= actualDate.toISOString().substring(0, 10)) &
        (this.week.date >= actualDate2.toISOString().substring(0, 10))
      );
    },
    isInHotSale() {
      var actualDate = new Date();
      var actualDate2 = new Date();
      actualDate.setMonth(actualDate.getMonth() + 6);
      actualDate.setDate(actualDate.getDate() - 3);
      return (
        (this.week.date < actualDate.toISOString().substring(0, 10)) &
        (this.week.date > actualDate2.toISOString().substring(0, 10))
      );
    },
    isInDirectReservation() {
      var actualDate = new Date();
      var actualDate2 = new Date();
      actualDate.setMonth(actualDate.getMonth() + 12);
      actualDate2.setMonth(actualDate2.getMonth() + 6);
      return (
        (this.week.date <= actualDate.toISOString().substring(0, 10)) &
        (this.week.date > actualDate2.toISOString().substring(0, 10))
      );
    },
    openPlaceABidModal() {
      this.$emit("placingBid", this.week);
    },
    openHotSaleModal() {
      this.$emit("openingHotSale", this.week);
    },
    bookHotSale() {
      if (confirm("¿Esta seguro que desea reservar la propiedad?")) {
        axios
          .post(
            "http://localhost:3000/weeks/" + this.week.id + "/hotSale/booking",
            {
              data: {
                id: this.week.id,
                price: this.week.price,
                type: 2,
                email: this.$store.state.user.email,
                date: this.week.date,
                nameProperty: this.property.name
              }
            }
          )
          .then(response => {
            this.$emit("edited");
            this.$bvToast.toast("La reserva fue exitosa", {
              title: "Operación exitosa",
              variant: "success",
              autoHideDelay: 5000,
              toaster: "b-toaster-bottom-right"
            });
          })
          .catch(error => {
            this.$bvToast.toast(
              "Ya tiene una semana reservada para esa fecha",
              {
                title: "Operación fallida",
                variant: "danger",
                autoHideDelay: 5000,
                toaster: "b-toaster-bottom-right"
              }
            );
          });
      }
    },
    bookDirectBooking() {
      if (confirm("¿Esta seguro que desea reservar la propiedad?")) {
        axios
          .post(
            "http://localhost:3000/weeks/" +
              this.week.id +
              "/directBooking/booking",
            {
              data: {
                id: this.week.id,
                date: this.week.date,
                type: 0,
                email: this.$store.state.user.email,
                nameProperty: this.property.name
              }
            }
          )
          .then(response => {
            this.$emit("edited");
            this.$store.state.user.credits = this.$store.state.user.credits - 1;
            this.$bvToast.toast("La reserva fue exitosa", {
              title: "Operación exitosa",
              variant: "success",
              autoHideDelay: 5000,
              toaster: "b-toaster-bottom-right"
            });
          })
          .catch(error => {
            this.$bvToast.toast(
              "Ya tiene una semana reservada para esa fecha",
              {
                title: "Operación fallida",
                variant: "danger",
                autoHideDelay: 5000,
                toaster: "b-toaster-bottom-right"
              }
            );
          });
      }
    },
    closeHotSale() {
      if (confirm("¿Esta seguro que desea poner la semana en ociosa?")) {
        axios
          .post(
            "http://localhost:3000/weeks/" + this.week.id + "/hotSale/close",
            {
              data: {
                id: this.week.id
              }
            }
          )
          .then(response => {
            this.$emit("edited");
            this.$bvToast.toast("La operación fue realizada con éxito", {
              title: "Operación exitosa",
              variant: "success",
              autoHideDelay: 5000,
              toaster: "b-toaster-bottom-right"
            });
          });
      }
    },
    reloadMaxBid() {
      console.log("reload");
      axios
        .get("http://localhost:3000/weeks/" + this.week.id + "/maxbid")
        .then(response => {
          this.maxBid = response.data.data;
          console.log(response.data.data);
          console.log("relodee");
        })
        .catch(error => {
          console.log(error);
        });
    },
    reloadMaxBid2() {
      console.log("reload");
      axios
        .get("http://localhost:3000/weeks/" + this.week.id + "/maxbid")
        .then(response => {
          this.maxBid = response.data.data;
          console.log(response.data.data);
          console.log("relodee");
          this.closeAuction();
        })
        .catch(error => {
          console.log(error);
        });
    },
    closeAuction: function() {
      if (this.maxBid == this.property.base_price) {
        this.reserved = 0;
        this.idle = 1;
        this.closeAu();
      } else {
        axios
          .get("http://localhost:3000/weeks/" + this.week.id + "/winner")
          .then(response => {
            this.winner = response.data[0];
            console.log("consulte el winner y es: ", this.winner.email);
            this.checkWinner();
          })
          .catch(error => {
            console.log(error);
          });
      }
    },

    closeAu() {
      axios
        .post("http://localhost:3000/closeAuction/" + this.week.id, {
          data: {
            reserved: this.reserved,
            idle: this.idle
          }
        })
        .then(response => {
          this.$emit("edited");
        })
        .catch(error => {
          console.log(error);
        });
    },

    checkWinner() {
      axios
        .post("http://localhost:3000/checkWinner", {
          data: {
            winner: this.winner.email,
            date: this.week.date.substring(0, 10)
          }
        })
        .then(response => {
          this.hasBooking = response.data.data;
          console.log(
            "Me fije si el ganador tiene otras reservas para la misma semana: ",
            this.hasBooking
          );
          this.makeReservation();
        })
        .catch(error => {
          console.log(error);
        });
    },
    makeReservation() {
      if (!this.hasBooking) {
        this.idle = 0;
        this.reserved = 1;
        console.log(this.winner.id);
        axios
          .post("http://localhost:3000/makeReservation/", {
            data: {
              id: this.winner.id,
              email: this.winner.email,
              propertyName: this.property.name,
              date: this.week.date
            }
          })
          .then(response => {
            console.log("guarde la reserva");
          })
          .catch(error => {
            console.log(error);
          });
        this.closeAu();
      } else {
        this.deleteBid();
      }
    },
    deleteBid() {
      axios
        .get("http://localhost:3000/deleteBid/" + this.winner.id)
        .then(response => {
          console.log("elimine maxBid");
          this.reloadMaxBid2();
        })
        .catch(error => {
          console.log(error);
        });
    }

    /*openAuction: function (){
                axios.get("http://localhost:3000/openAuction/"+ this.week.id)
                .then(response => {
                    console.log(response.data);
                    this.$emit('edited');
                })
                .catch(error => {
                    console.log(error);
                }); 

            },*/
  }
};
</script>
<style>
.card1 {
  background-color: #bfbfbf;
  color: #f2f2f2;
  box-shadow: 0px 6px 3px -4px rgba(0, 0, 0, 0.75);
}
.card3 {
  background-color: #ffaaff;
  color: #f2f2f2;
  box-shadow: 0px 6px 3px -4px rgba(0, 0, 0, 0.75);
}
.card2 {
  box-shadow: 0px 6px 3px -4px rgba(0, 0, 0, 0.75);
}
.card4 {
  background-color: #bfbfbf;
  color: #f2f2f2;
  box-shadow: 0px 6px 3px -4px rgba(0, 0, 0, 0.75);
}
</style>