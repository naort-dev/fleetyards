<template>
  <div
    :class="{
      'metrics-padding': padding,
    }"
  >
    <div class="row">
      <div class="col-12 col-lg-3">
        <div class="metrics-title">
          {{ t("labels.metrics.base") }}
        </div>
      </div>
      <div class="col-12 col-lg-9 metrics-block">
        <div class="row">
          <div class="col-6">
            <div class="metrics-label">{{ t("celestialObject.type") }}:</div>
            <div v-tooltip="celestialObject.type" class="metrics-value">
              {{ celestialObject.type }}
            </div>
          </div>
          <div class="col-6">
            <div class="metrics-label">{{ t("celestialObject.subType") }}:</div>
            <div v-tooltip="celestialObject.subType" class="metrics-value">
              {{ celestialObject.subType }}
            </div>
          </div>
          <div class="col-6">
            <div class="metrics-label">
              {{ t("celestialObject.habitable") }}:
            </div>
            <div v-tooltip="celestialObject.habitable" class="metrics-value">
              {{ t(`labels.${!!celestialObject.habitable}`) }}
            </div>
          </div>
          <div class="col-6">
            <div class="metrics-label">
              {{ t("celestialObject.fairchanceact") }}:
            </div>
            <div
              v-tooltip="celestialObject.fairchanceact"
              class="metrics-value"
            >
              {{ t(`labels.${!!celestialObject.fairchanceact}`) }}
            </div>
          </div>
        </div>
      </div>
    </div>
    <br />
    <div class="row">
      <div class="col-12 col-lg-3">
        <div class="metrics-title">
          {{ t("labels.metrics.levels") }}
        </div>
      </div>
      <div class="col-12 col-lg-9 metrics-block">
        <div class="row">
          <div class="col-4">
            <div class="metrics-label">
              {{ t("celestialObject.population") }}:
            </div>
            <div v-tooltip="celestialObject.population" class="metrics-value">
              {{ celestialObject.population }}
            </div>
          </div>
          <div class="col-4">
            <div class="metrics-label">{{ t("celestialObject.economy") }}:</div>
            <div v-tooltip="celestialObject.economy" class="metrics-value">
              {{ celestialObject.economy }}
            </div>
          </div>
          <div class="col-4">
            <div class="metrics-label">{{ t("celestialObject.danger") }}:</div>
            <div v-tooltip="celestialObject.danger" class="metrics-value">
              {{ celestialObject.danger }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { useI18n } from "@/frontend/composables/useI18n";

type Props = {
  celestialObject: CelestialObject;
  padding?: boolean;
};

withDefaults(defineProps<Props>(), {
  padding: false,
});

const { t } = useI18n();
</script>

<script lang="ts">
export default {
  name: "CelestialObjectMetrics",
};
</script>
