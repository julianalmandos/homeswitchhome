import Vue from 'vue'
import Vuex from 'vuex'
import router from './router';

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: null,
    properties: [
      {
        nombre: "Mi casa",
        direccion: "172 n°3750"
      },
      {
        nombre: "Casa de Franco",
        direccion: "Barrio Juan B. Justo, manzana 9 n°238"
      },
      {
        nombre: "Casa del abuelo de Oriana Arevalos",
        direccion: "Haramboure entre Contarelli y Saavedra n°300"
      }
    ],
  },
  mutations: {
    loginUserMutation(state, data) {
      state.user = data;
    },
    logoutUserMutation(state) {
      state.user = null;
    },

  },
  actions: {
    loginUserAction({ commit }, data) {
      commit('loginUserMutation', data);
    },
    logoutUserAction({ commit }) {
      localStorage.removeItem('jwt');
      localStorage.removeItem('user');
      commit('logoutUserMutation');
      router.push('');
    }
  }
})
