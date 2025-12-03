<template>
    <div class="col-md-4">
      <div class="testimonial-card">
        <strong>{{ name }}</strong> {{ username }}
        <p>{{ message }}</p>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    props: ["name", "username", "message"],
  };
  </script>
  
  <style scoped>
  .testimonial-card {
    background: #fff;
    padding: 15px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
  }
  </style>
  