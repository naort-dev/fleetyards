<template>
  <ul class="nav-bottom">
    <NavItem
      v-if="!mobile"
      :action="toggleSlim"
      :label="toggleSlimLabel"
      :icon="
        slim ? 'fal fa-chevron-double-right' : 'fal fa-chevron-double-left'
      "
    />
    <UserNav v-if="isAuthenticated" />
    <NavItem
      v-else
      key="user-menu-guest"
      :to="{ name: 'login' }"
      :label="$t('nav.login')"
      icon="fal fa-sign-in"
    />
  </ul>
</template>

<script>
import { mapGetters } from "vuex";
import NavigationMixin from "@/frontend/mixins/Navigation";
import NavItem from "../NavItem/index.vue";
import UserNav from "../UserNav/index.vue";

export default {
  name: "NavFooter",

  components: {
    NavItem,
    UserNav,
  },

  mixins: [NavigationMixin],

  computed: {
    ...mapGetters(["mobile"]),

    ...mapGetters("app", ["navSlim"]),

    slim() {
      return this.navSlim && !this.mobile;
    },

    toggleSlimLabel() {
      if (this.slim) {
        return this.$t("nav.toggleSlimExpand");
      }

      return this.$t("nav.toggleSlimCollapse");
    },
  },

  methods: {
    toggleSlim() {
      this.$store.commit("app/toggleSlimNav");
    },
  },
};
</script>
