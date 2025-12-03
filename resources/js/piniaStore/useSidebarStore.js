import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useSidebarStore = defineStore('sidebar', () => {
  const isSidebarOpen = ref(localStorage.getItem("isSidebarOpen") === "true")

  const toggleSidebar = () => {
    isSidebarOpen.value = !isSidebarOpen.value
    localStorage.setItem("isSidebarOpen", isSidebarOpen.value)
  }

  const setSidebar = (value) => {
    isSidebarOpen.value = value
    localStorage.setItem("isSidebarOpen", value)
  }

  return {
    isSidebarOpen,
    toggleSidebar,
    setSidebar
  }
})
