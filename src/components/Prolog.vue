
<script>
  import Prolog from 'tau-prolog'
  import Triangle from '!raw-loader!../prolog/triangle.pl'

  export default {
    // Options / Data
    data () {
      return {
        session: Prolog.create()
      }
    },
    props: {
      triangle: Array,
      // circles: Array,
      depth: Number,
      // circles: Array
    },
    // computed: {},
    methods: {
      computeCircles: function(){
        let query = `circles(triangle(${this.triangle.map(p=>`point(${p.x}, ${p.y})`).join(', ')}), ${this.triangle.map(p=>p.name).join(', ')}).`;
        this.session.query( query );
        // console.log(query);
        this.session.answer( a => {
            let c = this.triangle.map(t => Object.assign(t, {r: a.lookup(t.name).value}));
            this.$emit('circles-change', c);
        });
      }
    },
    watch: { triangle: function(t){ this.computeCircles()} },
    render () {return ''},
    created () { this.session.consult(Triangle); },
    mounted () { this.computeCircles() },
    // beforeUpdate () {},
    // updated () {},
    // activated () {},
    // deactivated () {},
    // beforeDestroy () {},
    // destroyed () {},
    // Options / Assets
    // directives: {},
    // filters: {},
    // components: {},
    // Options / Misc
    // parent: null,
    // mixins: [],
    name: 'Prolog',
    // extends: {},
    // delimiters: [ '{{', '}}' ],
    // functional: false
  }
</script>
