<template>
  <ValidationObserver v-slot="{ handleSubmit }" :small="true" :slim="true">
    <Modal v-if="shopCommodity" ref="modal" :title="title" class="prices-modal">
      <form @submit.prevent="handleSubmit(create)">
        <div
          v-for="record in collection.records"
          :key="record.id"
          class="price-item"
        >
          <FormInput
            :id="record.id"
            class="input"
            type="number"
            :disabled="true"
            :value="record.price"
            :no-label="true"
          />
          <span v-if="record.timeRange" class="time-range-label">
            {{ record.timeRange }}
          </span>
          <span class="date-label">
            {{ $l(record.createdAt) }}
          </span>
          <span
            v-tooltip="$t('labels.shopCommodity.confirmed')"
            class="confirmed-label"
          >
            <i v-if="record.confirmed" class="fal fa-check" />
            <i v-else class="fal fa-times" />
          </span>
          <Btn size="small" @click.native="destroy(record)">
            <i class="fa fa-times" />
          </Btn>
        </div>
        <div v-if="form" class="new-price">
          <ValidationProvider
            v-slot="{ errors }"
            vid="price"
            rules="required"
            :name="$t('labels.price')"
            :slim="true"
          >
            <FormInput
              id="new-price"
              v-model="form.price"
              :error="errors[0]"
              class="input"
              type="number"
              :no-label="true"
              :autofocus="true"
              translation-key="commodityPrice.price"
            />
          </ValidationProvider>
          <ValidationProvider
            v-if="path === 'rental'"
            v-slot="{ errors }"
            vid="timeRange"
            rules="required"
            :name="$t('labels.commodityPrice.timeRange')"
            :slim="true"
          >
            <CollectionFilterGroup
              v-model="form.timeRange"
              name="time-range"
              :error="errors[0]"
              :label="$t('labels.filters.commodityPrice.timeRange')"
              :collection="collection"
              collection-method="timeRanges"
              :no-label="true"
            />
          </ValidationProvider>
          <Btn size="small" @click.native="handleSubmit(create)">
            <i class="fa fa-check" />
          </Btn>
        </div>
      </form>
    </Modal>
  </ValidationObserver>
</template>

<script lang="ts">
import Vue from "vue";
import { Component, Prop } from "vue-property-decorator";
import commodityPricesCollection from "@/admin/api/collections/CommodityPrices";
import Btn from "@/frontend/core/components/Btn/index.vue";
import FormInput from "@/frontend/core/components/Form/FormInput/index.vue";
import Modal from "@/frontend/core/components/AppModal/Inner/index.vue";
import CollectionFilterGroup from "@/frontend/core/components/Form/CollectionFilterGroup/index.vue";

@Component<BuyPricesModal>({
  components: {
    Modal,
    FormInput,
    Btn,
    CollectionFilterGroup,
  },
})
export default class BuyPricesModal extends Vue {
  @Prop({ required: true }) shopId: string;

  @Prop({ required: true }) path: string;

  @Prop({ required: true }) shopCommodity: ShopCommodity;

  collection: CommodityPricesCollection = commodityPricesCollection;

  prices: ShopCommodityPrice[] = [];

  form: AdminCommodityPriceForm = null;

  get title() {
    return this.$t(`headlines.modals.shopCommodity.${this.path}Prices`, {
      shopCommodity: this.shopCommodity.item.name,
    });
  }

  get params() {
    return {
      shopId: this.shopId,
      shopCommodityId: this.shopCommodity.id,
      path: this.path,
    };
  }

  mounted() {
    this.fetch();
    this.setupForm();
  }

  setupForm() {
    this.form = {
      shopCommodityId: this.shopCommodity.id,
      path: this.path,
      price: null,
    };
  }

  async fetch() {
    await this.collection.findAll(this.params);
  }

  async create() {
    await this.collection.create(this.form);

    this.$comlink.$emit("prices-update");

    this.newPrice = null;

    this.$comlink.$emit("close-modal");
  }

  async destroy(record) {
    await this.collection.destroy(record.id);

    this.$comlink.$emit("prices-update");

    this.fetch();
  }
}
</script>
