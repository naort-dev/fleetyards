<template>
  <div class="panel-btn-inner">
    <template v-if="loading">
      {{ t("actions.loading") }}
      <SmallLoader
        v-if="spinner"
        :loading="loading"
        :alignment="spinnerAlignment"
      />
    </template>
    <template v-else>
      <slot />
    </template>
  </div>
</template>

<script lang="ts" setup>
import SmallLoader from "@/frontend/core/components/SmallLoader/index.vue";
import { useI18n } from "@/frontend/composables/useI18n";
import type { SpinnerAlignment } from "@/frontend/core/components/SmallLoader/index.vue";

type Props = {
  loading?: boolean;
  spinner?: boolean | SpinnerAlignment;
};

const props = withDefaults(defineProps<Props>(), {
  loading: false,
  spinner: false,
});

const spinnerAlignment = computed(() => {
  if (typeof props.spinner === "boolean") {
    return "right";
  }

  return props.spinner;
});

const { t } = useI18n();
</script>

<script lang="ts">
export default {
  name: "BtnInner",
};
</script>
