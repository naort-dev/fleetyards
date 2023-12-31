<template>
  <form @submit.prevent="filter">
    <FormInput
      id="model-name"
      v-model="form.modelNameCont"
      translation-key="filters.models.name"
      :no-label="true"
      :clearable="true"
    />

    <FilterGroup
      v-model="form.manufacturerIn"
      :label="$t('labels.filters.models.manufacturer')"
      fetch-path="manufacturers/with-models"
      name="manufacturer"
      value-attr="slug"
      icon-attr="logo"
      :paginated="true"
      :searchable="true"
      :multiple="true"
      :no-label="true"
    />

    <FilterGroup
      v-model="form.productionStatusIn"
      :label="$t('labels.filters.models.productionStatus')"
      fetch-path="models/production-states"
      name="production-status"
      :multiple="true"
      :no-label="true"
    />

    <FilterGroup
      v-model="form.classificationIn"
      :label="$t('labels.filters.models.classification')"
      fetch-path="models/classifications"
      name="classification"
      :searchable="true"
      :multiple="true"
      :no-label="true"
    />

    <FilterGroup
      v-model="form.focusIn"
      :label="$t('labels.filters.models.focus')"
      fetch-path="models/focus"
      name="focus"
      :searchable="true"
      :multiple="true"
      :no-label="true"
    />

    <FilterGroup
      v-model="form.sizeIn"
      :label="$t('labels.filters.models.size')"
      fetch-path="models/sizes"
      name="size"
      :multiple="true"
      :no-label="true"
    />

    <FilterGroup
      v-model="form.pledgePriceIn"
      :options="pledgePriceOptions"
      :label="$t('labels.filters.models.pledgePrice')"
      name="pledge-price"
      :multiple="true"
      :no-label="true"
    />

    <FilterGroup
      v-model="form.priceIn"
      :options="priceOptions"
      :label="$t('labels.filters.models.price')"
      name="price"
      :multiple="true"
      :no-label="true"
    />

    <div class="row">
      <div class="col-6">
        <FormInput
          id="model-length-gteq"
          v-model="form.lengthGteq"
          type="number"
          translation-key="filters.vehicles.lengthGt"
          :no-placeholder="true"
        />
      </div>
      <div class="col-6">
        <FormInput
          id="model-length-lteq"
          v-model="form.lengthLteq"
          type="number"
          translation-key="filters.vehicles.lengthLt"
          no-placeholder
        />
      </div>
    </div>

    <div class="row">
      <div class="col-6">
        <FormInput
          id="model-pledge-price-gteq"
          v-model="form.pledgePriceGteq"
          type="number"
          translation-key="filters.vehicles.pledgePriceGt"
          :no-placeholder="true"
        />
      </div>

      <div class="col-6">
        <FormInput
          id="model-pledge-price-lteq"
          v-model="form.pledgePriceLteq"
          type="number"
          translation-key="filters.vehicles.pledgePriceLt"
          :no-placeholder="true"
        />
      </div>
    </div>

    <FormInput
      id="model-price-gteq"
      v-model="form.priceGteq"
      type="number"
      translation-key="filters.vehicles.priceGt"
    />

    <FormInput
      id="model-price-lteq"
      v-model="form.priceLteq"
      type="number"
      translation-key="filters.vehicles.priceLt"
    />

    <RadioList
      v-model="form.onSaleEq"
      :label="$t('labels.filters.models.onSale')"
      :reset-label="$t('labels.all')"
      :options="booleanOptions"
      name="sale"
    />

    <RadioList
      v-model="form.loanerEq"
      :label="$t('labels.filters.vehicles.loaner')"
      :reset-label="$t('labels.hide')"
      :options="[
        {
          name: 'Show',
          value: 'true',
        },
        {
          name: 'Only',
          value: 'only',
        },
      ]"
      name="loaner"
    />

    <Btn
      :disabled="!isFilterSelected"
      :block="true"
      @click.native="resetFilter"
    >
      <i class="fal fa-times" />
      {{ $t("actions.resetFilter") }}
    </Btn>
  </form>
</template>

<script>
import Filters from "@/frontend/mixins/Filters";
import RadioList from "@/frontend/core/components/Form/RadioList/index.vue";
import FilterGroup from "@/frontend/core/components/Form/FilterGroup/index.vue";
import FormInput from "@/frontend/core/components/Form/FormInput/index.vue";
import Btn from "@/frontend/core/components/Btn/index.vue";
import {
  booleanOptions,
  priceOptions,
  pledgePriceOptions,
} from "@/frontend/utils/FilterOptions";

export default {
  name: "PublicFleetFilterForm",

  components: {
    RadioList,
    FilterGroup,
    FormInput,
    Btn,
  },

  mixins: [Filters],

  data() {
    const query = this.$route.query.q || {};
    return {
      form: {
        modelNameCont: query.modelNameCont,
        onSaleEq: query.onSaleEq,
        loanerEq: query.loanerEq,
        priceLteq: query.priceLteq,
        priceGteq: query.priceGteq,
        pledgePriceLteq: query.pledgePriceLteq,
        pledgePriceGteq: query.pledgePriceGteq,
        lengthLteq: query.lengthLteq,
        lengthGteq: query.lengthGteq,
        manufacturerIn: query.manufacturerIn || [],
        classificationIn: query.classificationIn || [],
        focusIn: query.focusIn || [],
        sizeIn: query.sizeIn || [],
        priceIn: query.priceIn || [],
        pledgePriceIn: query.pledgePriceIn || [],
        productionStatusIn: query.productionStatusIn || [],
      },
    };
  },

  computed: {
    booleanOptions() {
      return booleanOptions;
    },

    priceOptions() {
      return priceOptions;
    },

    pledgePriceOptions() {
      return pledgePriceOptions;
    },
  },

  watch: {
    $route() {
      const query = this.$route.query.q || {};
      this.form = {
        modelNameCont: query.modelNameCont,
        onSaleEq: query.onSaleEq,
        loanerEq: query.loanerEq,
        priceLteq: query.priceLteq,
        priceGteq: query.priceGteq,
        pledgePriceLteq: query.pledgePriceLteq,
        pledgePriceGteq: query.pledgePriceGteq,
        lengthLteq: query.lengthLteq,
        lengthGteq: query.lengthGteq,
        manufacturerIn: query.manufacturerIn || [],
        classificationIn: query.classificationIn || [],
        focusIn: query.focusIn || [],
        sizeIn: query.sizeIn || [],
        priceIn: query.priceIn || [],
        pledgePriceIn: query.pledgePriceIn || [],
        productionStatusIn: query.productionStatusIn || [],
      };
    },
  },
};
</script>
