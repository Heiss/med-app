<template>
  <v-app id="inspire">
    <v-navigation-drawer v-model="drawer" app>
      <v-sheet class="flex-direction row pa-4">
        <v-container fill-height
          ><v-row no-gutters align="center" justify="center">
            <v-col
              ><v-avatar class="mb-4" color="green darken-3" size="64">
                <v-img src="@/assets/logo.png"/></v-avatar
            ></v-col>
            <v-col fill-height="true"><h3>Med App</h3></v-col></v-row
          >
        </v-container>
      </v-sheet>

      <v-divider></v-divider>

      <v-list>
        <v-list-item-group v-model="model" mandatory color="indigo">
          <v-list-item v-for="(item, i) in views" :key="i" :to="item.path">
            <v-list-item-icon>
              <v-icon v-text="item.icon" />
            </v-list-item-icon>

            <v-list-item-content>
              <v-list-item-title v-text="item.name"></v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>

    <v-app-bar app>
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>

      <v-toolbar-title>Application</v-toolbar-title>
    </v-app-bar>

    <v-main>
      <v-container fluid> <router-view /> </v-container>
    </v-main>
  </v-app>
</template>

<script>
import router from "./router/index.js";
import Vue from "vue";

export default {
  name: "App",
  data: () => ({ drawer: null, views: router.options.routes, model: null }),
  beforeMount: function() {
    let language = this.getLanguage;
    console.log(language)
    if (language == undefined) {
      const ll_CC = navigator.language || navigator.userLanguage;
      language = ll_CC.split("-", 1)[0];
    }
    console.log(language)
    if (!Object.prototype.hasOwnProperty.call(Vue.$translations, language)) {
      import("@/translations/" + language + ".json").then((locale) => {
        this.$language.merge(locale);
        this.$language.current = language;
      });
    } else {
      this.$language.current = language;
    }
  },
};
</script>
