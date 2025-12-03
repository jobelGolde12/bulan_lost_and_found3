// stores/filterChart.js
import { defineStore } from "pinia";

export const useFilterChart = defineStore('filterChart', {
  state: () => ({
    filterType: 'month', 
  }),
  actions: {
    setFilter(type) {
      this.filterType = type
    },
    resetFilter() {
      this.filterType = 'month'
    }
  }
});
