<script>
export default{
    props: ['categories'],
    data() {
        return {
            activeCategory: ''
        }
    },
    methods: {
        chooseCategoryFunc(name,  id) {
        this.activeCategory = id;
        this.$emit('categorySelected', name)
    }
    }
}
</script>
<template>
  <div class="container-fluid d-flex align-items-center gap-2">
    <div>Categories:</div>
    <div class="category-scroll d-flex gap-2">
      <div class="list px-2 py-1 rounded"
          v-for="data in categories" :key="data.id"
          :class="{ 'bg-secondary text-light': activeCategory === data.id }"
          @click="chooseCategoryFunc(data.name, data.id)"
          :title="data?.description || data.name"
      >
        {{ data.name }}
      </div>
    </div>
  </div>
</template>


<style lang="css" scoped>

    .list{
        background: rgba(0,0,0,.1);
        cursor: pointer;
    }
    .list:hover{
        background: rgba(0,0,0,.2);
    }
    .category-scroll {
   overflow-x: auto;
   flex: 1 1 0;         /* Allow it to shrink */
  min-width: 0;        /* Prevent overflow in flex container */
  overflow-x: auto;
}
.category-scroll .list{
   width: auto;
     white-space: nowrap;
}
@media screen and (max-width: 756px){
     .category-scroll {
  overflow-x: auto;
  white-space: nowrap;
  flex-wrap: nowrap;
  -webkit-overflow-scrolling: touch;
}
.category-scroll::-webkit-scrollbar {
  display: none; 
}
}
</style>