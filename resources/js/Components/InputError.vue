<script setup>
import { ref, defineProps, watch, onBeforeUnmount } from 'vue'
import { toggleLoginButton } from '@/piniaStore/ToggleLoginButtonDisable'

const props = defineProps({
  message: String,
})

const toggleButton =toggleLoginButton();
const countdown = ref(null)
let interval = null
let attemptsError = ref(false);
watch(
  () => props.message,
  (newVal) => {
    if (newVal === 'Too many login attempts.') {
        attemptsError.value = true;
      startCountdown()
    } else {
      stopCountdown()
      attemptsError.value = false;
    }
  }
)

function startCountdown() {
  countdown.value = 60

  if (interval) clearInterval(interval)

  interval = setInterval(() => {
    if (countdown.value > 0) {
      countdown.value--
    } else {
      stopCountdown()
      attemptsError.value = false;
    }
  }, 1000)
  toggleButton.toggleButtonValue();
}

function stopCountdown() {
  if (interval) {
    clearInterval(interval)
    interval = null
    toggleButton.toggleButtonValue();
  }
}
onBeforeUnmount(stopCountdown)

</script>

<template>
  <div v-show="message">
    <p v-if="attemptsError == true && message == 'Too many login attempts.'" class="text-sm text-red-600">
     {{ message }} Please try again in {{ countdown }} seconds.
    </p>

    <p v-else-if="message !== 'Too many login attempts.'" class="text-sm text-red-600">
      {{ message }}
    </p>
  </div>
</template>
