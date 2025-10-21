<script setup>
import { Head } from '@inertiajs/vue3';
import { computed, defineProps, ref, watch } from 'vue';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ResolveCasesChart from '@/Components/admin/dashboard/ResolveCasesChart.vue';
import ResolveCasesChartYearly from '@/Components/admin/dashboard/ResolveCasesChartYearly.vue';
import UserRegistration from '@/Components/admin/dashboard/UserRegistration.vue';
import { useFilterChart } from '@/piniaStore/FilterChart';
import RecentLostAndFoundReports from './users/RecentLostAndFoundReports.vue';
import Overview from '@/Components/admin/dashboard/Overview.vue';

import * as echarts from 'echarts/core';
import { PieChart } from 'echarts/charts';
import {
  TitleComponent,
  TooltipComponent,
  LegendComponent,
} from 'echarts/components';
import { CanvasRenderer } from 'echarts/renderers';
import TotalLostAndFound from '@/Components/admin/dashboard/TotalLostAndFound.vue';
import { usePendingRequestStore } from "@/piniaStore/pendingRequestStore";
import OverAllResolved from '@/Components/admin/dashboard/OverAllResolved.vue';
import TotalLosts from './reportTable/TotalLosts.vue';
import TotalFounds from './reportTable/TotalFounds.vue';
import Unsolved from './reportTable/Unsolved.vue';
import Claimed from './reportTable/Claimed.vue';
import Report from './reportTable/Report.vue';

echarts.use([PieChart, TitleComponent, TooltipComponent, LegendComponent, CanvasRenderer]);

const filterChart = useFilterChart();
let filterValue = ref('month');
watch(() => filterChart.filterType, (newType) => {
  filterValue.value = newType;
});

const props = defineProps({
  categories: {
    type: Array,
    default: [],
  },
  items: {
    type: Array,
    default: [],
  },  
  pending_request_count: {
    type: Number,
    default: 0
  },
  user_count: {
    type: Number,
    default: 0
  },
  reports: {
    type: Array,
    default: [],
  },
  recentLostAndFound: {
    type: Array,
    default: () => []
  },
  overall_resolved: {
    type: Number,
    default: 0
  },
  totalLost: {
    type: Array,
    default: () => []
  },
  totalFound: {
    type: Array,
    default: () => []
  },
  allLost: {
    type: Array,
    default: () => []
  },
  allFound: {
    type: Array,
    default: () => []
  },
  unSolved: {
    type: Array,
    default: () => []
  },
});

const store = usePendingRequestStore();
watch(
  () => props.pending_request_count,
  (val) => {
    if (val !== undefined) {
      store.setCount(val);  
    }
  },
  { immediate: true }
);

const storageProgress = 75; // Sample value for resolved
const storageDetails = [
  { label: 'Lost Items', color: '#FF5733' },
  { label: 'Found Items', color: '#33FF57' },
  { label: 'Resolved Cases', color: '#3357FF' }
];
const filterResolveCases = ref();
const filterSelectedForResolveCases = (data) => {
  filterResolveCases.value = data;
}

let getUserCount = ref();
let getReports = ref([]);
let getResolve = ref([]);
let overall_resolved = ref(0);
const getRecentLostAndFoundItem = ref([]);
const getTotalLost = ref([]);
const getTotalFound = ref([]);
const totalLostCount = ref(0);
const totalFoundCount = ref(0);
const getAllLost = ref([]);
const getAllFound = ref([]);
const getClaimed = ref([]);
const getUnSolved = ref([]);

watch(() => props.items, (newItem) => {
  getReports.value = newItem;
  console.log("reports: " , getReports.value)
  getClaimed.value = getReports?.value.filter(item => item.status === 'Claimed');
}, { immediate: true });

watch(() => props.user_count, (newItem) => {
  getUserCount.value = newItem;
}, { immediate: true });
watch(() => props.recentLostAndFound, (data) => {
  getRecentLostAndFoundItem.value = data;
}, { immediate: true });
watch(() => props.overall_resolved, (data) => {
  overall_resolved.value = data;
}, { immediate: true });
watch(() => props.totalLost, (data) => {
  getTotalLost.value = data;
  totalLostCount.value = data.reduce((sum, record) => sum + record.total, 0);
}, { immediate: true });
watch(() => props.totalFound, (data) => {
  getTotalFound.value = data;
  totalFoundCount.value = data.reduce((sum, record) => sum + record.total, 0);
}, { immediate: true });
watch(() => props.allLost, (data) => {
  getAllLost.value = data;
}, { immediate: true });
watch(() => props.allFound, (data) => {
  getAllFound.value = data;
}, { immediate: true });
watch(() => props.unSolved, (data) => {
  getUnSolved.value = data;

}, { immediate: true });

// kuhaon ang resolve na item tas eh process
// sa ResolveCasesChart
getResolve.value = props.items.filter(item => item.status === 'Claimed');
// console.log("resolved cases => " , getResolve.value)
let overViewData = ref({})
const counts = props.items.reduce((acc, item) => {
  if (item.status === 'Lost') acc.lost++;
  else if (item.status === 'Found') acc.found++;
  else if (item.status === 'Claimed') acc.claimed++;
  return acc;
}, { lost: 0, found: 0, claimed: 0 });

overViewData.value = {
  lostItems: counts.lost,
  fountItems: counts.found,
  resolve: counts.claimed,
}
 
</script>


<template>
  <Head title="Dashboard" />
  <AdminLayout>
    <div class="dashboard-container">
        <div class="container-top container-fluid pe-0 d-flex justify-content-between " >
            <div class=" header">
              <h1 class="fw-bold mb-2">Lost & Found Admin Dashboard</h1>
              <p class="text-muted">Manage reports, users, and system settings effectively.</p>
          </div>

          <div class="total-lost-and-found d-flex flex-column  justify-content-center align-items-center">
              <div class=" d-flex flex-row gap-2 pe-0">
            <TotalLostAndFound 
            :totalFoundItems="totalFoundCount"
            :totalLostItems="totalLostCount"
            :totalClaimedItems="getClaimed"
            />
            </div>
          </div>
      </div>

      <div class="contaner-fluid mt-5 pt-5">
           <!-- This get all the data not just by resolved according to the panelist huhu -->
            <ResolveCasesChart 
            :data="getReports"
            :lost="getTotalLost"
            :found="getTotalFound"
            />
           
            <div class="my-5">
               <ResolveCasesChartYearly :data="getReports"
            :lost="getTotalLost"
            :found="getTotalFound"
            />
            </div>
          </div>

      <OverAllResolved 
      :overallResolved="overall_resolved"
      />
      <!-- Cards Section -->
      <div class="card-bottom mt-5">
        <Overview :data="overViewData"/>
      </div>


      <Report :items="getReports"/>
    </div>
  </AdminLayout>
</template>

<style scoped>
@import '../../../css/admin/dashboard/dashboard.css';
</style>
