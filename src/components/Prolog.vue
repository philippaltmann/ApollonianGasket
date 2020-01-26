
<script>
  import Prolog from 'tau-prolog'
  // import Prolog from '../tau/tau-prolog.js'
  import Apollonian from '!raw-loader!../prolog/apollonian.pl'
  // var Prolog = require( "../tau/tau-prolog.js" );
  // var loader = require( "./path/to/tau-prolog/lists.js" );
  // loader( Prolog );
  // import json from '../p/gasket.json';


  export default {
    data () {
      return {
        session: Prolog.create(100000000), //up to 27 Hours calculations
        circles: []
      }
    },
    props: {
      triangle: Array,
      depth: Number
    },
    methods: {
      computeBase: function(triangle){
        this.circles = []
        let query = `basis(triangle(${triangle.map(p=>`(${p.x}, ${p.y})`).join(', ')}), G).`;
        // console.log(query);
        // console.log(triangle);
        let parsed = this.session.query( query );
        if( parsed !== true ) { console.log( parsed ); }
        for (var i = 0; i < this.depth; i++) {
          this.session.answer( a => {
            if(a) this.circles = this.circles.concat(a.lookup('G').toJavaScript())
          })
        }
        this.$emit('circles-change', this.circles);
      },
      computeCircles: function(){
        // let circles = []
        let query = `basis(triangle(${this.triangle.map(p=>`(${p.x}, ${p.y})`).join(', ')}), G).`;
        let parsed = this.session.query( query );
        if( parsed !== true ) { console.log( parsed ); }
        for (var i = 0; i < this.depth; i++) {
          this.session.answer( a => {
            if(a) this.circles = this.circles.concat(a.lookup('G').toJavaScript())
          })
        }

        // let start = Date.now()
        query = `gasket(${this.circles.map(c=>`(${c.join(', ')})`).join(', ')}, ${this.depth}, G).`;
        parsed = this.session.query( query );
        if( parsed !== true ) { console.error( parsed ); }
        this.session.answer( a => { if(a) {
          this.circles = this.circles.concat(a.lookup('G').toJavaScript())
          this.$emit('circles-change', this.circles);
          // const millis = Date.now() - start;
          // console.log(`Calculating Depth ${this.depth} via localStorage took: ${millis} MS`);
          } else { console.log('False'); console.log(a); }
        })

        // Alternative Data Flow using localStorage
        // let start = Date.now()
        /*query = `writeGasket(${this.circles.map(c=>`(${c.join(', ')})`).join(', ')}, ${this.depth}, 'result').`;
        parsed = this.session.query( query );
        if( parsed !== true ) { console.error( parsed ); }
        this.session.answer( a => { if(a) {
          var data = JSON.parse(localStorage.getItem('result'));
          this.$emit('circles-change', this.circles.concat(data.gasket));
          const millis = Date.now() - start;
          console.log(`Calculating Depth ${this.depth} via localStorage took: ${millis} MS`);
          localStorage.removeItem('result')
          } else { console.log('False'); console.log(a); }
        })*/

        // Loading Gasket from external generated json
        //let start = Date.now()
        /*fetch('./gasket.json').then(r => r.json()).then((d) => {
            // console.log(d.gasket.length);
            this.$emit('circles-change', d.gasket);
            // const millis = Date.now() - start;
            // console.log(`Loading Depth 10 JSON took: ${millis} MS`);
         });*/

        // this.$emit('circles-change', circles);
      }
    },
    watch: {
      depth: function(d){ this.computeCircles() }
    },
    render () {return ''},
    created () { this.session.consult(Apollonian); },
    mounted () { this.computeCircles() },
    name: 'Prolog',
  }
</script>
