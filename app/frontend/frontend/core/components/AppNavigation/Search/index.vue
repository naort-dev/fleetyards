<template>
  <div class="quick-search-bar">
    <form @submit.prevent="filter">
      <FormInput
        :id="$route.meta.search || 'search'"
        v-model="form[$route.meta.search]"
        :translation-key="`search.${$route.name}`"
        :no-label="true"
        :autofocus="!mobile"
      />
    </form>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { Component, Watch } from "vue-property-decorator";
import { Getter } from "vuex-class";
import FormInput from "@/frontend/core/components/Form/FormInput/index.vue";
import { debounce } from "ts-debounce";

type SearchFormType = {
  [key: string]: string;
};

@Component<SearchForm>({
  components: {
    FormInput,
  },
})
export default class SearchForm extends Vue {
  form: SearchFormType = {};

  filter = debounce(this.debouncedFilter, 500);

  @Getter("mobile") mobile;

  mounted() {
    this.setupSearch();
  }

  @Watch("form", {
    deep: true,
  })
  onFormChange() {
    this.filter();
  }

  @Watch("$route")
  onRouteChange() {
    this.setupSearch();
  }

  setupSearch() {
    this.form = {
      [this.$route.meta.search]:
        this.$route.query[this.$route.meta.search] || null,
    };
  }

  debouncedFilter() {
    const query = {
      ...this.$route.query,
      ...this.form,
    };

    if (!query[this.$route.meta.search]) {
      delete query[this.$route.meta.search];
    }

    this.$router
      .replace({
        name: this.$route.name || undefined,
        query,
      })
      // eslint-disable-next-line @typescript-eslint/no-empty-function
      .catch((_err) => {});
  }
}
</script>
