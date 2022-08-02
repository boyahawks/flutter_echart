const liquidScript = r'''
!function(e,t){"object"==typeof exports&&"object"==typeof module?module.exports=t(require("echarts")):"function"==typeof define&&define.amd?define(["echarts"],t):"object"==typeof exports?exports["echarts-liquidfill"]=t(require("echarts")):e["echarts-liquidfill"]=t(e.echarts)}(self,(function(e){return(()=>{"use strict";var t={245:(e,t,a)=>{a.r(t);var i=a(83);i.extendSeriesModel({type:"series.liquidFill",optionUpdated:function(){var e=this.option;e.gridSize=Math.max(Math.floor(e.gridSize),4)},getInitialData:function(e,t){var a=i.helper.createDimensions(e.data,{coordDimensions:["value"]}),r=new i.List(a,this);return r.initData(e.data),r},defaultOption:{color:["#294D99","#156ACF","#1598ED","#45BDFF"],center:["50%","50%"],radius:"50%",amplitude:"8%",waveLength:"80%",phase:"auto",period:"auto",direction:"right",shape:"circle",waveAnimation:!0,animationEasing:"linear",animationEasingUpdate:"linear",animationDuration:2e3,animationDurationUpdate:1e3,outline:{show:!0,borderDistance:8,itemStyle:{color:"none",borderColor:"#294D99",borderWidth:8,shadowBlur:20,shadowColor:"rgba(0, 0, 0, 0.25)"}},backgroundStyle:{color:"#E3F7FF"},itemStyle:{opacity:.95,shadowBlur:50,shadowColor:"rgba(0, 0, 0, 0.4)"},label:{show:!0,color:"#294D99",insideColor:"#fff",fontSize:50,fontWeight:"bold",align:"center",baseline:"middle",position:"inside"},emphasis:{itemStyle:{opacity:.8}}}});const r=i.graphic.extendShape({type:"ec-liquid-fill",shape:{waveLength:0,radius:0,radiusY:0,cx:0,cy:0,waterLevel:0,amplitude:0,phase:0,inverse:!1},buildPath:function(e,t){null==t.radiusY&&(t.radiusY=t.radius);for(var a=Math.max(2*Math.ceil(2*t.radius/t.waveLength*4),8);t.phase<2*-Math.PI;)t.phase+=2*Math.PI;for(;t.phase>0;)t.phase-=2*Math.PI;var i=t.phase/Math.PI/2*t.waveLength,r=t.cx-t.radius+i-2*t.radius;e.moveTo(r,t.waterLevel);for(var l=0,o=0;o<a;++o){var s=o%4,h=n(o*t.waveLength/4,s,t.waveLength,t.amplitude);e.bezierCurveTo(h[0][0]+r,-h[0][1]+t.waterLevel,h[1][0]+r,-h[1][1]+t.waterLevel,h[2][0]+r,-h[2][1]+t.waterLevel),o===a-1&&(l=h[2][0])}t.inverse?(e.lineTo(l+r,t.cy-t.radiusY),e.lineTo(r,t.cy-t.radiusY),e.lineTo(r,t.waterLevel)):(e.lineTo(l+r,t.cy+t.radiusY),e.lineTo(r,t.cy+t.radiusY),e.lineTo(r,t.waterLevel)),e.closePath()}});function n(e,t,a,i){return 0===t?[[e+.5*a/Math.PI/2,i/2],[e+.5*a/Math.PI,i],[e+a/4,i]]:1===t?[[e+.5*a/Math.PI/2*(Math.PI-2),i],[e+.5*a/Math.PI/2*(Math.PI-1),i/2],[e+a/4,0]]:2===t?[[e+.5*a/Math.PI/2,-i/2],[e+.5*a/Math.PI,-i],[e+a/4,-i]]:[[e+.5*a/Math.PI/2*(Math.PI-2),-i],[e+.5*a/Math.PI/2*(Math.PI-1),-i/2],[e+a/4,0]]}const l=function(e,t){switch(e){case"center":case"middle":e="50%";break;case"left":case"top":e="0%";break;case"right":case"bottom":e="100%"}return"string"==typeof e?(a=e,a.replace(/^\s+|\s+$/g,"")).match(/%$/)?parseFloat(e)/100*t:parseFloat(e):null==e?NaN:+e;var a};i.extendChartView({type:"liquidFill",render:function(e,t,a){var n=this.group;n.removeAll();var o=e.getData(),s=o.getItemModel(0),h=s.get("center"),d=s.get("radius"),p=a.getWidth(),u=a.getHeight(),c=Math.min(p,u),g=0,v=0,f=e.get("outline.show");f&&(g=e.get("outline.borderDistance"),v=l(e.get("outline.itemStyle.borderWidth"),c));var m,y,w,M=l(h[0],p),b=l(h[1],u),P=!1,x=e.get("shape");"container"===x?(P=!0,y=[(m=[p/2,u/2])[0]-v/2,m[1]-v/2],w=[l(g,p),l(g,u)],d=[Math.max(y[0]-w[0],0),Math.max(y[1]-w[1],0)]):(y=(m=l(d,c)/2)-v/2,w=l(g,c),d=Math.max(y-w,0)),f&&(F().style.lineWidth=v,n.add(F()));var I=P?0:M-d,S=P?0:b-d,L=null;n.add(function(){var t=D(d);t.setStyle(e.getModel("backgroundStyle").getItemStyle()),t.style.fill=null,t.z2=5;var a=D(d);a.setStyle(e.getModel("backgroundStyle").getItemStyle()),a.style.stroke=null;var r=new i.graphic.Group;return r.add(t),r.add(a),r}());var C=this._data,T=[];function D(e,t){if(x){if(0===x.indexOf("path://")){var a=i.graphic.makePath(x.slice(7),{}),r=a.getBoundingRect(),n=r.width,l=r.height;n>l?(l*=2*e/n,n=2*e):(n*=2*e/l,l=2*e);var o=t?0:M-n/2,s=t?0:b-l/2;return a=i.graphic.makePath(x.slice(7),{},new i.graphic.BoundingRect(o,s,n,l)),t&&(a.position=[-n/2,-l/2]),a}if(P){var h=t?-e[0]:M-e[0],d=t?-e[1]:b-e[1];return i.helper.createSymbol("rect",h,d,2*e[0],2*e[1])}return h=t?-e:M-e,d=t?-e:b-e,"pin"===x?d+=e:"arrow"===x&&(d-=e),i.helper.createSymbol(x,h,d,2*e,2*e)}return new i.graphic.Circle({shape:{cx:t?0:M,cy:t?0:b,r:e}})}function F(){var t=D(m);return t.style.fill=null,t.setStyle(e.getModel("outline.itemStyle").getItemStyle()),t}function Y(t,a,n){var s=P?d[0]:d,h=P?u/2:d,p=o.getItemModel(t),c=p.getModel("itemStyle"),g=p.get("phase"),v=l(p.get("amplitude"),2*h),f=l(p.get("waveLength"),2*s),m=h-o.get("value",t)*h*2;g=n?n.shape.phase:"auto"===g?t*Math.PI/4:g;var y=c.getItemStyle();if(!y.fill){var w=e.get("color"),x=t%w.length;y.fill=w[x]}var I=new r({shape:{waveLength:f,radius:s,radiusY:h,cx:2*s,cy:0,waterLevel:m,amplitude:v,phase:g,inverse:a},style:y,position:[M,b]});I.shape._waterLevel=m;var S=p.getModel("emphasis.itemStyle").getItemStyle();S.lineWidth=0,I.ensureState("emphasis").style=S,i.helper.enableHoverEmphasis(I);var L=D(d,!0);return L.setStyle({fill:"white"}),I.setClipPath(L),I}function E(e,t,a){var i=o.getItemModel(e),r=i.get("period"),n=i.get("direction"),l=o.get("value",e),s=i.get("phase");s=a?a.shape.phase:"auto"===s?e*Math.PI/4:s;var h,d;h="auto"===r?0===(d=o.count())?5e3:5e3*(.2+(d-e)/d*.8):"function"==typeof r?r(l,e):r;var p=0;"right"===n||null==n?p=Math.PI:"left"===n?p=-Math.PI:"none"===n?p=0:console.error("Illegal direction value for liquid fill."),"none"!==n&&i.get("waveAnimation")&&t.animate("shape",!0).when(0,{phase:s}).when(h/2,{phase:p+s}).when(h,{phase:2*p+s}).during((function(){L&&L.dirty(!0)})).start()}o.diff(C).add((function(t){var a=Y(t,!1),r=a.shape.waterLevel;a.shape.waterLevel=P?u/2:d,i.graphic.initProps(a,{shape:{waterLevel:r}},e),a.z2=2,E(t,a,null),n.add(a),o.setItemGraphicEl(t,a),T.push(a)})).update((function(t,a){for(var r=C.getItemGraphicEl(a),l=Y(t,!1,r),s={},h=["amplitude","cx","cy","phase","radius","radiusY","waterLevel","waveLength"],d=0;d<h.length;++d){var p=h[d];l.shape.hasOwnProperty(p)&&(s[p]=l.shape[p])}var c={},g=["fill","opacity","shadowBlur","shadowColor"];for(d=0;d<g.length;++d)p=g[d],l.style.hasOwnProperty(p)&&(c[p]=l.style[p]);P&&(s.radiusY=u/2),i.graphic.updateProps(r,{shape:s},e),r.useStyle(c),r.position=l.position,r.setClipPath(l.getClipPath()),r.shape.inverse=l.inverse,E(t,r,r),n.add(r),o.setItemGraphicEl(t,r),T.push(r)})).remove((function(e){var t=C.getItemGraphicEl(e);n.remove(t)})).execute(),s.get("label.show")&&n.add(function(t){var a=s.getModel("label");var r,n,l,h={z2:10,shape:{x:I,y:S,width:2*(P?d[0]:d),height:2*(P?d[1]:d)},style:{fill:"transparent"},textConfig:{position:a.get("position")||"inside"},silent:!0},p={style:{text:(r=e.getFormattedLabel(0,"normal"),n=100*o.get("value",0),l=o.getName(0)||e.name,isNaN(n)||(l=n.toFixed(0)+"%"),null==r?l:r),textAlign:a.get("align"),textVerticalAlign:a.get("baseline")}};Object.assign(p.style,i.helper.createTextStyle(a));var u=new i.graphic.Rect(h),c=new i.graphic.Rect(h);c.disableLabelAnimation=!0,u.disableLabelAnimation=!0;var g=new i.graphic.Text(p),v=new i.graphic.Text(p);u.setTextContent(g),c.setTextContent(v);var f=a.get("insideColor");v.style.fill=f;var m=new i.graphic.Group;m.add(u),m.add(c);var y=D(d,!0);return(L=new i.graphic.CompoundPath({shape:{paths:t},position:[M,b]})).setClipPath(y),c.setClipPath(L),m}(T)),this._data=o},dispose:function(){}})},83:t=>{t.exports=e}},a={};function i(e){if(a[e])return a[e].exports;var r=a[e]={exports:{}};return t[e](r,r.exports,i),r.exports}return i.r=e=>{"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},i(245)})()}));
''';