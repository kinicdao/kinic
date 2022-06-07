import { createApp } from 'vue'
import App from './App.vue'
import './assets/index.css'
import axios from 'axios'
import VueAxios from 'vue-axios'
import 'vue-universal-modal/dist/index.css'
import VueUniversalModal from 'vue-universal-modal'

createApp(App).use(VueAxios, axios).use(VueUniversalModal, {teleportTarget: '#modals'}).mount('#root')
