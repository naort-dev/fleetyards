<template>
  <transition name="back-to-top-fade">
    <div class="primary-action">
      <div
        v-tooltip="label"
        :aria-label="label"
        class="primary-action-item"
        @click="action"
      >
        <div class="primary-action-inner">
          <i :class="icon" />
        </div>
      </div>
    </div>
  </transition>
</template>

<script lang="ts">
import Vue from "vue";
import { Component, Prop } from "vue-property-decorator";

@Component
export default class Panel extends Vue {
  @Prop({ default: "fal fa-plus" }) icon!: string;

  @Prop({ required: true }) action!;

  @Prop({ default: null }) label!: string;
}
</script>
