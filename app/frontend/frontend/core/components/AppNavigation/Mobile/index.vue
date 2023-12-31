<template>
  <div class="navigation-mobile noselect">
    <div v-if="$route.name" class="navigation-items">
      <template v-if="isFleetRoute && currentFleet">
        <Btn
          variant="link"
          size="large"
          :inline="true"
          :to="{ name: 'fleet', params: { slug: currentFleet.slug } }"
          :image="currentFleet.logo"
          :class="{ active: routeActive('fleet') }"
          exact
        >
          <img
            v-if="currentFleet.logo"
            :src="currentFleet.logo"
            :alt="`${currentFleet.name} image`"
            class="navigation-item-image"
          />
          <span v-else class="nav-item-image-empty">
            {{ firstLetter }}
          </span>
        </Btn>
        <Btn
          v-if="currentFleet.publicFleet || currentFleet.myFleet"
          variant="link"
          size="large"
          :inline="true"
          :to="{ name: 'fleet-ships', params: { slug: currentFleet.slug } }"
          :class="{ active: shipsNavActive }"
          :active="shipsNavActive"
        >
          <i class="fad fa-starship" />
        </Btn>
        <template v-if="currentFleet.myFleet">
          <Btn
            variant="link"
            size="large"
            :inline="true"
            :to="{ name: 'fleet-members', params: { slug: currentFleet.slug } }"
            :class="{ active: routeActive('fleet-members') }"
          >
            <i class="fad fa-users" />
          </Btn>
          <Btn
            variant="link"
            size="large"
            :inline="true"
            :to="{
              name: 'fleet-settings',
              params: { slug: currentFleet.slug },
            }"
            :class="{ active: routeActive('fleet-settings') }"
          >
            <i class="fad fa-cogs" />
          </Btn>
        </template>
      </template>
      <template v-else>
        <Btn
          variant="link"
          size="large"
          :inline="true"
          :to="{ name: 'home' }"
          :class="{ active: routeActive('home') }"
          :exact="true"
        >
          <i class="fad fa-home-alt" />
        </Btn>
        <Btn
          variant="link"
          size="large"
          :inline="true"
          :to="{
            name: 'models',
            query: filterFor('models'),
          }"
        >
          <i class="fad fa-starship" />
        </Btn>
        <Btn
          variant="link"
          size="large"
          :inline="true"
          :to="{ name: 'search' }"
        >
          <i class="fa fa-search" />
        </Btn>
        <Btn
          v-if="isAuthenticated || !hangarPreview"
          variant="link"
          size="large"
          :inline="true"
          :to="{
            name: 'hangar',
            query: filterFor('hangar'),
          }"
        >
          <i class="fad fa-warehouse" />
        </Btn>
        <Btn
          v-else
          variant="link"
          size="large"
          :inline="true"
          :to="{ name: 'hangar-preview' }"
        >
          <i class="fal fa-warehouse" />
        </Btn>
      </template>
      <button
        :class="{
          collapsed: navCollapsed,
        }"
        class="nav-toggle"
        type="button"
        aria-label="Toggle Navigation"
        @click.stop.prevent="toggle"
      >
        <span class="sr-only">
          {{ $t("labels.toggleNavigation") }}
        </span>
        <span class="icon-bar top-bar" />
        <span class="icon-bar middle-bar" />
        <span class="icon-bar bottom-bar" />
      </button>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { Component } from "vue-property-decorator";
import { Getter, Action } from "vuex-class";
import Btn from "@/frontend/core/components/Btn/index.vue";
import { isFleetRoute } from "@/frontend/utils/Routes/Fleets";
import fleetsApiCollection from "@/frontend/api/collections/Fleets";

@Component<NavigationHeader>({
  components: {
    Btn,
  },
})
export default class NavigationHeader extends Vue {
  @Getter("mobile") mobile;

  @Getter("filters") filters;

  @Getter("navCollapsed", { namespace: "app" }) navCollapsed!: boolean;

  @Getter("isAuthenticated", { namespace: "session" })
  isAuthenticated!: boolean;

  @Getter("preview", { namespace: "hangar" }) hangarPreview;

  @Action("toggleNav", { namespace: "app" }) toggle;

  fleetsCollection: FleetsCollection = fleetsApiCollection;

  get isFleetRoute() {
    return isFleetRoute(this.$route.name);
  }

  get currentFleet(): Fleet | null {
    return this.fleetsCollection.record;
  }

  get shipsNavActive() {
    return ["fleet-ships", "fleet-fleetchart"].includes(this.$route.name);
  }

  get firstLetter() {
    return this.currentFleet?.name?.charAt(0);
  }

  filterFor(route) {
    // // TODO: disabled until vue-router supports navigation to same route
    // return null
    if (!this.filters[route]) {
      return null;
    }

    return {
      q: this.filters[route],
    };
  }

  routeActive(route) {
    return route === this.$route.name;
  }

  mounted() {
    this.fetchFleet();
    this.$comlink.$on("fleet-update", this.fetchFleet);
  }

  async fetchFleet() {
    if (!this.isFleetRoute) {
      return;
    }

    await this.fleetsCollection.findBySlug(this.$route.params.slug);
  }
}
</script>
