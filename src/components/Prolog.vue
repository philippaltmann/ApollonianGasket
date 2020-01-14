
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
        let parsed = this.session.query( query );
        if( parsed !== true ) { console.log( parsed ); }
        // console.log(query);
        let circles = []
        this.session.answer( a => {
            // console.log(a.toString());
            circles = this.triangle.map(t => Object.assign(t, {r: a.lookup(t.name).value}));
            // this.$emit('circles-change', c);
        });
        // console.log(circles);

        //Inner Circle
        query = `inner(triangle(${this.triangle.map(p=>`point(${p.x}, ${p.y})`).join(', ')}), X, Y, R).`;
        parsed = this.session.query( query );
        if( parsed !== true ) { console.log( parsed ); }
        // console.log(query);
        this.session.answer( a => {
            let circle = {x: a.lookup('X').value, y: a.lookup('Y').value, r: a.lookup('R').value}
            circles.push(circle);
            // console.log(a.toString());
            // this.$emit('circles-change', c);
        });
        // console.log(circles);

        //Outer Circle
        query = `outer(triangle(${this.triangle.map(p=>`point(${p.x}, ${p.y})`).join(', ')}), X, Y, R).`;
        parsed = this.session.query( query );
        if( parsed !== true ) { console.log( parsed ); }
        // console.log(query);
        this.session.answer( a => {
            let circle = {x: a.lookup('X').value, y: a.lookup('Y').value, r: a.lookup('R').value}
            circles.push(circle);
            // console.log(a.toString());
            // this.$emit('circles-change', c);
        });
        // console.log(circles);
        this.$emit('circles-change', circles);


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
