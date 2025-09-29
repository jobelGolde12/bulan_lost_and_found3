<script setup>
import { defineProps } from 'vue';

const props = defineProps({
  overallResolved: {
    type: Number,
    default: 0
  }
});
</script>


<template>

  <div>

    <div class="grid-container d-flex justify-center align-center mb-3">
      <div class="card shadow-sm" style="width: 80%;">
        <h1 class="title text-muted">Overall Resolved Cases</h1>
        <div class="content text-center">
            <h1 class="count me-5">{{ props.overallResolved }}</h1>
        <div class="">Number of Resolved Cases Recorded in this System </div>
        </div>
  </div>
</div>
  </div>
</template>
<style scoped>

body {
  background: #d0dbe1;
  padding: 2rem;
}

.grid-container {
  width: min(75rem, 100%);
  margin-inline: auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(min(20rem, 100%), 1fr));
  gap: 2rem;
}

.card {
  --grad: red, blue;
  padding: 2.5rem;
  background-image: linear-gradient(to bottom left, #e0e4e5, #f2f6f9);
  border-radius: 2rem;
  gap: 1.5rem;
  display: grid;
  grid-template: 'title icon' 'content content' 'bar bar' / 1fr auto;
  font-family: system-ui, sans-serif;
  color: #444447;
}

/* Title */
.card .title {
  font-size: 1.5rem;
  grid-area: title;
  align-self: end;
  text-transform: uppercase;
  font-weight: 500;
  word-break: break-all;
}

/* Icon */
.card .icon {
  grid-area: icon;
  font-size: 3rem;
}

.card .icon > i {
  color: transparent;
  background: linear-gradient(to right, var(--grad));
  -webkit-background-clip: text;
  background-clip: text;
}

/* Content */
.card .content {
  grid-area: content;
}

.card .content > *:first-child {
  margin-top: 0rem;
}

.card .content > *:last-child {
  margin-bottom: 0rem;
}

/* Gradient bar */
.card::after {
  content: "";
  grid-area: bar;
  height: 2px;
  background-image: linear-gradient(90deg, var(--grad));
}
.count{
  font-size: 4rem;
  font-weight: 800;
}
</style>
