<template>
  <Panel :id="id || item.slug" class="station-item">
    <div class="panel-image text-center">
      <router-link
        :key="item.storeImageMedium"
        v-lazy:background-image="item.storeImageMedium"
        :to="route"
        :aria-label="item.name"
        class="lazy"
      />
    </div>
    <h2 class="panel-title">
      <router-link :to="route" :aria-label="item.name">
        {{ item.name }}
      </router-link>
    </h2>
  </Panel>
</template>

<script>
import Panel from "@/frontend/core/components/Panel/index.vue";

export default {
  name: "PlanetsPanel",

  components: {
    Panel,
  },

  props: {
    item: {
      type: Object,
      required: true,
    },
    route: {
      type: Object,
      required: true,
    },
    id: {
      type: String,
      default: null,
    },
  },
};
</script>

<style lang="scss">
@import "index";
</style>
