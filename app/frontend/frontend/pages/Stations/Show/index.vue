<template>
  <section class="container">
    <div class="row">
      <div class="col-12 col-md-8">
        <BreadCrumbs :crumbs="crumbs" />
        <h1 v-if="station">
          {{ station.name }}
        </h1>
      </div>
      <div class="col-12 col-md-4">
        <div class="page-actions page-actions-right">
          <PriceModalBtn
            v-if="station && station.shops.length"
            :station-slug="station.slug"
          />
        </div>
      </div>
    </div>
    <div class="row">
      <div v-if="station" class="col-12 col-lg-8">
        <img :src="station.storeImage" class="image" alt="model image" />
        <blockquote v-if="station.description" class="description">
          <p v-html="station.description" />
        </blockquote>
      </div>
      <div v-if="station" class="col-12 col-lg-4">
        <Panel>
          <StationBaseMetrics :station="station" :padding="true" />
          <StationDocks :station="station" :padding="true" />
          <StationHabitations :station="station" :padding="true" />
        </Panel>
        <div class="text-right">
          <div class="page-actions page-actions-right">
            <Btn
              v-if="station.hasImages"
              :to="{ name: 'station-images', params: { slug: station.slug } }"
            >
              <i class="fa fa-images" />
            </Btn>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-12">
        <template v-if="station && station.shops.length">
          <h2>{{ $t("headlines.shops") }}</h2>
          <transition-group name="fade-list" class="row" tag="div" appear>
            <div
              v-for="shop in station.shops"
              :key="shop.slug"
              class="col-12 col-lg-3 fade-list-item"
            >
              <ShopPanel
                :item="shop"
                :route="{
                  name: 'shop',
                  params: {
                    stationSlug: station.slug,
                    slug: shop.slug,
                  },
                }"
              />
            </div>
          </transition-group>
          <Loader :loading="loading" :fixed="true" />
        </template>
      </div>
    </div>
  </section>
</template>

<script lang="ts">
import Vue from "vue";
import { Component } from "vue-property-decorator";
import Loader from "@/frontend/core/components/Loader/index.vue";
import Btn from "@/frontend/core/components/Btn/index.vue";
import PriceModalBtn from "@/frontend/components/ShopCommodities/PriceModalBtn/index.vue";
import Panel from "@/frontend/core/components/Panel/index.vue";
import { stationRouteGuard } from "@/frontend/utils/RouteGuards/Stations";
import stationsCollection from "@/frontend/api/collections/Stations";
import ShopPanel from "@/frontend/components/Stations/Item/index.vue";
import StationBaseMetrics from "@/frontend/components/Stations/BaseMetrics/index.vue";
import StationDocks from "@/frontend/components/Stations/Docks/index.vue";
import StationHabitations from "@/frontend/components/Stations/Habitations/index.vue";
import BreadCrumbs from "@/frontend/core/components/BreadCrumbs/index.vue";

@Component<StationDetail>({
  beforeRouteEnter: stationRouteGuard,
  components: {
    Loader,
    Btn,
    PriceModalBtn,
    Panel,
    ShopPanel,
    StationBaseMetrics,
    StationDocks,
    StationHabitations,
    BreadCrumbs,
  },
})
export default class StationDetail extends Vue {
  loading = false;

  get station() {
    return stationsCollection.record;
  }

  get metaTitle() {
    if (!this.station) {
      return null;
    }

    return this.$t("title.station", {
      station: this.station.name,
      celestialObject: this.station.celestialObject.name,
    });
  }

  get crumbs() {
    if (!this.station) {
      return null;
    }

    const crumbs = [
      {
        to: {
          name: "starsystems",
          hash: `#${this.station.celestialObject.starsystem.slug}`,
        },
        label: this.$t("nav.starsystems"),
      },
      {
        to: {
          name: "starsystem",
          params: {
            slug: this.station.celestialObject.starsystem.slug,
          },
          hash: `#${this.station.celestialObject.slug}`,
        },
        label: this.station.celestialObject.starsystem.name,
      },
    ];

    if (this.station.celestialObject.parent) {
      crumbs.push({
        to: {
          name: "celestial-object",
          params: {
            starsystem: this.station.celestialObject.starsystem.slug,
            slug: this.station.celestialObject.parent.slug,
          },
        },
        label: this.station.celestialObject.parent.name,
      });
    }

    crumbs.push({
      to: {
        name: "celestial-object",
        params: {
          starsystem: this.station.celestialObject.starsystem.slug,
          slug: this.station.celestialObject.slug,
        },
        hash: `#${this.station.slug}`,
      },
      label: this.station.celestialObject.name,
    });

    return crumbs;
  }

  mounted() {
    this.fetch();
  }

  async fetch() {
    this.loading = true;
    await stationsCollection.findBySlug(this.$route.params.slug);
    this.loading = false;
  }
}
</script>

<style lang="scss" scoped>
@import "index";
</style>
