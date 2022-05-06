import { createApp } from 'vue'
import App from './App.vue'
import './assets/index.css'
import axios from 'axios'
import VueAxios from 'vue-axios'

createApp(App).use(VueAxios, axios).mount('#root')
