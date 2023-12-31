<template>
  <div>
    <Panel
      v-if="vehicle && model"
      :id="id"
      class="model-panel vehicle-panel"
      :class="`model-panel-${model.slug}`"
      :highlight="vehicle.flagship || highlight"
    >
      <div class="panel-heading">
        <h2 class="panel-title">
          <router-link
            :to="{
              name: 'model',
              params: {
                slug: model.slug,
              },
            }"
          >
            <span v-if="customName">{{ customName }}</span>
            <span v-else>{{ modelName }}</span>
          </router-link>

          <transition name="fade" appear>
            <small v-if="vehicle && vehicle.serial">
              <span v-if="vehicle.serial" class="serial">
                {{ vehicle.serial }}
              </span>
            </small>
          </transition>

          <transition name="fade" appear>
            <small
              v-if="vehicle && vehicle.flagship"
              v-tooltip.right="flagshipTooltip"
            >
              <i class="fa fa-certificate flagship-icon" />
            </small>
          </transition>

          <br />

          <small>
            <router-link
              :to="{
                query: {
                  q: filterManufacturerQuery(model.manufacturer.slug),
                },
              }"
              v-html="model.manufacturer.name"
            />
            <template v-if="customName">
              {{ modelName }}
            </template>
          </small>
        </h2>
        <VehicleContextMenu
          v-if="editable && !vehicle.loaner"
          :vehicle="vehicle"
          :editable="editable"
          :wishlist="wishlist"
        />

        <AddToHangar
          v-else-if="!editable"
          :model="model"
          class="panel-add-to-hangar-button"
          variant="panel"
        />
      </div>
      <div
        :class="{
          'no-details': !details,
        }"
        class="panel-image text-center"
      >
        <LazyImage
          :to="{ name: 'model', params: { slug: model.slug } }"
          :aria-label="model.name"
          :src="storeImage"
          :alt="model.name"
          class="image"
        >
          <div
            v-if="vehicle.loaner"
            v-tooltip="$t('labels.vehicle.loaner')"
            class="loaner-label"
          >
            <i class="fal fa-exchange" />
          </div>
          <div
            v-else-if="!mobile && hasLoaners && loanersHintVisible"
            v-tooltip="loanersTooltip"
            class="loaner-label"
          >
            <i class="fal fa-exchange" />
          </div>
          <div
            v-show="model.onSale"
            v-tooltip="$t('labels.model.onSale')"
            class="on-sale"
          >
            <i class="fal fa-dollar-sign" />
          </div>
          <HangarGroups
            :groups="vehicle.hangarGroups"
            class="panel-hangar-groups"
          />
        </LazyImage>
        <div
          v-if="upgradable && vehicle"
          v-tooltip="$t('labels.model.addons')"
          class="addons"
          :class="{
            selected: hasAddons,
          }"
          @click="openAddonsModal"
        >
          <span v-show="hasAddons">
            <i class="fa fa-plus-octagon" />
          </span>
          <span v-show="!hasAddons">
            <i class="far fa-plus-octagon" />
          </span>
        </div>
      </div>
      <PanelDetails
        :key="`details-${model.slug}-${uuid}-wrapper`"
        :visible="details"
      >
        <div class="production-status">
          <strong class="text-uppercase">
            <template v-if="model.productionStatus">
              {{
                $t(`labels.model.productionStatus.${model.productionStatus}`)
              }}
            </template>
            <template v-else>
              {{ $t(`labels.not-available`) }}
            </template>
          </strong>
        </div>
        <ModelPanelMetrics :model="model" />
      </PanelDetails>
    </Panel>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { Component, Prop } from "vue-property-decorator";
import { Getter } from "vuex-class";
import Panel from "@/frontend/core/components/Panel/index.vue";
import PanelDetails from "@/frontend/core/components/Panel/PanelDetails/index.vue";
import LazyImage from "@/frontend/core/components/LazyImage/index.vue";
import AddToHangar from "@/frontend/components/Models/AddToHangar/index.vue";
import ModelPanelMetrics from "@/frontend/components/Models/PanelMetrics/index.vue";
import VehicleContextMenu from "@/frontend/components/Vehicles/ContextMenu/index.vue";
import HangarGroups from "@/frontend/components/Vehicles/HangarGroups/index.vue";

@Component<VehiclePanel>({
  components: {
    Panel,
    PanelDetails,
    VehicleContextMenu,
    LazyImage,
    AddToHangar,
    ModelPanelMetrics,
    HangarGroups,
  },
})
export default class VehiclePanel extends Vue {
  @Prop({ required: true }) vehicle: Vehicle | null;

  @Prop({ default: false }) details: boolean;

  @Prop({ default: false }) editable: boolean;

  @Prop({ default: false }) wishlist: boolean;

  @Prop({ default: false }) highlight: boolean;

  @Prop({ default: false }) loanersHintVisible: boolean;

  @Getter("mobile") mobile;

  get uuid() {
    return this._uid;
  }

  get storeImage() {
    if (this.vehicle && this.vehicle.paint) {
      return this.vehicle.paint.storeImageMedium;
    }

    if (this.vehicle && this.vehicle.upgrade) {
      return this.vehicle.upgrade.storeImageMedium;
    }

    return this.model.storeImageMedium;
  }

  get modelName() {
    return this.model.name;
  }

  get model() {
    if (!this.vehicle) {
      return null;
    }

    return this.vehicle.model;
  }

  get id() {
    if (this.vehicle) {
      return this.vehicle.id;
    }

    return this.model.slug;
  }

  get customName() {
    if (this.vehicle && this.vehicle.name) {
      return this.vehicle.name;
    }

    return null;
  }

  get flagshipTooltip() {
    if (!this.vehicle) {
      return "";
    }
    if (this.$route.name === "hangar") {
      return this.$t("labels.yourFlagship");
    }
    return this.$t("labels.flagship");
  }

  get hasAddons() {
    return (
      this.vehicle &&
      (this.vehicle.modelModuleIds.length ||
        this.vehicle.modelUpgradeIds.length)
    );
  }

  get upgradable() {
    return (
      (this.editable || this.hasAddons) &&
      (this.model.hasModules || this.model.hasUpgrades)
    );
  }

  get loanersTooltip() {
    return [
      this.$t("labels.vehicle.hasLoaners"),
      this.model.loaners.map((loaner) => loaner.name).join(", "),
    ].join(": ");
  }

  get hasLoaners() {
    return this.model?.loaners?.length;
  }

  filterManufacturerQuery(manufacturer) {
    return { manufacturerIn: [manufacturer] };
  }

  openAddonsModal() {
    this.$comlink.$emit("open-modal", {
      component: () =>
        import("@/frontend/components/Vehicles/AddonsModal/index.vue"),
      props: {
        vehicle: this.vehicle,
        editable: this.editable,
      },
    });
  }
}
</script>
