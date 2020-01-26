
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
        circles: [],
        fetch: {
          active: false,
          controller: new AbortController()
        }
      }
    },
    props: {
      triangle: Array,
      depth: Number
    },
    methods: {
      computeBase: function(triangle){
        this.circles = []
        //TODO simplify basis prolog code
        let query = `basis(triangle(${triangle.map(p=>`(${p.x}, ${p.y})`).join(', ')}), G).`;
        let parsed = this.session.query( query );
        if( parsed !== true ) { console.log( parsed ); }
        this.session.answer( a => {
          if(a) this.circles = this.circles.concat(a.lookup('G').toJavaScript())
        })
        this.$emit('circles-change', this.circles);
      },
      computeCircles: function(){

        // TODO abort old request
        // let start = Date.now()
        let query = this.triangle.map((t,i) => `x${i+1}=${t.x}&y${i+1}=${t.y}`).join('&')
        query = `${query}&depth=${this.depth}`
       fetch(`http://localhost:8008/gasket?${query}`,{ cache: "force-cache" })
         .then(r => r.json()).then((response) => {
           this.$emit('circles-change', response);
             // const millis = Date.now() - start;
             // console.log(`Fetching Depth ${this.depth} via Prolog HTTP took: ${millis} MS`);
        }).catch(e => console.log(e))

        // let circles = []
        /*let query = `basis(triangle(${this.triangle.map(p=>`(${p.x}, ${p.y})`).join(', ')}), G).`;
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
        })*/
      }
    },
    watch: {
      depth: function(){ this.computeCircles() }
    },
    render () {return ''},
    created () { this.session.consult(Apollonian); },
    mounted () { this.computeCircles() },
    name: 'Prolog',
  }
</script>
