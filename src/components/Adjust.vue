<template>
  <div class="container">
    <h1>Apollonian Gasket</h1>
    <div class="right">
      <h2>Depth: {{ depth }}</h2>
      <input v-model="depth" type="range" min="0" max="10" class="slider" @input="update">
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Adjust',
    data () { return { depth: 0} },
    methods: { update: function (){ this.$emit('depth-change', this.depth); } },
  }
</script>

<style scoped>
.container {
  position: fixed;
  width: 100vw;
  height: 45px;
  margin: 0;
  padding: 10px 0;
  color: #cfd8dc;
  background-color: #263238;
  /* z-index: -1; */
  display: flex;
  align-items: center;
  justify-content: space-between;
}

h1 {
  font-size: 40px;
  margin: 0 20px;
  font-weight: 100;
}

.right{
  margin: 0 20px;
}

h2 {
  font-size: 20px;
  font-weight: 400;
  margin: 0;
}

.slider {
  width: 250px; height: 16px;  border-radius: 8px;
  background: #cfd8dc;
  opacity: 0.7;
  -webkit-transition: .2s; transition: opacity .2s;
  -webkit-appearance: none; appearance: none; outline: none;
}

.slider:hover { opacity: 1; }

.slider::-webkit-slider-thumb {
  width: 20px; height: 20px; border-radius: 50%;
  background: #cddc39; cursor: pointer;
  appearance: none; -webkit-appearance: none;
}

.slider::-moz-range-thumb {
  width: 20px; height: 20px; border-radius: 50%;
  background: #cddc39; cursor: pointer;
}
</style>
