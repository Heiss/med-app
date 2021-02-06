<template>
  <v-container flex>
    <v-snackbar v-model="snackbar" :color="color">
      {{ status }}
      <template v-slot:action="{ attrs }">
        <v-btn :color="colorBtn" text v-bind="attrs" @click="snackbar = false">
          <translate>Close</translate>
        </v-btn>
      </template>
    </v-snackbar>
    <v-row justify="center">
      <v-col>
        <v-text-field
          v-model="patientName"
          :label="$gettext('patientname')"
          @keydown.enter="sendPatient"
        ></v-text-field></v-col
    ></v-row>
    <v-row justify="center">
      {{ $gettext("Birthdate") }}
    </v-row>
    <v-row>
      <v-col
        ><v-date-picker
          v-model="picker"
          min="1910"
          :max="new Date().toISOString().split('T')[0]"
          :locale="$language.current"
        ></v-date-picker></v-col
    ></v-row>
    <v-row justify="center">
      <v-col
        ><v-btn block color="error" @click="reset" :disabled="blockButtons"
          ><translate>Cancel</translate></v-btn
        ></v-col
      >
      <v-col
        ><v-btn
          block
          color="primary"
          @click="sendPatient"
          :disabled="blockButtons"
          ><translate>Send</translate></v-btn
        >
      </v-col>
    </v-row></v-container
  >
</template>

<script>
import hash from "hash.js";

export default {
  data: () => ({
    patientName: "",
    picker: null,
    snackbar: false,
    status: "",
    entryAllow: false,
    blockButtons: false,
  }),
  computed: {
    color() {
      return this.entryAllow ? "primary" : "error";
    },
    colorBtn() {
      return !this.entryAllow ? "primary" : "error";
    },
  },
  methods: {
    reset() {
      this.patientName = "";
      this.picker = null;
    },
    sendPatient() {
      let self = this;
      if (this.patientName === "" || this.picker === null) {
        this.status = this.$gettext("Please fill out all data.");
        this.entryAllow = false;
        this.snackbar = true;
      } else {
        let data = {
          patientName: this.patientName,
          patientBDay: this.picker,
        };

        this.blockButtons = true;
        this.$http
          .post("http://localhost:5000/", {
            hash: hash
              .sha256()
              .update(JSON.stringify(data))
              .digest("hex"),
          })
          .then(function(response) {
            console.log(response.data.canPass);
            self.entryAllow = response.data.canPass;
            self.status = response.data.canPass
              ? self.$gettext("Can pass")
              : self.$gettext("Given patient had already maximal visitors.");
            self.snackbar = true;
          })
          .catch(function(error) {
            console.log(error);
          })
          .then(function() {
            self.blockButtons = false;
          });
      }
    },
  },
};
</script>
