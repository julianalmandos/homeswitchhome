import Vue from 'vue'
import Vuex from 'vuex'
import router from './router';

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: null,
  },
  mutations: {
    loginUserMutation(state,data){
      state.user=data;
    },
    logoutUserMutation(state){
      state.user=null;
    }
  },
  actions: {
    loginUserAction({commit},data){
      commit('loginUserMutation',data);
    },
    logoutUserAction({commit}){
      localStorage.removeItem('jwt');
      localStorage.removeItem('user');
      commit('logoutUserMutation');
      router.push('');
    }
  }
})
