(function(e){function t(t){for(var i,s,o=t[0],c=t[1],u=t[2],h=0,d=[];h<o.length;h++)s=o[h],Object.prototype.hasOwnProperty.call(r,s)&&r[s]&&d.push(r[s][0]),r[s]=0;for(i in c)Object.prototype.hasOwnProperty.call(c,i)&&(e[i]=c[i]);l&&l(t);while(d.length)d.shift()();return a.push.apply(a,u||[]),n()}function n(){for(var e,t=0;t<a.length;t++){for(var n=a[t],i=!0,o=1;o<n.length;o++){var c=n[o];0!==r[c]&&(i=!1)}i&&(a.splice(t--,1),e=s(s.s=n[0]))}return e}var i={},r={app:0},a=[];function s(t){if(i[t])return i[t].exports;var n=i[t]={i:t,l:!1,exports:{}};return e[t].call(n.exports,n,n.exports,s),n.l=!0,n.exports}s.m=e,s.c=i,s.d=function(e,t,n){s.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:n})},s.r=function(e){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},s.t=function(e,t){if(1&t&&(e=s(e)),8&t)return e;if(4&t&&"object"===typeof e&&e&&e.__esModule)return e;var n=Object.create(null);if(s.r(n),Object.defineProperty(n,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var i in e)s.d(n,i,function(t){return e[t]}.bind(null,i));return n},s.n=function(e){var t=e&&e.__esModule?function(){return e["default"]}:function(){return e};return s.d(t,"a",t),t},s.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},s.p="/apollonian-gasket/";var o=window["webpackJsonp"]=window["webpackJsonp"]||[],c=o.push.bind(o);o.push=t,o=o.slice();for(var u=0;u<o.length;u++)t(o[u]);var l=c;a.push([0,"chunk-vendors"]),n()})({0:function(e,t,n){e.exports=n("56d7")},"034f":function(e,t,n){"use strict";var i=n("85ec"),r=n.n(i);r.a},1:function(e,t){},2:function(e,t){},3:function(e,t){},4:function(e,t){},"56d7":function(e,t,n){"use strict";n.r(t);n("e260"),n("e6cf"),n("cca6"),n("a79d");var i,r,a=n("2b0e"),s=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{attrs:{id:"app"}},[n("Adjust",{on:{"depth-change":e.updateDepth}}),n("Prolog",{ref:"prolog",attrs:{triangle:e.triangle,depth:e.depth},on:{"circles-change":e.updateCircles}}),n("Canvas",{attrs:{width:e.width,height:e.height,circles:e.circles,triangle:e.triangle},on:{"triangle-change":function(t){return e.updateTriangle(t)},"update-gasket":e.updateGasket}})],1)},o=[],c=(n("a434"),n("e25e"),function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{staticClass:"container"},[n("h1",[e._v("Apollonian Gasket")]),n("div",{staticClass:"right"},[n("h2",[e._v("Depth: "+e._s(e.depth))]),n("input",{directives:[{name:"model",rawName:"v-model",value:e.depth,expression:"depth"}],staticClass:"slider",attrs:{type:"range",min:"1",max:"10"},domProps:{value:e.depth},on:{input:e.update,__r:function(t){e.depth=t.target.value}}})])])}),u=[],l={name:"Adjust",data:function(){return{depth:2}},methods:{update:function(){this.$emit("depth-change",this.depth)}}},h=l,d=(n("9805"),n("2877")),C=Object(d["a"])(h,c,u,!1,null,"53c82094",null),p=C.exports,f=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("canvas",{attrs:{id:"canvas",width:e.width,height:e.height}})},g=[],m=(n("cb29"),n("c740"),n("4160"),n("a9e3"),n("159b"),{data:function(){return{edit:-1,context:void 0,padding:5}},props:{triangle:Array,circles:Array,height:Number,width:Number},methods:{resetCanvas:function(){this.context.clearRect(0,0,this.width,this.height)},drawTriangle:function(){var e=this;this.triangle.forEach((function(t){e.context.beginPath(),e.context.moveTo(t.x,t.y),e.context.arc(t.x,t.y,5,0,2*Math.PI,!0),e.context.fill()}))},drawCircles:function(){var e=this;this.circles.forEach((function(t){e.context.beginPath(),e.context.arc(t[0],t[1],Math.abs(t[2]),0,2*Math.PI,!1),e.context.stroke()}))}},watch:{triangle:function(){this.resetCanvas(),this.drawTriangle()},circles:function(){this.resetCanvas(),this.drawCircles(),this.drawTriangle()}},mounted:function(){var e=this,t=document.getElementById("canvas");this.context=t.getContext("2d"),this.context.fillStyle="#cddc39",this.context.strokeStyle="#ad1457",this.drawTriangle(this.triangle);var n=function(t,n){return Math.abs(n.x-t.layerX)<e.padding&&Math.abs(n.y-t.layerY)<e.padding};t.onmousedown=function(t){return e.edit=e.triangle.findIndex((function(e){return n(t,e)}))},t.onmouseup=function(){e.edit=-1,e.$emit("update-gasket")},t.onmousemove=function(t){if(-1!=e.edit){var n=e.triangle.splice(0);n[e.edit].x=t.layerX,n[e.edit].y=t.layerY,e.$emit("triangle-change",n)}}},name:"Canvas"}),v=m,B=Object(d["a"])(v,f,g,!1,null,null,null),R=B.exports,b=(n("99af"),n("a15b"),n("d81d"),n("d3b7"),n("7cb4")),w=n.n(b),X='% Triangular Math -> Base Circles from Triangle\nsides(((XA, YA), (XB, YB), (XC, YC)), DA, DB, DC) :-\n  DA is sqrt((XB-XC)^2 + (YB-YC)^2),\n  DB is sqrt((XA-XC)^2 + (YA-YC)^2),\n  DC is sqrt((XA-XB)^2 + (YA-YB)^2).\n\n% calculate tangent circles for points (XA, YA), (XB, YB), (XC, YC), write radii in RA, RB, RC\ntangent((XA, YA), (XB, YB), (XC, YC), [[XA, YA, RA], [XB, YB, RB], [XC, YC, RC]]):-\n    sides(((XA, YA), (XB, YB), (XC, YC)), A, B, C),\n    RA is 1/2*(-A+B+C), RB is 1/2*( A-B+C), RC is 1/2*( A+B-C).\n\n\n% Complex Numbers\nsum([], (0, 0)).\nsum([(CurR, CurI)|Tail], (SumR, SumI)) :-\n   sum(Tail, (RestR, RestI)),\n   SumR is CurR + RestR, SumI is CurI + RestI.\n\nsub((R1, C1), (R2, C2), (R, C)) :- R is R1 - R2, C is C1 - C2.\n\nmul((R1, C1), (R2, C2), (R, C)) :-\n    R is (R1 * R2 - C1 * C2), C is (C1 * R2 + R1 * C2).\n\ndiv((A,B), (C,D), (E,F)) :-\n    C2 is C**2, D2 is D**2,\n    E is (A*C + B*D) / (C2 + D2),\n    F is (B*C - A*D) / (C2 + D2).\n\nsqrt((X, Y), (R, C)) :-\n  SQX2Y2 is sqrt(X**2 + Y**2),\n  R is sqrt((SQX2Y2+X)/2),\n  C is sqrt((SQX2Y2-X)/2).\n\nsolve(C1, C2, C3, S) :-\n  % "When trying to find the radius of a fourth circle tangent to three given kissing circles, the equation is best rewritten as:"\n  % https://en.wikipedia.org/wiki/Descartes%27_theorem\n  % k1 + k2 + k3 + (2 * sqrt(k1 * k2 + k2 * k3 + k1 * k3))\n  mul(C1, C2, P12), mul(C1, C3, P13), mul(C2, C3, P23), %C1*C2 | C1*C3 | C2*C3\n  sum([P12, P13, P23], SP), sqrt(SP, SQ), % P12 + P13 + P23 | sqrt()\n  mul(SQ, (2,0), SQ2), sum([C1, C2, C3, SQ2], S).\n\nadjacent([X1, Y1, R1], [X2, Y2, R2], [X3, Y3, R3], [X4, Y4, R4]) :-\n  % Calculate Bends and solve for 4th Radius using Descartes\n  B1 is 1/R1, B2 is 1/R2, B3 is 1/R3, % calculate bends\n  solve((B1, 0), (B2, 0), (B3, 0), (B4,_)), R4 is 1/B4,\n  % Calculate Relative Centers to Solve Descartes Equation\n  solve((X1*B1, Y1*B1), (X2*B2, Y2*B2), (X3*B3, Y3*B3), BC4),\n  div(BC4, (B4, 0), (X4, Y4)).\n\nflip([X1, Y1, R1], [X2, Y2, R2], [X3, Y3, R3], [X4, Y4, R4], [X5, Y5, R5]) :-\n  % "So if we already have one value for b_4, we can just subtract it from double the sum of the other three bends to find the second value of b_4."\n\t% https://mathlesstraveled.com/2016/05/04/apollonian-gaskets-and-descartes-theorem/\n  B1 is 1/R1, B2 is 1/R2, B3 is 1/R3, B4 is 1/R4, % calculate bends\n  B5 is 2 * (B1 + B2 + B3) - B4, R5 is 1/B5, % calculate 5th bend & corresponding radius\n\n  % "For each operation we compute the same formula twice, once for the bends and once for the bend-center products. To recover the center of a circle, just divide the bend-center product by the bend. And voila!"\n  % https://mathlesstraveled.com/2016/06/10/apollonian-gaskets-and-descartes-theorem-ii/\n  sum([(X1*B1, Y1*B1), (X2*B2, Y2*B2), (X3*B3, Y3*B3)], S), mul(S, (2,0), S2),\n  sub(S2, ((X4*B4, Y4*B4)), S2Sub), div(S2Sub, (B5, 0), (X5, Y5)).\n\ngasket(_, 0, []).\n\ngasket([C1, C2, C3], Depth, [C1, C2, C3, CI, CO|Tail ]) :-\n  adjacent(C1, C2, C3, CI), flip(C1, C2, C3, CI, CO),\n  DepthN is Depth - 1,\n  recurse(C1, C2, C3, CI, InnerRecurse, DepthN), % Further Inner Circles\n  recurse(C1, C2, C3, CO, OuterRecurse, DepthN), % Further Outer Circles\n  append(InnerRecurse, OuterRecurse, Tail).\n\n% Recursion Break Condition\nrecurse( _, _, _, _, [], 0).\n\n% CO: Fixed Circle\nrecurse(C1, C2, C3, CO, [ C5, C6, C7|Tail ], Depth) :-\n  flip(CO, C1, C2, C3, C5),\n  flip(CO, C1, C3, C2, C6),\n  flip(CO, C2, C3, C1, C7), !,\n  DepthN is Depth - 1,\n  recurse(C1, C2, CO, C5, Rec1, DepthN),\n  recurse(C1, C3, CO, C6, Rec2, DepthN),\n  recurse(C2, C3, CO, C7, Rec3, DepthN),\n  append(Rec1, Rec2, PreTail),\n  append(PreTail, Rec3, Tail).\n\n% for time & performance statistics:\nloop_through_list(File, [Head|[]]) :- write(File, Head).\nloop_through_list(File, [Head|Tail]) :-\n    write(File, Head), write(File, \', \'),\n    loop_through_list(File, Tail).\n\nwriteGasket(C1, C2, C3, Depth, Filename) :-\n  gasket(C1, C2, C3, Depth, G),\n  open(Filename, write, File),\n  write(File, \'{ "gasket": [ \'),\n  loop_through_list(File, G),\n  write(File, \' ] }\'),\n  close(File).\n',Y={name:"Prolog",data:function(){return{session:w.a.create(),circles:[]}},props:{triangle:Array,depth:Number},methods:{computeBase:function(e){var t=this;this.circles=[];var n="tangent(".concat(e.map((function(e){return"(".concat(e.x,", ").concat(e.y,")")})).join(", "),", G).");this.session.query(n)&&this.session.answer((function(e){e&&t.$emit("circles-change",e.lookup("G").toJavaScript())}))},computeCircles:function(){var e=this,t=this.triangle.map((function(e,t){return"x".concat(t+1,"=").concat(e.x,"&y").concat(t+1,"=").concat(e.y)})).join("&");t="".concat(t,"&depth=").concat(this.depth),fetch("http://localhost:8008/gasket?".concat(t),{cache:"force-cache"}).then((function(e){return e.json()})).then((function(t){return e.$emit("circles-change",t)})).catch((function(e){return console.log(e)}))}},watch:{depth:function(){this.computeCircles()}},created:function(){this.session.consult(X)},mounted:function(){this.computeCircles()},render:function(){return""}},y=Y,x=Object(d["a"])(y,i,r,!1,null,null,null),A=x.exports,_={name:"app",components:{Adjust:p,Canvas:R,Prolog:A},data:function(){return{triangle:[{name:"A",x:550,y:400},{name:"B",x:820,y:450},{name:"C",x:650,y:650}],circles:[],height:window.innerHeight,width:window.innerWidth,depth:2}},methods:{updateTriangle:function(e){this.triangle=e.splice(0),this.$refs.prolog.computeBase(this.triangle)},updateGasket:function(){this.$refs.prolog.computeCircles()},updateCircles:function(e){this.circles=e.splice(0)},updateDepth:function(e){this.depth=parseInt(e)}}},k=_,S=(n("034f"),Object(d["a"])(k,s,o,!1,null,null,null)),D=S.exports;a["a"].config.productionTip=!1,new a["a"]({render:function(e){return e(D)}}).$mount("#app")},"85ec":function(e,t,n){},9805:function(e,t,n){"use strict";var i=n("e4e7"),r=n.n(i);r.a},e4e7:function(e,t,n){}});
//# sourceMappingURL=app.74255271.js.map