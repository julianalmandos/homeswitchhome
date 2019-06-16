import Vue from 'vue'
import Router from 'vue-router'
import store from '@/store.js'
import axios from 'axios'

Vue.use(Router)

var router;
export default router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('./components/home/home.vue'),
    },
    {
      path: '/about',
      name: 'about',
      component: () => import('./components/about/about.vue')
    },
    {
      path: '/contact',
      name: 'contact',
      component: () => import('./components/contact/contact.vue')
    },
    {
      path: '/details/:id',
      name: 'details',
      component: () => import('./components/propertyDetails/propertyDetails.vue'),
    },
    {
      path: '/details/:id/edit',
      name: 'edit',
      component: () => import('./components/editProperty/editProperty.vue'),
      meta: {
        requiresAdmin:true,
      }
    },
    {
      path: '/properties/publish',
      name: 'publish',
      component: () => import('./components/publishProperty/publishProperty.vue'),
      meta: {
        requiresAdmin:true,
      }
    },
    {
      path: '/panel',
      name: 'panel',
      component: () => import('./components/administrationPanel/administrationPanel.vue'),
      meta: {
        requiresAdmin:true,
      }
    },
    {
      path: '/panel/properties',
      name: 'panelProperties',
      component: () => import('./components/administrationPanel/listOfProperties.vue'),
      meta: {
        requiresAdmin:true,
      }
    },
    {
      path: '/panel/bookings',
      name: 'panelBookings',
      component: () => import('./components/administrationPanel/listOfBookings.vue'),
      meta: {
        requiresAdmin:true,
      }
    },
    {
      path: '/bookings',
      name: 'bookings',
      component: () => import('./components/bookingsRecord/bookingsRecord.vue'),
      meta: {
        requiresAdmin:true,
      }
    },
  ]
})

router.beforeEach((to, from, next) => {
  //if(localStorage.getItem('jwt')!=null){
    if(to.matched.some(record => record.meta.requiresAdmin)){
      console.log('entra');
      var tokenValido=false;
      axios.post('//localhost:3000/validatetoken', {
        token: localStorage.getItem('jwt')
      })
      .then(response => {
        console.log('response: '+response.data);
        if(response.data){
          if(store.state.user.role==2){
            console.log('sigueentra');
            next();
          }
        }else{
          console.log('sigueelse')
          //desloguear usuario y redirigir a login
          store.dispatch('logoutUserAction');
          next('/');
        }
      })
      .catch(error => {
        console.log(error);
      });
      //chequeo si no esta vencido y dependiendo la ruta hago lo que sea
    }else{
      next();
    }
  //}else{
  //  next();
  //}
})