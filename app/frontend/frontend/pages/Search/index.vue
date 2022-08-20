<template>
  <section class="container search">
    <div class="row">
      <div class="col-12">
        <h1 class="sr-only">
          {{ $t('headlines.search') }}
        </h1>
      </div>
    </div>
    <div class="row">
      <div class="col-12">
        <div class="row justify-content-center">
          <div class="col-12 col-lg-6">
            <form class="search-form" @submit.prevent="filter">
              <div class="form-group">
                <div class="input-group-flex">
                  <FormInput
                    id="search"
                    v-model="form.search"
                    size="large"
                    :autofocus="true"
                    :clearable="true"
                    translation-key="search.default"
                    :no-label="true"
                    @clear="filter"
                  />
                  <Btn
                    id="search-submit"
                    :aria-label="$t('labels.search')"
                    size="large"
                    :inline="true"
                    @click.native="search"
                  >
                    <i class="fal fa-search" />
                  </Btn>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <transition name="fade">
      <SearchHistory v-if="historyVisible" @restore="restoreSearch" />

      <FilteredList
        v-else
        key="search"
        :collection="collection"
        :name="$route.name"
        :route-query="$route.query"
        :hash="$route.hash"
        :paginated="true"
      >
        <template #actions>
          <ShareBtn :url="shareUrl" :title="shareTitle" />
        </template>
        <template #default="{ records }">
          <transition-group name="fade-list" class="row" tag="div" appear>
            <div
              v-for="result in records"
              :key="`${result.resultType}-${result.id}`"
              class="col-12 col-md-6 col-xxl-4 col-xxlg-2-4 fade-list-item"
            >
              <ModelPanel
                v-if="result.resultType === 'model'"
                :model="result"
                :details="true"
              />
              <CelestialObjectsPanel
                v-else-if="
                  ['celestial_object', 'starsystem'].includes(result.resultType)
                "
                :item="result"
              />
              <ShopCommodityPanel
                v-else-if="result.resultType === 'shop_commodity'"
                :item="result"
              />
              <ComponentPanel
                v-else-if="result.resultType === 'component'"
                :component="result"
              />
              <CommodityPanel
                v-else-if="result.resultType === 'commodity'"
                :commodity="result"
              />
              <EquipmentPanel
                v-else-if="result.resultType === 'equipment'"
                :equipment="result"
              />
              <SearchPanel v-else :item="result" />
            </div>
          </transition-group>
        </template>
      </FilteredList>
    </transition>
  </section>
</template>

<script lang="ts">
import Vue from 'vue'
import { Component, Watch } from 'vue-property-decorator'
import MetaInfo from '@/frontend/mixins/MetaInfo'
import Filters from '@/frontend/mixins/Filters'
import Btn from '@/frontend/core/components/Btn/index.vue'
import ShareBtn from '@/frontend/components/ShareBtn/index.vue'
import searchCollection from '@/frontend/api/collections/Search'
import FormInput from '@/frontend/core/components/Form/FormInput/index.vue'
import ModelPanel from '@/frontend/components/Models/Panel/index.vue'
import SearchPanel from '@/frontend/components/Search/Panel/index.vue'
import FilteredList from '@/frontend/core/components/FilteredList/index.vue'
import CelestialObjectsPanel from '@/frontend/components/CelestialObjects/Panel/index.vue'
import ShopCommodityPanel from '@/frontend/components/ShopCommodities/Panel/index.vue'
import ComponentPanel from '@/frontend/components/Components/Panel/index.vue'
import CommodityPanel from '@/frontend/components/Commodities/Panel/index.vue'
import EquipmentPanel from '@/frontend/components/Equipment/Panel/index.vue'
import SearchHistory from '@/frontend/components/Search/History/index.vue'

@Component<Search>({
  components: {
    Btn,
    ShareBtn,
    ModelPanel,
    SearchPanel,
    FilteredList,
    CelestialObjectsPanel,
    ShopCommodityPanel,
    ComponentPanel,
    CommodityPanel,
    EquipmentPanel,
    FormInput,
    SearchHistory,
  },
  mixins: [MetaInfo, Filters],
})
export default class Search extends Vue {
  collection: SearchCollection = searchCollection

  form: SearchFilter = {
    search: null,
  }

  get historyVisible() {
    return !this.collection.records.length && !this.form.search
  }

  get filters() {
    return {
      filters: this.$route.query.q,
      page: this.$route.query.page || 1,
    }
  }

  get firstPage() {
    return !this.$route.query.page || this.$route.query.page === 1
  }

  get shareUrl() {
    return window.location.href
  }

  get shareTitle() {
    return this.$t('labels.search.shareTitle', { query: this.form.search })
  }

  @Watch('$route')
  onRouteChange() {
    const query = this.$route.query.q || {}
    this.form = {
      search: query.search,
    }
    this.fetch()
  }

  created() {
    this.form.search = this.$route.query?.q?.search
    this.fetch()
  }

  routeForResult(result) {
    switch (result.resultType) {
      case 'celestial_object':
        return {
          name: 'celestial-object',
          params: {
            starsystem: result.starsystem.slug,
            slug: result.slug,
          },
        }
      case 'shop':
        return {
          name: 'shop',
          params: {
            stationSlug: result.station.slug,
            slug: result.slug,
          },
        }
      case 'starsystem':
        return {
          name: 'starsystem',
          params: {
            slug: result.slug,
          },
        }
      default:
        return null
    }
  }

  search() {
    this.filter()
  }

  restoreSearch(search) {
    this.form.search = search
    this.filter()
  }

  async fetch() {
    await this.collection.findAll(this.filters)

    if (this.collection.records.length && this.firstPage && this.form.search) {
      this.$store.dispatch('search/save', {
        search: this.form.search,
        createdAt: new Date(),
      })
    }
  }
}
</script>

<style lang="scss" scoped>
@import 'index';
</style>