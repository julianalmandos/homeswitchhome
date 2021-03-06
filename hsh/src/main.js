import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faUser, faTable, faCog, faSignOutAlt, faPlus, faMinus, faExchangeAlt, faCheck, faExclamationTriangle, faCalendarAlt, faListAlt, faHome, faBook, faReply, faBan, faStar, faMedal, faGavel, faCalendarPlus, faMoneyCheck, faUserAlt, faUsers, faQuestionCircle, faArchway, faDollarSign, faGlobeAmericas, faMapSigns, faMapMarkerAlt,faMap,faHeart, faHeartBroken} from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

library.add(faUser,faTable,faCog,faSignOutAlt,faPlus,faMinus,faExchangeAlt,faCheck,faExclamationTriangle,faCalendarAlt,faListAlt,faHome,faBook,faReply,faBan,faStar,faMedal,faGavel,faCalendarPlus,faMoneyCheck,faUserAlt,faUsers,faQuestionCircle,faArchway,faDollarSign, faGlobeAmericas, faMapSigns,faMapMarkerAlt, faMap,faHeart, faHeartBroken)

Vue.component('font-awesome-icon', FontAwesomeIcon)
Vue.use(BootstrapVue)
Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
