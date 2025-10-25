<script setup>
import { ref } from "vue";
import html2pdf from "html2pdf.js";

const props = defineProps({
  item: {
    type: Object,
    default: () => ({}),
  },
});

// ref to the content we want to export
const pdfContent = ref(null);

const formatDate = (dateString) => {
  if (!dateString) return "No date provided";
  const options = { year: "numeric", month: "long", day: "numeric" };
  return new Date(dateString).toLocaleDateString(undefined, options);
};

// Method that parent will call
const downloadPdf = async () => {
  try {
    const element = pdfContent.value;
    if (!element) throw new Error("No content to export");

    // Add PDF generation class to disable transitions
    element.classList.add('pdf-generation-active');

    // Wait for all images inside element to load
    const images = Array.from(element.querySelectorAll("img"));
    await Promise.all(
      images.map(
        (img) =>
          new Promise((resolve) => {
            if (img.complete) return resolve();
            img.onload = resolve;
            img.onerror = resolve; // Fail gracefully
          })
      )
    );

    const opt = {
      margin: 0.5,
      filename: `${props.item.title || "download"}.pdf`,
      image: { type: "jpeg", quality: 1 },
      html2canvas: {
        allowTaint: true,
        useCORS: true, // allow image loading from storage
        scale: 3, // improve sharpness
        onclone: function(clonedDoc) {
          // Ensure consistent styling in the cloned document
          const clonedElement = clonedDoc.querySelector('.modern-card');
          if (clonedElement) {
            clonedElement.classList.add('pdf-generation-active');
          }
        }
      },
      jsPDF: { unit: "in", format: "letter", orientation: "portrait" },
    };

    await html2pdf().from(element).set(opt).save();
    
    // Remove PDF generation class
    element.classList.remove('pdf-generation-active');
    
    return true;
  } catch (err) {
    console.error("Error generating PDF:", err);
    // Ensure class is removed even on error
    if (pdfContent.value) {
      pdfContent.value.classList.remove('pdf-generation-active');
    }
    throw err;
  }
};

// Expose so parent can call this with ref
defineExpose({ downloadPdf });
</script>

<template>
  <!-- wrap your content in ref="pdfContent" so it's exported -->
  <div ref="pdfContent" class="modern-card max-w-2xl mx-auto rounded-2xl overflow-hidden bg-white shadow-card">
    <!-- Header with Status - Fixed alignment -->
    <div class="card-header p-6 pb-4">
      <div class="flex justify-between items-start"> <!-- Changed from items-center to items-start -->
        <div class="flex-1 pr-4 min-w-0"> <!-- Added min-w-0 to prevent flex issues -->
          <h1 class="text-2xl font-bold text-gray-900 break-words">{{ item.title }}</h1>
          <p class="text-gray-600 mt-2 break-words">{{ item.description }}</p>
        </div>
        <span
          class="status-badge text-sm font-semibold tracking-wide px-3 py-1.5 rounded-full flex-shrink-0 whitespace-nowrap"  
          :class="item.status === 'Lost' ? 'bg-red-50 text-red-700 border border-red-200' : 'bg-green-50 text-green-700 border border-green-200'"
        >
          {{ item.status }}
        </span>
      </div>
    </div>

    <!-- Image Section -->
    <div class="image-container p-6 pt-0">
      <div class="image-wrapper rounded-xl overflow-hidden bg-gray-50 p-2 shadow-sm">
        <img
          :src="item.image_url"
          alt="Item Image"
          class="w-full h-auto max-h-[400px] object-contain"
          @load="handleImageLoad"
        />
      </div>
    </div>

    <!-- Info Section -->
    <div class="info-section p-6 pt-0">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <!-- Left Column -->
        <div class="space-y-4">
          <div class="info-item flex items-start">
            <div class="icon-wrapper bg-blue-50 p-2 rounded-lg mr-3">
              <i class="bi bi-calendar text-blue-600"></i>
            </div>
            <div>
              <p class="text-sm font-medium text-gray-500">Reported</p>
              <p class="text-gray-900">{{ formatDate(item.reported_at) }}</p>
            </div>
          </div>
          
          <div class="info-item flex items-start">
            <div class="icon-wrapper bg-purple-50 p-2 rounded-lg mr-3">
              <i class="bi bi-geo-alt text-purple-600"></i>
            </div>
            <div>
              <p class="text-sm font-medium text-gray-500">Location</p>
              <p class="text-gray-900 break-words">{{ item.location }}</p>
            </div>
          </div>
        </div>
        
        <!-- Right Column -->
        <div class="space-y-4">
          <div class="info-item flex items-start">
            <div class="icon-wrapper bg-green-50 p-2 rounded-lg mr-3">
              <i class="bi bi-telephone text-green-600"></i>
            </div>
            <div>
              <p class="text-sm font-medium text-gray-500">Contact</p>
              <p class="text-gray-900">{{ item.owner_phone_number || 'Not provided' }}</p>
            </div>
          </div>
          
          <div v-if="item.category" class="info-item flex items-start">
            <div class="icon-wrapper bg-amber-50 p-2 rounded-lg mr-3">
              <i class="bi bi-bookmark text-amber-600"></i>
            </div>
            <div>
              <p class="text-sm font-medium text-gray-500">Category</p>
              <p class="text-gray-900">{{ item.category }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Mobile Status (only shown on mobile) -->
    <div class="block md:hidden p-6 pt-0">
      <div class="bg-gray-50 rounded-lg p-4">
        <div class="flex items-center">
          <div class="icon-wrapper bg-gray-100 p-2 rounded-lg mr-3">
            <i class="bi bi-info-circle text-gray-600"></i>
          </div>
          <div>
            <p class="text-sm font-medium text-gray-500">Status</p>
            <p :class="item.status === 'Lost' ? 'text-red-600 font-semibold' : 'text-green-600 font-semibold'">
              {{ item.status }}
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.modern-card {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.card-header {
  border-bottom: 1px solid #f3f4f6;
}

.image-wrapper {
  transition: transform 0.2s ease;
}

.image-wrapper:hover {
  transform: translateY(-2px);
}

.status-badge {
  letter-spacing: 0.025em;
}

.info-item {
  transition: all 0.2s ease;
}

.info-item:hover {
  transform: translateX(4px);
}

.icon-wrapper {
  transition: all 0.2s ease;
}

.info-item:hover .icon-wrapper {
  transform: scale(1.05);
}

/* Disable all transitions and hover effects during PDF generation */
.pdf-generation-active .image-wrapper,
.pdf-generation-active .info-item,
.pdf-generation-active .icon-wrapper {
  transition: none !important;
  transform: none !important;
}

.pdf-generation-active .image-wrapper:hover,
.pdf-generation-active .info-item:hover,
.pdf-generation-active .info-item:hover .icon-wrapper {
  transform: none !important;
}
</style>