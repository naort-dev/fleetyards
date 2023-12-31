<template>
  <div
    :id="commodity.slug"
    v-tooltip="!commodity.confirmed ? $t('commodityItem.unconfirmed') : null"
    class="flex-list-row"
    :class="{
      'shop-item-row-unconfirmed': !commodity.confirmed,
    }"
  >
    <div class="store-image">
      <router-link v-if="link" :to="link">
        <div
          :key="commodity.storeImageSmall"
          v-lazy:background-image="commodity.storeImageSmall"
          class="image lazy"
          alt="storeImage"
        />
      </router-link>
      <div
        v-else
        :key="commodity.storeImageSmall"
        v-lazy:background-image="commodity.storeImageSmall"
        class="image lazy"
        alt="storeImage"
      />
    </div>
    <div class="description">
      <h2>
        <router-link v-if="link" :to="link">
          <span v-html="name" />
        </router-link>
        <span v-else v-html="name" />
        <small class="text-muted">{{ commodity.subCategoryLabel }}</small>
      </h2>
      <div v-if="showStats" class="row">
        <div class="col-12 col-lg-6">
          <ul class="list-unstyled">
            <li v-if="commodity.item.grade">
              <b>{{ $t("commodityItem.grade") }}:</b>
              {{ commodity.item.grade }}
            </li>
            <li v-if="commodity.item.size">
              <b>{{ $t("commodityItem.size") }}:</b>
              {{ commodity.item.size }}
            </li>
            <li v-if="commodity.item.typeLabel">
              <b>{{ $t("commodityItem.type") }}:</b>
              {{ commodity.item.typeLabel }}
            </li>
            <li v-if="commodity.item.itemTypeLabel">
              <b>{{ $t("commodityItem.itemType") }}:</b>
              {{ commodity.item.itemTypeLabel }}
            </li>
            <li v-if="commodity.item.weaponClassLabel">
              <b>{{ $t("commodityItem.weaponClass") }}:</b>
              {{ commodity.item.weaponClassLabel }}
            </li>
            <li v-if="commodity.item.itemClassLabel">
              <b>{{ $t("commodityItem.itemClass") }}:</b>
              {{ commodity.item.itemClassLabel }}
            </li>
          </ul>
        </div>
        <div class="col-12 col-lg-6">
          <ul class="list-unstyled">
            <li v-if="commodity.item.range">
              <b>{{ $t("commodityItem.range") }}:</b>
              {{ $toNumber(commodity.item.range, "distance") }}
            </li>
            <li v-if="commodity.item.damageReduction">
              <b>{{ $t("commodityItem.damageReduction") }}:</b>
              {{ $toNumber(commodity.item.damageReduction, "percent") }}
            </li>
            <li v-if="commodity.item.rateOfFire">
              <b>{{ $t("commodityItem.rateOfFire") }}:</b>
              {{ $toNumber(commodity.item.rateOfFire, "rateOfFire") }}
            </li>
            <li v-if="commodity.item.extras">
              {{ commodity.item.extras }}
            </li>
          </ul>
        </div>
      </div>
      {{ commodity.description }}
    </div>
    <div v-if="selling" class="price">
      <span class="price-label">
        {{ $t("labels.shopCommodity.prices.sellPrice") }}:&nbsp;
      </span>
      <b v-html="$toUEC(commodity.sellPrice)" />
    </div>
    <div v-if="buying" class="price">
      <span class="price-label">
        {{ $t("labels.shopCommodity.prices.buyPrice") }}:&nbsp;
      </span>
      <b v-html="$toUEC(commodity.buyPrice)" />
    </div>
    <div v-if="rental" class="rent-price">
      <span class="price-label">
        {{ $t("labels.shopCommodity.prices.rentalPrice") }}:&nbsp;
      </span>
      <ul class="list-unstyled">
        <li v-if="commodity.rentalPrice1Day">
          {{ $t("labels.shopCommodity.prices.rentalPrice1Day") }}
          <b v-html="$toUEC(commodity.rentalPrice1Day)" />
        </li>
        <li v-if="commodity.rentalPrice3Days">
          {{ $t("labels.shopCommodity.prices.rentalPrice3Days") }}
          <b v-html="$toUEC(commodity.rentalPrice3Days)" />
        </li>
        <li v-if="commodity.rentalPrice7Days">
          {{ $t("labels.shopCommodity.prices.rentalPrice7Days") }}
          <b v-html="$toUEC(commodity.rentalPrice7Days)" />
        </li>
        <li v-if="commodity.rentalPrice30Days">
          {{ $t("labels.shopCommodity.prices.rentalPrice30Days") }}
          <b v-html="$toUEC(commodity.rentalPrice30Days)" />
        </li>
      </ul>
    </div>
    <div class="actions actions-1x">
      <AddToCartBtn
        :item="commodity.item"
        :type="commodity.commodityItemType"
      />
    </div>
  </div>
</template>

<script>
import AddToCartBtn from "@/frontend/core/components/AppShoppingCart/AddToCartBtn/index.vue";

export default {
  name: "ShopsItemRow",

  components: {
    AddToCartBtn,
  },
  props: {
    commodity: {
      type: Object,
      required: true,
    },
    rental: {
      type: Boolean,
      default: false,
    },
    selling: {
      type: Boolean,
      default: false,
    },
    buying: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    showStats() {
      return ["equipment", "component"].includes(this.commodity.category);
    },
    manufacturer() {
      if (!this.commodity.item || !this.commodity.item.manufacturer) {
        return null;
      }
      return this.commodity.item.manufacturer;
    },
    name() {
      if (this.manufacturer) {
        if (this.manufacturer.code) {
          return `${this.manufacturer.code} ${this.commodity.name}`;
        }
        return `${this.manufacturer.name} ${this.commodity.name}`;
      }
      return this.commodity.name;
    },
    link() {
      if (this.commodity.category !== "model") {
        return null;
      }
      return {
        name: "model",
        params: {
          slug: this.commodity.slug,
        },
      };
    },
  },
};
</script>

<style lang="scss" scoped>
.shop-item-row-unconfirmed {
  opacity: 0.5;
}
</style>
