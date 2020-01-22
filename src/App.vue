<template>
  <div id="app">
    <Adjust v-on:depth-change="updateDepth"/>
    <Prolog :triangle="triangle" :depth="depth"
            v-on:circles-change="updateCircles"/>
    <Canvas :width="width" :height="height"
            :circles="circles" :triangle="triangle"
            v-on:triangle-change="updateTriangle"/>
  </div>
</template>

<script>
import Adjust from './components/Adjust.vue'
import Canvas from './components/Canvas.vue'
import Prolog from './components/Prolog.vue'

export default {
  name: 'app',
  components: { Adjust, Canvas, Prolog },
  data () {
    return {
      triangle: [
        {name: 'A', x:550, y:400},
        {name: 'B', x:820, y:450},
        {name: 'C', x:650, y:650}
      ],
      circles: [],
      height: window.innerHeight,
      width: window.innerWidth,
      depth: 2
    }
  },
  methods: {
    updateTriangle: function(t) { this.triangle = t.splice(0); },
    updateCircles: function(c) { this.circles = c.splice(0); },
    updateDepth: function(d) { this.depth = parseInt(d); },
  },
}
</script>

<style>

body { margin: 0; background-color: #cfd8dc; }
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #263238;
}

</style>
