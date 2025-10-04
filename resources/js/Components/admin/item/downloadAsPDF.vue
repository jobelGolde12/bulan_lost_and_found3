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

    const opt = {
      margin: 0.5,
      filename: `${props.item.title || "download"}.pdf`,
      image: { type: "jpeg", quality: 0.98 },
      html2canvas: { scale: 2 },
      jsPDF: { unit: "in", format: "letter", orientation: "portrait" },
    };

    await html2pdf().from(element).set(opt).save();
    return true; // success
  } catch (err) {
    console.error("Error generating PDF:", err);
    throw err;
  }
};

// Expose so parent can call this with ref
defineExpose({ downloadPdf });
</script>

<template>
  <!-- 🔽 wrap your content in ref="pdfContent" so it's exported -->
  <div ref="pdfContent" class="max-w-lg mx-auto rounded-2xl overflow-hidden ">
    <!-- Status -->
    <div class="text-center mt-6">
      <span
        class="text-3xl font-extrabold tracking-wide px-4 py-2 rounded-lg"
        :class="item.status === 'Lost' ? 'bg-red-100 text-red-600' : 'bg-green-100 text-green-600'"
      >
        {{ item.status }}
      </span>
    </div>

    <!-- Image -->
    <div class="mt-6 flex justify-center">
      <img
        :src="item.image_url"
        alt="Item Image"
        class="w-full h-auto max-h-[500px] object-contain rounded-xl"
      />
    </div>

    <!-- Title + Description -->
    <div class="p-6">
      <h2 class="text-2xl font-bold text-gray-800 mb-2">{{ item.title }}</h2>
      <p class="text-gray-600 mb-4">{{ item.description }}</p>
      <p class="flex items-center text-gray-500 text-sm">
        <i class="bi bi-calendar me-2"></i> {{ formatDate(item.reported_at) }}
      </p>
    </div>

    <!-- Desktop Info -->
    <div class="hidden lg:block px-6 pb-6 text-gray-700 text-sm space-y-2">
      <p><i class="bi bi-geo-alt me-2 text-gray-500"></i>{{ item.location }}</p>
      <p><i class="bi bi-telephone me-2 text-gray-500"></i>{{ item.owner_phone_number || 'NA' }}</p>
      <p v-if="item.category">
        <i class="bi bi-bookmark me-2 text-gray-500"></i>{{ item.category || "NA" }}
      </p>
    </div>

    <!-- Mobile Info -->
    <div class="block lg:hidden px-6 pb-6 text-gray-700 text-sm space-y-2">
      <p><i class="bi bi-geo-alt-fill me-2 text-gray-500"></i>{{ item.location }}</p>
      <p><i class="bi bi-telephone-fill me-2 text-gray-500"></i>{{ item.owner_phone_number || 'NA' }}</p>
      <p v-if="item.category">
        <i class="bi bi-bookmark-fill me-2 text-gray-500"></i>{{ item.category || "NA" }}
      </p>
      <p>
        <i class="bi bi-info-circle-fill me-2 text-gray-500"></i>
        <span :class="item.status === 'Lost' ? 'text-red-600 font-semibold' : 'text-green-600 font-semibold'">
          {{ item.status }}
        </span>
      </p>
    </div>
  </div>
</template>

<style scoped>
/* optional custom overrides */
</style>
