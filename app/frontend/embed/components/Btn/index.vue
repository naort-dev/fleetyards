<template>
  <component
    :is="btnType"
    v-bind="btnProps"
    :class="cssClasses"
    :disabled="disabled || loading"
  >
    <BtnInner :loading="loading">
      <slot />
    </BtnInner>
  </component>
</template>

<script lang="ts">
import Vue from "vue";
import { Component, Prop } from "vue-property-decorator";
import { RouteConfig } from "vue-router";
import BtnInner from "@/embed/components/Btn/Inner/index.vue";

@Component({ components: { BtnInner } })
export default class Btn extends Vue {
  @Prop({ default: false }) loading!: boolean;

  @Prop({ default: null }) to!: RouteConfig;

  @Prop({ default: null }) href!: string;

  @Prop({
    default: "button",
    validator(value) {
      return ["button", "submit"].indexOf(value) !== -1;
    },
  })
  type!: string;

  @Prop({
    default: "default",
    validator(value) {
      return ["default", "transparent", "link", "danger"].indexOf(value) !== -1;
    },
  })
  variant!: string;

  @Prop({
    default: "default",
    validator(value) {
      return ["default", "small", "large"].indexOf(value) !== -1;
    },
  })
  size!: string;

  @Prop({ default: false }) exact!: boolean;

  @Prop({ default: false }) block!: boolean;

  @Prop({ default: false }) mobileBlock!: boolean;

  @Prop({ default: false }) inline!: boolean;

  @Prop({ default: false }) textInline!: boolean;

  @Prop({ default: false }) active!: boolean;

  @Prop({ default: false }) disabled!: boolean;

  get btnType() {
    if (this.to) return "router-link";

    if (this.href) return "a";

    return "button";
  }

  get btnProps() {
    if (this.to) {
      return {
        to: this.to,
        exact: this.exact,
      };
    }

    if (this.href) {
      return {
        href: this.href,
        target: "_blank",
        rel: "noopener",
      };
    }

    return {
      type: this.type,
    };
  }

  get cssClasses() {
    return {
      "panel-btn": true,
      "panel-btn-submit": this.type === "submit",
      "panel-btn-transparent": this.variant === "transparent",
      "panel-btn-link": this.variant === "link",
      "panel-btn-danger": this.variant === "danger",
      "panel-btn-small": this.size === "small",
      "panel-btn-large": this.size === "large",
      "panel-btn-block": this.block,
      "panel-btn-inline": this.inline,
      "panel-btn-text-inline": this.textInline,
      "panel-btn-mobile-block": this.mobileBlock,
      active: this.active,
    };
  }
}
</script>
