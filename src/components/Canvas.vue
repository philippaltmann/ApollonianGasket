<template>
  <canvas id="canvas" :width="width" :height="height"></canvas>
</template>
<script>
  export default {
    data () {
      return {
        edit: -1,
        context: undefined,
        padding: 5
      }
    },
    props: {
      triangle: Array,
      circles: Array,
      height: Number,
      width: Number
  },
    methods: {
      resetCanvas: function(){
        this.context.clearRect(0, 0, this.width, this.height);
      },
      drawTriangle: function(){
        this.triangle.forEach(p => {
          this.context.beginPath()
          this.context.moveTo(p.x,p.y);
          this.context.arc(p.x, p.y, 5, 0, Math.PI * 2, true);
          this.context.fill();
        })
      },
      drawCircles: function(){
        // let start = Date.now()
        this.circles.forEach(c => {
          this.context.beginPath();
          this.context.arc(c[0], c[1], Math.abs(c[2]), 0, Math.PI * 2, false);
          this.context.stroke()
        })
        // const millis = Date.now() - start;
        // console.log(`Drawing Depth 10 Gasket took: ${millis} MS`);
      }
    },
    watch: {
      triangle: function () {
        this.resetCanvas()
        this.drawTriangle()
      },
      circles: function () {
        this.resetCanvas()
        this.drawCircles()
        this.drawTriangle()
      }
    },
    mounted () {
      let canvas = document.getElementById('canvas');
      this.context = canvas.getContext('2d');
      this.context.fillStyle = "#cddc39";
      this.context.strokeStyle = "#ad1457";//"#263238";
      this.drawTriangle(this.triangle);

      const matchPoint = (e,p) => (Math.abs(p.x-e.layerX) < this.padding && Math.abs(p.y-e.layerY) < this.padding)

      canvas.onmousedown = e => this.edit = this.triangle.findIndex(p => matchPoint(e, p));
      canvas.onmouseup = () => {
        this.edit = -1;
        this.$emit('update-gasket');
      }

      canvas.onmousemove = (e) => {
        if(this.edit != -1){
          let triangle = this.triangle.splice(0)
          triangle[this.edit].x = e.layerX;
          triangle[this.edit].y = e.layerY;
          // console.log(triangle);
          this.$emit('triangle-change', triangle)
        }
      };
    },
    name: 'Canvas',
  }
</script>
