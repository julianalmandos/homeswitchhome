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
        requiresAdmin: true,
      }
    },
    {
      path: '/properties/publish',
      name: 'publish',
      component: () => import('./components/publishProperty/publishProperty.vue'),
      meta: {
        requiresAdmin: true,
      }
    },
    {
      path: '/auctions',
      name: 'activeAuctions',
      component: () => import('./components/listOfAuctions/listOfAuctions.vue'),
      meta: {
        requiresAuth:true,
      }
    },
    {
      path: '/panel',
      name: 'panel',
      component: () => import('./components/administrationPanel/administrationPanel.vue'),
      meta: {
        requiresAdmin: true,
      }
    },
    {
      path: '/edit/profile',
      name: 'editProfile',
      component: () => import('./components/profile/editProfile.vue'),
    },
    {
      path: '/profile',
      name: 'showProfile',
      component: () => import('./components/profile/profile.vue'),
    },
    {
      path: '/panel/properties',
      name: 'panelProperties',
      component: () => import('./components/administrationPanel/listOfProperties.vue'),
      meta: {
        requiresAdmin: true,
      }
    },
    {
      path: '/panel/bookings',
      name: 'panelBookings',
      component: () => import('./components/administrationPanel/listOfBookings.vue'),
      meta: {
        requiresAdmin: true,
      }
    },
    {
      path: '/bookings',
      name: 'bookings',
      component: () => import('./components/bookingsRecord/bookingsRecord.vue'),
    },
    {
      path: '/become_normal',
      name: 'becomeNormal',
      component: () => import('./components/convertAccount/convertAccountToNormal.vue'),
      meta: {
        requiresAuth:true,
      }
    },
    {
      path: '/become_premium',
      name: 'becomePremium',
      component: () => import('./components/convertAccount/convertAccountToPremium.vue'),
      meta: {
        requiresAuth:true,
      }
    },
    {
      path: '/panel/normal_requests',
      name: 'normalRequests',
      component: () => import('./components/administrationPanel/normalRequests.vue'),
      meta: {
        requiresAdmin:true,
      }
    },
    {
      path: '/panel/premium_requests',
      name: 'premiumRequests',
      component: () => import('./components/administrationPanel/premiumRequests.vue'),
      meta: {
        requiresAdmin:true,
      }
    },
    {
      path: '/recover_password',
      name: 'recoverPassword',
      component: () => import('./components/recoverPassword/recoverPassword.vue')
    },
    {
      path: '/recover_password/:token',
      name: 'changePassword',
      component: () => import('./components/changePassword/changePassword.vue')
    },
  ]
})

router.beforeEach((to, from, next) => {
  //if(localStorage.getItem('jwt')!=null){
  if (to.matched.some(record => record.meta.requiresAdmin)) {
    console.log('entra');
    var tokenValido = false;
    axios.post('//localhost:3000/validatetoken', {
      token: localStorage.getItem('jwt')
    })
      .then(response => {
        console.log('response: ' + response.data);
        if (response.data) {
          if (store.state.user.role == 2) {
            console.log('sigueentra');
            next();
          }
        } else {
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
    }else if(to.matched.some(record => record.meta.requiresAuth)){
      console.log('entra');
      var tokenValido=false;
      axios.post('//localhost:3000/validatetoken', {
        token: localStorage.getItem('jwt')
      })
      .then(response => {
        console.log('response: '+response.data);
        if(response.data){
          if(store.state.user.role==1 || store.state.user.role==0){
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
    }else{
      next();
    }
  //}else{
  //  next();
  //}
})