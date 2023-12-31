<template>
  <component
    :is="btnType"
    v-bind="btnProps"
    class="panel-btn"
    :class="cssClasses"
    :disabled="disabled || loading"
  >
    <BtnInner :loading="loading" :spinner="spinner">
      <slot />
    </BtnInner>
  </component>
</template>

<script lang="ts" setup>
import BtnInner from "@/frontend/core/components/Btn/Inner/index.vue";
import type { SpinnerAlignment } from "@/frontend/core/components/SmallLoader/index.vue";
import { RawLocation } from "vue-router";

export type BtnVariants =
  | "default"
  | "transparent"
  | "link"
  | "danger"
  | "dropdown";
export type BtnSizes = "default" | "xsmall" | "small" | "large";

export type Props = {
  to?: RawLocation;
  href?: string;
  type?: "button" | "submit";
  loading?: boolean;
  spinner?: boolean | SpinnerAlignment;
  variant?: BtnVariants;
  size?: BtnSizes;
  exact?: boolean;
  block?: boolean;
  mobileBlock?: boolean;
  inline?: boolean;
  textInline?: boolean;
  active?: boolean;
  disabled?: boolean;
  routeActiveClass?: string;
};

const props = withDefaults(defineProps<Props>(), {
  to: undefined,
  href: undefined,
  type: "button",
  loading: false,
  spinner: false,
  variant: "default",
  size: "default",
  exact: false,
  block: false,
  mobileBlock: false,
  inline: false,
  textInline: false,
  active: false,
  disabled: false,
  routeActiveClass: undefined,
});

const btnType = computed(() => {
  if (props.to && !props.disabled) return "router-link";

  if (props.href) return "a";

  return "button";
});

const btnProps = computed(() => {
  if (props.to) {
    return {
      to: props.to,
      exact: props.exact,
      // event: props.disabled ? '' : 'click',
      activeClass: props.routeActiveClass,
    };
  }

  if (props.href) {
    return {
      href: props.href,
      target: "_blank",
      rel: "noopener",
    };
  }

  return {
    type: props.type,
  };
});

const cssClasses = computed(() => ({
  "panel-btn-submit": props.type === "submit",
  "panel-btn-transparent": props.variant === "transparent",
  "panel-btn-link": props.variant === "link",
  "panel-btn-danger": props.variant === "danger",
  "panel-btn-small": props.size === "small",
  "panel-btn-xsmall": props.size === "xsmall",
  "panel-btn-large": props.size === "large",
  "panel-btn-block": props.block,
  "panel-btn-inline": props.inline,
  "panel-btn-dropdown-link": props.variant === "dropdown",
  "panel-btn-text-inline": props.textInline,
  "panel-btn-mobile-block": props.mobileBlock,
  active: props.active,
  disabled: props.disabled,
}));
</script>

<script lang="ts">
export default {
  name: "BaseBtn",
};
</script>
