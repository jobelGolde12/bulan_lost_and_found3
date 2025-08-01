<script setup>
import { Head } from '@inertiajs/vue3';
import { computed, defineProps, ref, watch } from 'vue';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import TotalLostItemCard from '@/Components/admin/dashboard/TotalLostItemCard.vue';
import TotalFoundItemCard from '@/Components/admin/dashboard/TotalFoundItemCard.vue';
import ResolveCasesChart from '@/Components/admin/dashboard/ResolveCasesChart.vue';
import ResolveCasesChartYearly from '@/Components/admin/dashboard/ResolveCasesChartYearly.vue';
import PendingRequest from '@/Components/admin/dashboard/PendingRequest.vue';
import PendingRequestCard from '@/Components/admin/dashboard/PendingRequestCard.vue';
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
  }
});

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
const getRecentLostAndFoundItem = ref([]);
watch(() => props.items, (newItem) => {
  getReports.value = newItem;
}, { immediate: true });

watch(() => props.user_count, (newItem) => {
  getUserCount.value = newItem;
}, { immediate: true });
watch(() => props.recentLostAndFound, (data) => {
  getRecentLostAndFoundItem.value = data;
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
      <!-- para sa large screen  -->
      <div class="container-fluid px-0 d-flex flex-row justify-content-between align-items-center d-none d-lg-block">
        <div class="container-top container-fluid pe-0 d-flex flex-row justify-content-between" style="min-height: 300px;  max-height: 200px;" >
            <div class=" pt-4 ps-0 header">
              <h1 class="fw-bold mb-2">Lost & Found Admin Dashboard</h1>
              <p class="text-muted">Manage reports, users, and system settings effectively.</p>
          </div>

          <div class="d-flex flex-column w-50 h-50">
            <div class=" d-flex flex-row gap-2 pe-0">
           <TotalLostItemCard :lostItems="counts.lost" class="top-card"/>
           <TotalFoundItemCard :foundItems="counts.found" class="top-card "/>
          </div>
          </div>
      </div>
      </div>
      <!-- Para sa small screen  -->
      <div class="container-fluid px-0 d-flex flex-column pt-2 justify-content-between align-items-center d-block d-lg-none">
          <div class="container-fluid text-center">
              <h1 class="fw-bold">Lost & Found Admin Dashboard</h1>
              <p class="text-muted">Manage reports, users, and system settings effectively.</p>
          </div>

            <div class=" d-flex flex-row gap-2 pe-0">
              <TotalLostItemCard :lostItems="counts.lost" class="top-card"/>
              <TotalFoundItemCard :foundItems="counts.found" class="top-card "/>
            </div>
      </div>

      <div class="container-fluid d-flex justify-content-end">
            <PendingRequest :count="pending_request_count"/>
      </div>

      <div class="contaner-fluid">
            <ResolveCasesChart :resolve="getResolve" v-if="filterValue === 'month'"/>
            <ResolveCasesChartYearly :resolve="counts.claimed" v-if="filterValue === 'year'"/>
          </div>

      <!-- Cards Section -->
      <div class="card-bottom d-flex justify-content-between align-items-center rounded"
      style="background: linear-gradient(0deg, #f3d9fb, #d0f5ee); padding: 1rem; border-radius: 0 0 12px 12px;"
>
      

        <Overview :data="overViewData"/>

        <div class="">
          <UserRegistration :getUserCountValue="getUserCount" class="registered-user"/>
        </div>

      </div>



        <!-- Recent Files Section -->
       <RecentLostAndFoundReports :reports="getRecentLostAndFoundItem"/>
    </div>
  </AdminLayout>
</template>

<style scoped>
.container-top{
  position: relative;
  height: 70%;
}
.card-top{
  max-height: 10vh;
}
.dashboard-container {
  padding: 20px;
  height: 100%;
  overflow-x: hidden;
  overflow-y: scroll;
}
.progress-circle {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  background: conic-gradient(var(--progress, 0%) #4CAF50, #e0e0e0 0%);
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 1.2rem;
  font-weight: bold;
  color: #333;
}
.progress-circle span {
  position: absolute;
}
.dot {
  display: inline-block;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  margin-right: 5px;
}
.overview-chart {
  width: 300px;
  height: 250px;
  margin: auto;
}
.card-bottom{
  flex-direction: row;
}
/* sm  */
@media screen and (max-width: 576px){ 
  .card-bottom{
    flex-direction: column;
  }
}

</style>
