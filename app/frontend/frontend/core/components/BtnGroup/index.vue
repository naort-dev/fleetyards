<template>
  <div :class="cssClasses">
    <slot />
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { Component, Prop } from "vue-property-decorator";

@Component({})
export default class BtnGroup extends Vue {
  @Prop({ default: false }) inline!: boolean;

  get cssClasses() {
    return {
      "panel-btn-group": true,
      "panel-btn-group-inline": this.inline,
    };
  }
}
</script>
