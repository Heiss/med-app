import Vue from 'vue'
import VueRouter from 'vue-router'
import "@/translations"

Vue.use(VueRouter)

let vm = new Vue()

function load(component) {
  return () => import(/* webpackChunkName: "[request]" */ `@/views/${component}.vue`)
}

const routes = [
  {
    path: '/',
    name: vm.$gettext('Home'),
    component: load("Home"),
    icon: "mdi-home"
  },
  {
    path: '/patient',
    name: vm.$gettext('Patient'),
    component: load("Patient"),
    icon: "mdi-pen"
  },
  {
    path: '/settings',
    name: vm.$gettext('Settings'),
    component: load("Settings"),
    icon: "mdi-cog"
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
