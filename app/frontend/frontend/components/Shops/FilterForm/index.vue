<template>
  <form @submit.prevent="filter">
    <FormInput
      id="shop-name"
      v-model="form.nameCont"
      translation-key="filters.shops.name"
      :no-label="true"
      :clearable="true"
    />

    <FilterGroup
      v-model="form.modelIn"
      :label="$t('labels.filters.shops.model')"
      fetch-path="models"
      name="model"
      value-attr="slug"
      :paginated="true"
      :searchable="true"
      :multiple="true"
      :no-label="true"
    />

    <FilterGroup
      v-model="form.commodityIn"
      :label="$t('labels.filters.shops.commodity')"
      fetch-path="commodities"
      name="commodity"
      value-attr="slug"
      :paginated="true"
      :searchable="true"
      :multiple="true"
      :no-label="true"
    />

    <FilterGroup
      v-model="form.equipmentIn"
      :label="$t('labels.filters.shops.equipment')"
      fetch-path="equipment"
      name="equipment"
      value-attr="slug"
      :paginated="true"
      :searchable="true"
      :multiple="true"
      :no-label="true"
    />

    <FilterGroup
      v-model="form.componentIn"
      :label="$t('labels.filters.shops.component')"
      fetch-path="components"
      name="component"
      value-attr="slug"
      :paginated="true"
      :searchable="true"
      :multiple="true"
      :no-label="true"
    />

    <FilterGroup
      v-model="form.shopTypeIn"
      :label="$t('labels.filters.shops.type')"
      :fetch="fetchShopTypes"
      name="type"
      :multiple="true"
      :no-label="true"
    />

    <FilterGroup
      v-model="form.stationIn"
      :label="$t('labels.filters.shops.station')"
      fetch-path="stations"
      name="station"
      value-attr="slug"
      :paginated="true"
      :searchable="true"
      :multiple="true"
      :no-label="true"
    />

    <FilterGroup
      v-model="form.celestialObjectIn"
      :label="$t('labels.filters.shops.celestialObject')"
      fetch-path="celestial-objects"
      name="celestial-object"
      value-attr="slug"
      :paginated="true"
      :searchable="true"
      :multiple="true"
      :no-label="true"
    />

    <FilterGroup
      v-model="form.starsystemIn"
      :label="$t('labels.filters.shops.starsystem')"
      fetch-path="starsystems"
      name="starsystem"
      value-attr="slug"
      :paginated="true"
      :searchable="true"
      :multiple="true"
      :no-label="true"
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
import FilterGroup from "@/frontend/core/components/Form/FilterGroup/index.vue";
import FormInput from "@/frontend/core/components/Form/FormInput/index.vue";
import Btn from "@/frontend/core/components/Btn/index.vue";

export default {
  name: "ShopsFilterForm",

  components: {
    FilterGroup,
    FormInput,
    Btn,
  },

  mixins: [Filters],

  data() {
    const query = this.$route.query.q || {};
    return {
      loading: false,
      form: {
        nameCont: query.nameCont,
        modelIn: query.modelIn || [],
        commodityIn: query.commodityIn || [],
        equipmentIn: query.equipmentIn || [],
        componentIn: query.componentIn || [],
        stationIn: query.stationIn || [],
        celestialObjectIn: query.celestialObjectIn || [],
        starsystemIn: query.starsystemIn || [],
        shopTypeIn: query.shopTypeIn || [],
      },
    };
  },

  watch: {
    $route() {
      const query = this.$route.query.q || {};
      this.form = {
        nameCont: query.nameCont,
        modelIn: query.modelIn || [],
        commodityIn: query.commodityIn || [],
        equipmentIn: query.equipmentIn || [],
        componentIn: query.componentIn || [],
        stationIn: query.stationIn || [],
        celestialObjectIn: query.celestialObjectIn || [],
        starsystemIn: query.starsystemIn || [],
        shopTypeIn: query.shopTypeIn || [],
      };
    },
  },

  methods: {
    fetchShopTypes() {
      return this.$api.get("shops/shop-types");
    },
  },
};
</script>
