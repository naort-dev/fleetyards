<template>
  <div class="profit">
    <span v-if="availableCargo" v-html="tPrice(profit * availableCargo)" />
    <span v-else v-html="tPrice(profit)" />
    <small class="profit-percent">({{ profitPerUnitPercent }} %)</small>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { Component, Prop } from "vue-property-decorator";

@Component<TradeRouteProfit>({})
export default class TradeRouteProfit extends Vue {
  @Prop({ required: true }) tradeRoute!: TradeRoute;

  @Prop({ default: null }) availableCargo!: number;

  @Prop({ default: false }) average!: ToTextBooleanArg;

  get profit() {
    if (this.average) {
      return this.tradeRoute.averageProfitPerUnit;
    }

    return this.tradeRoute.profitPerUnit;
  }

  get profitPerUnitPercent() {
    if (this.average) {
      return this.tradeRoute.averageProfitPerUnitPercent;
    }

    return this.tradeRoute.profitPerUnitPercent;
  }

  tPrice(price) {
    return this.$toUEC(price, this.$t("labels.uecPerUnit"));
  }
}
</script>
