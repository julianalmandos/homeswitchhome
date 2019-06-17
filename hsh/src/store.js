import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import router from './router';

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: null,
  },
  plugins: [createPersistedState({
    paths: ['user'],
  })],
  mutations: {
    loginUserMutation(state, data) {
      state.user = data;
    },
    logoutUserMutation(state) {
      state.user = null;
    },
    listPropertiesMutation(state, data) {
      state.properties = data;
    }

  },
  actions: {
    loginUserAction({ commit }, data) {
      commit('loginUserMutation', data);
    },
    logoutUserAction({ commit }) {
      localStorage.removeItem('jwt');
      localStorage.removeItem('user');
      commit('logoutUserMutation');
      //Lo llevo a la pantalla principal y despues recargo así se actualiza el listado.
      router.push('/');
    },
    listProperties({ commit }, data) {
      commit('listPropertiesMutation', data);
    },
  }
})
