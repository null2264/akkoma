(window.webpackJsonp=window.webpackJsonp||[]).push([[33],{699:function(t,e,a){"use strict";a.r(e);var s=a(0),n=a(6),o=a(1),i=(a(3),a(8)),c=a(9),r=a(32),u=a(13),l=a(4),d=a.n(l),p=a(227),f=a(7),b=a(49);function m(a){return function(e,t){return e({type:"IMPORT_FOLLOWS_REQUEST"}),Object(f.b)(t).post("/api/pleroma/follow_import",a).then(function(t){e(b.a.success("Followers imported successfully")),e({type:"IMPORT_FOLLOWS_SUCCESS",config:t.data})}).catch(function(t){e({type:"IMPORT_FOLLOWS_FAIL",error:t})})}}function O(a){return function(e,t){return e({type:"IMPORT_BLOCKS_REQUEST"}),Object(f.b)(t).post("/api/pleroma/blocks_import",a).then(function(t){e(b.a.success("Blocks imported successfully")),e({type:"IMPORT_BLOCKS_SUCCESS",config:t.data})}).catch(function(t){e({type:"IMPORT_BLOCKS_FAIL",error:t})})}}function _(a){return function(e,t){return e({type:"IMPORT_MUTES_REQUEST"}),Object(f.b)(t).post("/api/pleroma/mutes_import",a).then(function(t){e(b.a.success("Mutes imported successfully")),e({type:"IMPORT_MUTES_SUCCESS",config:t.data})}).catch(function(t){e({type:"IMPORT_MUTES_FAIL",error:t})})}}var g,h,j,S,M,v,y=a(2),w=a(62),I=Object(i.connect)()(g=Object(r.c)((j=h=function(i){function t(){for(var n,t=arguments.length,e=new Array(t),a=0;a<t;a++)e[a]=arguments[a];return n=i.call.apply(i,[this].concat(e))||this,Object(o.a)(Object(y.a)(n),"state",{file:null,isLoading:!1}),Object(o.a)(Object(y.a)(n),"handleSubmit",function(t){var e=n.props,a=e.dispatch,i=e.action,s=new FormData;s.append("list",n.state.file),n.setState({isLoading:!0}),a(i(s)).then(function(){n.setState({isLoading:!1})}).catch(function(t){n.setState({isLoading:!1})}),t.preventDefault()}),Object(o.a)(Object(y.a)(n),"handleFileChange",function(t){var e=(t.target.files||[])[0];n.setState({file:e})}),n}return Object(n.a)(t,i),t.prototype.render=function(){var t=this.props,e=t.intl,a=t.messages;return Object(s.a)(w.i,{onSubmit:this.handleSubmit},void 0,Object(s.a)("fieldset",{disabled:this.state.isLoading},void 0,Object(s.a)(w.b,{},void 0,Object(s.a)("div",{className:"fields-row file-picker"},void 0,Object(s.a)("div",{className:"fields-row__column fields-group fields-row__column-6"},void 0,Object(s.a)(w.j,{type:"file",accept:[".csv","text/csv"],label:e.formatMessage(a.input_label),hint:e.formatMessage(a.input_hint),onChange:this.handleFileChange,required:!0}))))),Object(s.a)("div",{className:"actions"},void 0,Object(s.a)("button",{name:"button",type:"submit",className:"btn button button-primary"},void 0,e.formatMessage(a.submit))))},t}(u.a),Object(o.a)(h,"propTypes",{action:d.a.func.isRequired,messages:d.a.object.isRequired,dispatch:d.a.func.isRequired,intl:d.a.object.isRequired}),g=j))||g)||g,L=a(55);a.d(e,"default",function(){return E});var R=Object(c.c)({heading:{id:"column.import_data",defaultMessage:"Import data"},submit:{id:"import_data.actions.import",defaultMessage:"Import"}}),T=Object(c.c)({input_label:{id:"import_data.follows_label",defaultMessage:"Follows"},input_hint:{id:"import_data.hints.follows",defaultMessage:"CSV file containing a list of followed accounts"},submit:{id:"import_data.actions.import_follows",defaultMessage:"Import follows"}}),C=Object(c.c)({input_label:{id:"import_data.blocks_label",defaultMessage:"Blocks"},input_hint:{id:"import_data.hints.blocks",defaultMessage:"CSV file containing a list of blocked accounts"},submit:{id:"import_data.actions.import_blocks",defaultMessage:"Import blocks"}}),k=Object(c.c)({input_label:{id:"import_data.mutes_label",defaultMessage:"Mutes"},input_hint:{id:"import_data.hints.mutes",defaultMessage:"CSV file containing a list of muted accounts"},submit:{id:"import_data.actions.import_mutes",defaultMessage:"Import mutes"}}),E=Object(i.connect)(function(t){return{features:Object(L.a)(t.get("instance"))}})(S=Object(r.c)((v=M=function(t){function e(){return t.apply(this,arguments)||this}return Object(n.a)(e,t),e.prototype.render=function(){var t=this.props,e=t.intl,a=t.features;return Object(s.a)(p.a,{icon:"cloud-upload",heading:e.formatMessage(R.heading),backBtnSlim:!0},void 0,Object(s.a)(I,{action:m,messages:T}),Object(s.a)(I,{action:O,messages:C}),a.importMutes&&Object(s.a)(I,{action:_,messages:k}))},e}(u.a),Object(o.a)(M,"propTypes",{intl:d.a.object.isRequired,features:d.a.object}),S=v))||S)||S}}]);
//# sourceMappingURL=import_data-062bb91b4e7d8a068e69.chunk.js.map