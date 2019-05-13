import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('./components/home/home.vue'),
      /*meta: {
        requiresAuth: true,
      }*/
    },
    {
      path: '/acerca-de',
      name: 'acerca-de',
      component: () => import('./components/about/about.vue')
    },
    {
      path: '/contacto',
      name: 'contacto',
      component: () => import('./components/contact/contact.vue')
    },
    {
      path: '/detalle/:id',
      name: 'detalle',
      component: () => import('./components/propertyDetails/propertyDetails.vue')
    }
  ]
})

/*router.beforeEach((to, from, next) => {
  if(localStorage.getItem('jwt')!=null){
    if(to.matched.some(record => record.meta.requiresAuth)){
      console.log('entra');
      var tokenValido=false;
      axios.post('//localhost:3000/validartoken', {
        token: localStorage.getItem('jwt')
      })
      .then(response => {
        console.log('response: '+response.data);
        if(response.data){
          console.log('sigueentra');
          next();
        }else{
          console.log('sigueelse')
          //desloguear usuario y redirigir a login
          store.dispatch('cerrarSesionUsuario');
          next({
            path: '/login',
            params: { nextUrl: to.fullPath }
          });
        }
      });
      console.log('sigue')
      //chequeo si no esta vencido y dependiendo la ruta hago lo que sea
    }else{
      next({
        path: '/',
      });
    }
  }else {
    next({
      path: '/login',
      params: { nextUrl: to.fullPath }
    });
  }
})*/