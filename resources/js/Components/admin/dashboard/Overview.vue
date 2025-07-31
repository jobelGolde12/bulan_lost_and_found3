<template>
    <div>
      <div class="card border-0 bg-transparent" style="min-width: 300px; background: #fff; border-radius: 12px;">
        <div class="card-body">
          <h5 class="card-title mb-4">Overview</h5>
  
          <!-- Chart Section -->
          <div
            class="d-flex flex-column justify-content-center align-items-center"
            style="height: 180px; margin-bottom: 24px;"
          >
            <ECharts
              :option="overviewChartOptions"
              autoresize
              style="width: 140px; height: 140px;"
            />
          </div>
  
          <!-- Legend Section (Flex Column) -->
          <div class="d-flex flex-column align-items-center gap-2">
            <div class="d-flex align-items-center" style="font-size: 13px;">
              <span class="rounded-circle me-2" style="width: 10px; height: 10px; background-color: #FFC043;"></span>
              Lost items
            </div>
            <div class="d-flex align-items-center" style="font-size: 13px;">
              <span class="rounded-circle me-2" style="width: 10px; height: 10px; background-color: #6B8BFF;"></span>
              Found items
            </div>
            <div class="d-flex align-items-center" style="font-size: 13px;">
              <span class="rounded-circle me-2" style="width: 10px; height: 10px; background-color: #7ED957;"></span>
              Resolved cases
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  
  <script setup>
  import { ref, computed, defineProps, watch } from 'vue'
  import { use } from 'echarts/core'
  import { PieChart } from 'echarts/charts'
  import {
    TitleComponent,
    TooltipComponent,
    LegendComponent,
    GraphicComponent
  } from 'echarts/components'
  import { CanvasRenderer } from 'echarts/renderers'
  import ECharts from 'vue-echarts'
  
  use([
    CanvasRenderer,
    PieChart,
    TitleComponent,
    TooltipComponent,
    LegendComponent,
    GraphicComponent
  ])
  
  const props = defineProps({
    data: {
        type: Object,
        default: () => ({})
    }
  })

  let getData = ref({});
  watch(
    () => props.data,
    (newItem) => {
        getData.value = newItem;
    },
    {immediate: true}
  )
  const countLostItems = getData.value.lostItems;
const countFoundItems = getData.value.fountItems;
const countResolvedCases = getData.value.resolve;
  const totalCases = countLostItems + countFoundItems + countResolvedCases
  
  const storageProgress = computed(() =>
    totalCases ? Math.round((countResolvedCases / totalCases) * 100) : 0
  )
  
  const overviewChartOptions = ref({
    tooltip: {
      trigger: 'item'
    },
    legend: { show: false }, // hide internal legend
    graphic: {
      elements: [
        {
          type: 'text',
          left: 'center',
          top: 'center',
          style: {
            text: `${storageProgress.value}%`,
            fontSize: 16,
            fontWeight: 'bold',
            fill: '#333'
          }
        }
      ]
    },
    series: [
      {
        name: 'Overview',
        type: 'pie',
        radius: ['50%', '80%'],
        avoidLabelOverlap: false,
        label: { show: false },
        emphasis: {
          scale: true,
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.2)'
          }
        },
        labelLine: { show: false },
        data: [
          { value: countLostItems, name: 'Lost items', itemStyle: { color: '#FFC043' } },
          { value: countFoundItems, name: 'Found items', itemStyle: { color: '#6B8BFF' } },
          { value: countResolvedCases, name: 'Resolved cases', itemStyle: { color: '#7ED957' } }
        ]
      }
    ]
  })
  </script>
  