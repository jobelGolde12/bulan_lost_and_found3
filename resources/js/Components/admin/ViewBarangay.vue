<script setup>
import { computed, ref } from 'vue'
import { Link, router } from '@inertiajs/vue3'
import axios from 'axios'

const props = defineProps({
  barangay: String,
  data: Object
})

const items = ref([])
const hasFetched = ref(false)
const isLoading = ref(false)
let currentStatus = ref("Lost")
const isRedirecting = ref(false)
const expandedTitle = ref({})
const expandedDesc = ref({})

const navigateTo = (id) => {
  isRedirecting.value = true
  setTimeout(() => {
    router.visit(route('viewItemInfoAsAdmin', { item: id }))
  }, 800)
}

const fetchItems = async (status) => {
  try {
    isLoading.value = true
    hasFetched.value = true
    const response = await axios.get(route('barangay.items'), {
      params: {
        barangay: props.barangay,
        status: status
      }
    })
    currentStatus.value = status
    items.value = response.data
  } catch (error) {
    console.error('Error fetching items:', error)
  } finally {
    isLoading.value = false
  }
}

const formatDate = (dateString) => {
  const date = new Date(dateString)
  return date.toLocaleString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

const getLimitedText = (text, wordLimit, expanded) => {
  if (!text) return ''
  const words = text.split(' ')
  if (expanded || words.length <= wordLimit) return text
  return words.slice(0, wordLimit).join(' ') + '...'
}

const hasMoreWords = (text, wordLimit) => {
  if (!text) return false
  return text.split(' ').length > wordLimit
}

const toggleExpand = (type, index) => {
  if (type === 'title') {
    expandedTitle.value[index] = !expandedTitle.value[index]
  } else if (type === 'desc') {
    expandedDesc.value[index] = !expandedDesc.value[index]
  }
}
</script>

<template>
  <div class="view-barangay-container">
    <div class="content">
      <div class="stats-grid">
        <button @click.prevent="fetchItems('Lost')" class="stat-card lost">
          <h3>{{ data?.Lost }}</h3>
          <p>Lost Items</p>
        </button>

        <button @click.prevent="fetchItems('Found')" class="stat-card found">
          <h3>{{ data?.Found }}</h3>
          <p>Found Items</p>
        </button>
      </div>
    </div>

    <div class="table-section">
      <div v-if="isLoading" class="info-section loading">
        Fetching reports, please wait...
      </div>

      <div v-else-if="isRedirecting" class="info-section redirecting">
        Redirecting to Reports Page...
      </div>

      <div v-else-if="!hasFetched" class="info-section">
        Please click <b>Lost Items</b> or <b>Found Items</b> to view reports.
      </div>

      <div v-else-if="hasFetched && items.length === 0" class="info-section">
        No items found for this category in {{ barangay }}.
      </div>

      <table v-else class="items-table">
        <thead>
          <tr>
            <th>Title</th>
            <th>Category</th>
            <th>Description</th>
            <th>Location</th>
            <th>Contact</th>
            <th>
              <span v-if="currentStatus === 'Lost'">Lost at</span>
              <span v-else>Found at</span>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr 
            v-for="(item, index) in items" 
            :key="index"
            @click="navigateTo(item.id)" 
            class="clickable-row"
          >
            <td>
              <span>{{ getLimitedText(item.title, 7, expandedTitle[index]) }}</span>
              <button 
                v-if="hasMoreWords(item.title, 7)" 
                @click.stop="toggleExpand('title', index)"
                class="toggle-btn"
              >
                {{ expandedTitle[index] ? 'less' : 'more' }}
              </button>
            </td>

            <td>{{ item.category }}</td>

            <td>
              <span>{{ getLimitedText(item.description, 7, expandedDesc[index]) }}</span>
              <button 
                v-if="hasMoreWords(item.description, 7)" 
                @click.stop="toggleExpand('desc', index)"
                class="toggle-btn text-success"
              >
                {{ expandedDesc[index] ? ' ...show less' : ' ...show more' }}
              </button>
            </td>

            <td>{{ item.location }}</td>
            <td>{{ item.owner_phone_number || 'N/A' }}</td>
            <td>{{ formatDate(item.reported_at) }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<style scoped>
.view-barangay-container {
  background: #ffffff;
  border-radius: 20px;
  padding: 32px;
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  border: 1px solid #f0f0f0;
}

.stats-grid {
  display: flex;
  gap: 20px;
  justify-content: space-between;
  flex-wrap: wrap;
}

.stat-card {
  flex: 1;
  background: linear-gradient(135deg, #f8faff 0%, #f0f4ff 100%);
  border-radius: 16px;
  text-align: center;
  padding: 28px 20px;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  border: 1px solid #e8edff;
  min-width: 200px;
  position: relative;
  overflow: hidden;
}

.stat-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
  transform: scaleX(0);
  transition: transform 0.3s ease;
}

.stat-card.lost::before {
  background: linear-gradient(90deg, #ff6b6b 0%, #ff8e8e 100%);
}

.stat-card.found::before {
  background: linear-gradient(90deg, #4ecdc4 0%, #44a08d 100%);
}

.stat-card:hover::before {
  transform: scaleX(1);
}

.stat-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
  border-color: #d1dcff;
}

.stat-card h3 {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 8px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.stat-card.lost h3 {
  background: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.stat-card.found h3 {
  background: linear-gradient(135deg, #4ecdc4 0%, #44a08d 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.stat-card p {
  color: #64748b;
  font-weight: 600;
  font-size: 1.1rem;
  margin: 0;
}

.table-section {
  margin-top: 32px;
}

.items-table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  margin-top: 20px;
  font-size: 15px;
  background: white;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
}

.items-table th {
  color: rgb(17, 17, 17);
  font-weight: 600;
  padding: 18px 16px;
  border-bottom: 5px solid #fff;
  font-size: 0.95rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.items-table td {
  padding: 16px;
  border-bottom: 1px solid #f1f5f9;
  border-right: 1px solid #f1f5f9;
  background: white;
  transition: all 0.2s ease;
}

.items-table tr:last-child td {
  border-bottom: none;
}

.items-table td:last-child {
  border-right: none;
}

.clickable-row {
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
}

.clickable-row:hover {
  background: #f8faff;
}

.clickable-row:hover td {
  background: #f8faff;
}

.clickable-row::after {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 3px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.clickable-row:hover::after {
  opacity: 1;
}

.toggle-btn {
  background: none;
  border: none;
  color: #667eea;
  cursor: pointer;
  font-size: 0.85rem;
  font-weight: 600;
  margin-left: 4px;
  padding: 2px 6px;
  border-radius: 4px;
  transition: all 0.2s ease;
}

.toggle-btn:hover {
  background: #667eea;
  color: white;
}

.toggle-btn.text-success {
  color: #4ecdc4;
}

.toggle-btn.text-success:hover {
  background: #4ecdc4;
  color: white;
}

.info-section {
  background: linear-gradient(135deg, #f8faff 0%, #f0f4ff 100%);
  border-radius: 16px;
  padding: 24px;
  font-size: 16px;
  color: #475569;
  line-height: 1.6;
  border-left: 6px solid #667eea;
  margin-top: 20px;
  text-align: center;
  font-weight: 500;
}

.info-section.loading {
  border-left-color: #ffbb33;
  background: linear-gradient(135deg, #fff9e6 0%, #fff3d9 100%);
  color: #b45309;
}

.info-section.redirecting {
  border-left-color: #4ecdc4;
  background: linear-gradient(135deg, #f0fff4 0%, #e6fffa 100%);
  color: #065f46;
}

@media (max-width: 768px) {
  .view-barangay-container {
    padding: 20px;
    border-radius: 16px;
  }
  
  .stats-grid {
    gap: 12px;
  }
  
  .stat-card {
    min-width: calc(50% - 6px);
    padding: 20px 12px;
  }
  
  .stat-card h3 {
    font-size: 2rem;
  }
  
  .items-table {
    font-size: 14px;
  }
  
  .items-table th,
  .items-table td {
    padding: 12px 8px;
  }
}
</style>