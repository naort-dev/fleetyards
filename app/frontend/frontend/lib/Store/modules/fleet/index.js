import actions from "./actions";
import getDefaultState from "./state";

export default () => ({
  namespaced: true,

  state: getDefaultState(),

  actions,

  getters: {
    detailsVisible(state) {
      return state.detailsVisible;
    },

    filterVisible(state) {
      return state.filterVisible;
    },

    fleetchartVisible(state) {
      return state.fleetchartVisible;
    },

    fleetchartZoomData(state) {
      return state.fleetchartZoomData;
    },

    fleetchartViewpoint(state) {
      return state.fleetchartViewpoint;
    },

    fleetchartLabels(state) {
      return state.fleetchartLabels;
    },

    fleetchartScreenHeight(state) {
      return state.fleetchartScreenHeight;
    },

    fleetchartMode(state) {
      return state.fleetchartMode;
    },

    fleetchartScale(state) {
      return state.fleetchartScale;
    },

    fleetchartColored(state) {
      return state.fleetchartColored;
    },

    grouped(state) {
      return state.grouped;
    },

    money(state) {
      return state.money;
    },

    preview(state) {
      return state.preview;
    },

    inviteToken(state) {
      return state.inviteToken;
    },

    perPage(state) {
      return state.perPage;
    },
  },

  /* eslint-disable no-param-reassign */
  mutations: {
    reset(state) {
      Object.assign(state, getDefaultState());
    },

    setDetailsVisible(state, payload) {
      state.detailsVisible = payload;
    },

    setFilterVisible(state, payload) {
      state.filterVisible = payload;
    },

    setFleetchartVisible(state, payload) {
      state.fleetchartVisible = payload;
    },

    setFleetchartZoomData(state, payload) {
      state.fleetchartZoomData = payload;
    },

    setFleetchartViewpoint(state, payload) {
      state.fleetchartViewpoint = payload;
    },

    setFleetchartLabels(state, payload) {
      state.fleetchartLabels = payload;
    },

    setFleetchartScreenHeight(state, payload) {
      state.fleetchartScreenHeight = payload;
    },

    setFleetchartMode(state, payload) {
      state.fleetchartMode = payload;
    },

    setFleetchartScale(state, payload) {
      state.fleetchartScale = payload;
    },

    setFleetchartColored(state, payload) {
      state.fleetchartColored = payload;
    },

    setGrouped(state, payload) {
      state.grouped = payload;
    },

    setMoney(state, payload) {
      state.money = payload;
    },

    setPreview(state, payload) {
      state.preview = !!payload;
    },

    setInviteToken(state, payload) {
      state.inviteToken = payload;
    },

    setPerPage(state, payload) {
      state.perPage = payload;
    },
  },
  /* eslint-enable no-param-reassign */
});
