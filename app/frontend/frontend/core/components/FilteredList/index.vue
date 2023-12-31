<template>
  <div class="row">
    <div class="col-12">
      <div class="row">
        <div class="col-12 filtered-header">
          <div class="filtered-header-left">
            <Btn
              v-if="hasFilterSlot"
              v-tooltip="filterTooltip"
              :active="filterVisible"
              :aria-label="filterTooltip"
              size="small"
              @click.native="toggleFilter"
            >
              <span v-show="isFilterSelected">
                <i class="fas fa-filter" />
              </span>
              <span v-show="!isFilterSelected">
                <i class="far fa-filter" />
              </span>
            </Btn>
          </div>
          <div class="filtered-header-right">
            <slot name="actions" :records="collection && collection.records" />
          </div>
        </div>
      </div>
      <div class="row">
        <transition
          name="slide"
          :appear="true"
          @before-enter="toggleFullscreen"
          @after-leave="toggleFullscreen"
        >
          <div v-if="filterVisible" class="col-12 col-lg-3 col-xxl-2">
            <slot name="filter" />
          </div>
        </transition>
        <div
          :class="{
            'col-lg-9 col-xxl-10': !fullscreen,
          }"
          class="col-12 col-animated"
        >
          <slot
            name="default"
            :records="collection && collection.records"
            :filter-visible="filterVisible"
            :loading="loading"
            :primary-key="collection.primaryKey"
            :empty-box-visible="emptyBoxVisible"
          />

          <slot
            name="empty"
            :filter-visible="filterVisible"
            :hide-empty-box="hideEmptyBox"
            :empty-box-visible="emptyBoxVisible"
          >
            <EmptyBox v-if="!hideEmptyBox" :visible="emptyBoxVisible" />
          </slot>
          <slot name="loader" :loading="loading">
            <Loader v-if="!hideLoading" :loading="loading" :fixed="true" />
          </slot>
        </div>
      </div>
      <div class="row">
        <div class="col-12">
          <slot name="pagination-bottom">
            <Paginator
              v-if="paginated && collection.records.length"
              :collection="collection"
              :page="page"
            />
          </slot>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { Component, Watch, Prop } from "vue-property-decorator";
import { Action, Mutation, Getter } from "vuex-class";
import Btn from "@/frontend/core/components/Btn/index.vue";
import Paginator from "@/frontend/core/components/Paginator/index.vue";
import Loader from "@/frontend/core/components/Loader/index.vue";
import EmptyBox from "@/frontend/core/components/EmptyBox/index.vue";
import { scrollToAnchor } from "@/frontend/utils/scrolling";
import { isFilterSelected } from "@/frontend/utils/Filters";

@Component<FilteredList>({
  components: {
    Btn,
    Paginator,
    Loader,
    EmptyBox,
  },
})
export default class FilteredList extends Vue {
  loading = true;

  fullscreen = false;

  @Prop({ required: true }) collection!: BaseCollection;

  @Prop({ required: true }) name!: string;

  @Prop({ default: null }) recordListClass!: string;

  @Prop({
    default() {
      return {};
    },
  })
  params: RouteParams;

  @Prop({ default: "findAll" }) collectionMethod: string;

  @Prop({ default: null }) routeQuery: RouteQuery;

  @Prop({ default: null }) hash: string;

  @Prop({ default: false }) paginated: boolean;

  @Prop({ default: false }) alwaysFilterVisible: boolean;

  @Prop({ default: false }) hideEmptyBox: boolean;

  @Prop({ default: false }) hideLoading: boolean;

  @Prop({ default: "q" }) routeFilterName: string;

  @Getter("filtersVisible") filtersVisible;

  @Getter("mobile") mobile;

  @Action("toggleFilterVisible") toggleFilterVisible;

  @Mutation("setFiltersVisible") setFiltersVisible;

  @Mutation("setFilters") setFilters;

  get filters() {
    return this.routeQuery[this.routeFilterName];
  }

  get search() {
    return this.routeQuery.search;
  }

  get hasFilterSlot() {
    return !!this.$slots.filter;
  }

  get page() {
    if (!this.routeQuery.page) {
      return 1;
    }

    return parseInt(this.routeQuery.page, 10);
  }

  get filterVisible() {
    return !!this.filtersVisible[this.name] && this.hasFilterSlot;
  }

  get filterTooltip() {
    if (this.filterVisible) {
      return this.$t("actions.hideFilter");
    }

    return this.$t("actions.showFilter");
  }

  get isFilterSelected() {
    return isFilterSelected(this.filters);
  }

  get emptyBoxVisible() {
    return !!(
      !this.loading &&
      !this.collection.records.length &&
      (this.isFilterSelected || (this.paginated && this.page))
    );
  }

  @Watch("filters", { deep: true })
  onFiltersChange() {
    this.saveFilters();
  }

  @Watch("routeQuery")
  onPageChange() {
    this.fetch();
  }

  created() {
    if (this.collection.records.length) {
      this.collection.records = [];
    }
  }

  mounted() {
    this.fetch();

    if (this.mobile) {
      this.setFiltersVisible({
        [this.name]: false,
      });
    } else if (this.alwaysFilterVisible) {
      this.setFiltersVisible({
        [this.name]: true,
      });
    }

    this.toggleFullscreen();
    this.saveFilters();

    this.$comlink.$on("filteredListUpdate", this.fetch);
  }

  beforeDestroy() {
    this.$comlink.$off("filteredListUpdate");
  }

  saveFilters() {
    if (this.isFilterSelected) {
      this.setFilters({
        [this.name]: { ...this.filters },
      });

      return;
    }

    this.setFilters({
      [this.name]: null,
    });
  }

  toggleFullscreen() {
    this.fullscreen = !this.filterVisible;
  }

  toggleFilter() {
    this.toggleFilterVisible(this.name);
  }

  async fetch() {
    this.loading = true;

    let params = {
      search: this.search,
      filters: this.filters,
    };

    if (this.paginated) {
      params = {
        ...params,
        ...this.params,
        page: this.page,
      };
    }

    if (!this.collection[this.collectionMethod]) {
      throw Error(`Method "${this.collectionMethod}" not found on Collection`);
    }

    await this.collection[this.collectionMethod](params);

    this.$nextTick(() => {
      scrollToAnchor(this.hash);
    });

    setTimeout(() => {
      this.loading = false;
    }, 300);
  }
}
</script>
