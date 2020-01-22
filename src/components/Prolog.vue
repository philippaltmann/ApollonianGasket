
<script>
  import Prolog from 'tau-prolog'
  import Apollonian from '!raw-loader!../prolog/apollonian.pl'

  export default {
    data () {
      return { session: Prolog.create() }
    },
    props: {
      triangle: Array,
      depth: Number,
    },
    methods: {
      computeCircles: function(){
        let circles = []
        let query = `basis(triangle(${this.triangle.map(p=>`(${p.x}, ${p.y})`).join(', ')}), G).`;
        let parsed = this.session.query( query );
        if( parsed !== true ) { console.log( parsed ); }
        for (var i = 0; i < this.depth; i++) {
          this.session.answer( a => if(a){ circles = circles.concat(a.lookup('G').toJavaScript())})
        }

        query = `gasket(${circles.map(c=>`(${c.join(', ')})`).join(', ')}, ${this.depth}, G).`;
        parsed = this.session.query( query );
        if( parsed !== true ) { console.error( parsed ); }
        for (var j = 0; j < this.depth; j++) {
          this.session.answer( a => { if(a) {
              circles = circles.concat(a.lookup('G').toJavaScript())
            } else { console.log('False'); }
          })
        }

        this.$emit('circles-change', circles);
      }
    },
    watch: {
      triangle: function(){ this.computeCircles()},
      depth: function(d){
        console.log(d);
        this.computeCircles()

      }
    },
    render () {return ''},
    created () { this.session.consult(Apollonian); },
    mounted () { this.computeCircles() },
    name: 'Prolog',
  }
</script>
