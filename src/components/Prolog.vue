<script>
  import Prolog from 'tau-prolog'
  import Apollonian from '!raw-loader!../prolog/apollonian.pl'

  export default {
    name: 'Prolog',
    data () { return { session: Prolog.create(), circles: [], } },
    props: { triangle: Array, depth: Number },
    methods: {
      computeBase: function(triangle){
        this.circles = []
        let query = `tangent(${triangle.map(p=>`(${p.x}, ${p.y})`).join(', ')}, G).`;
        if(this.session.query(query)) {
          this.session.answer( a => {
            if(a) this.$emit('circles-change', a.lookup('G').toJavaScript())
          })
        }
      },
      computeCircles: function(){
        let query = this.triangle.map((t,i) => `x${i+1}=${t.x}&y${i+1}=${t.y}`).join('&')
        query = `${query}&depth=${this.depth}`
       fetch(`http://localhost:8008/gasket?${query}`,{ cache: "force-cache" })
         .then(r => r.json()).then((r) => this.$emit('circles-change', r))
         .catch(e => console.log(e))
      }
    },
    watch: { depth: function(){ this.computeCircles() } },
    created () { this.session.consult(Apollonian); },
    mounted () { this.computeCircles() },
    render () {return ''}
  }
</script>
