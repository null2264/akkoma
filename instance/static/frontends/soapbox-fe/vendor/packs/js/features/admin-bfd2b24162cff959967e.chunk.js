(window.webpackJsonp=window.webpackJsonp||[]).push([[7],{705:function(e,a,t){"use strict";t.r(a);var s,n,i,o,d=t(0),c=t(6),r=t(1),l=(t(3),t(9)),u=t(32),b=t(29),p=t(8),v=t(13),h=t(4),g=t.n(h),j=t(15),O=t.n(j),m=t(227),_=t(2),f=t(62),M=t(31),N=t(49),w=Object(l.c)({saved:{id:"admin.dashboard.settings_saved",defaultMessage:"Settings saved!"}}),y=function(e){return e.get("approval_required")&&e.get("registrations")?"approval":e.get("registrations")?"open":"closed"},k=Object(p.connect)(function(e){return{mode:y(e.get("instance"))}})(s=Object(u.c)(s=function(s){function e(){for(var i,e=arguments.length,a=new Array(e),t=0;t<e;t++)a[t]=arguments[t];return i=s.call.apply(s,[this].concat(a))||this,Object(r.a)(Object(_.a)(i),"onChange",function(e){var a=i.props,t=a.dispatch,s=a.intl,n=[{group:":pleroma",key:":instance",value:{open:[{tuple:[":registrations_open",!0]},{tuple:[":account_approval_required",!1]}],approval:[{tuple:[":registrations_open",!0]},{tuple:[":account_approval_required",!0]}],closed:[{tuple:[":registrations_open",!1]}]}[e.target.value]}];t(Object(M.C)(n)).then(function(){t(N.a.success(s.formatMessage(w.saved)))}).catch(function(){})}),i}return Object(c.a)(e,s),e.prototype.render=function(){var e=this.props.mode;return Object(d.a)(f.i,{},void 0,Object(d.a)(f.b,{},void 0,Object(d.a)(f.f,{label:Object(d.a)(b.a,{id:"admin.dashboard.registration_mode_label",defaultMessage:"Registrations"}),onChange:this.onChange},void 0,Object(d.a)(f.g,{label:Object(d.a)(b.a,{id:"admin.dashboard.registration_mode.open_label",defaultMessage:"Open"}),hint:Object(d.a)(b.a,{id:"admin.dashboard.registration_mode.open_hint",defaultMessage:"Anyone can join."}),checked:"open"===e,value:"open"}),Object(d.a)(f.g,{label:Object(d.a)(b.a,{id:"admin.dashboard.registration_mode.approval_label",defaultMessage:"Approval Required"}),hint:Object(d.a)(b.a,{id:"admin.dashboard.registration_mode.approval_hint",defaultMessage:"Users can sign up, but their account only gets activated when an admin approves it."}),checked:"approval"===e,value:"approval"}),Object(d.a)(f.g,{label:Object(d.a)(b.a,{id:"admin.dashboard.registration_mode.closed_label",defaultMessage:"Closed"}),hint:Object(d.a)(b.a,{id:"admin.dashboard.registration_mode.closed_hint",defaultMessage:"Nobody can sign up. You can still invite people."}),checked:"closed"===e,value:"closed"}))))},e}(v.a))||s)||s,q=t(55),C=t(150),R=t.n(C);t.d(a,"default",function(){return x});var S=Object(l.c)({heading:{id:"column.admin.dashboard",defaultMessage:"Dashboard"}}),x=Object(p.connect)(function(e){return{instance:e.get("instance")}})(n=Object(u.c)((o=i=function(e){function a(){return e.apply(this,arguments)||this}return Object(c.a)(a,e),a.prototype.render=function(){var e=this.props,a=e.intl,t=e.instance,s=Object(q.b)(t.get("version"));return Object(d.a)(m.a,{icon:"tachometer",heading:a.formatMessage(S.heading),backBtnSlim:!0},void 0,Object(d.a)("div",{className:"dashcounters"},void 0,Object(d.a)("div",{className:"dashcounter"},void 0,Object(d.a)("a",{href:"/pleroma/admin/#/users/index",target:"_blank"},void 0,Object(d.a)("div",{className:"dashcounter__num"},void 0,Object(d.a)(l.b,{value:t.getIn(["stats","user_count"])})),Object(d.a)("div",{className:"dashcounter__label"},void 0,Object(d.a)(b.a,{id:"admin.dashcounters.user_count_label",defaultMessage:"users"})))),Object(d.a)("div",{className:"dashcounter"},void 0,Object(d.a)("a",{href:"/pleroma/admin/#/statuses/index",target:"_blank"},void 0,Object(d.a)("div",{className:"dashcounter__num"},void 0,Object(d.a)(l.b,{value:t.getIn(["stats","status_count"])})),Object(d.a)("div",{className:"dashcounter__label"},void 0,Object(d.a)(b.a,{id:"admin.dashcounters.status_count_label",defaultMessage:"posts"})))),Object(d.a)("div",{className:"dashcounter"},void 0,Object(d.a)("div",{},void 0,Object(d.a)("div",{className:"dashcounter__num"},void 0,Object(d.a)(l.b,{value:t.getIn(["stats","domain_count"])})),Object(d.a)("div",{className:"dashcounter__label"},void 0,Object(d.a)(b.a,{id:"admin.dashcounters.domain_count_label",defaultMessage:"peers"}))))),Object(d.a)(k,{}),Object(d.a)("div",{className:"dashwidgets"},void 0,Object(d.a)("div",{className:"dashwidget"},void 0,Object(d.a)("h4",{},void 0,Object(d.a)(b.a,{id:"admin.dashwidgets.software_header",defaultMessage:"Software"})),Object(d.a)("ul",{},void 0,Object(d.a)("li",{},void 0,"Soapbox FE ",Object(d.a)("span",{className:"pull-right"},void 0,R.a.version)),Object(d.a)("li",{},void 0,s.software," ",Object(d.a)("span",{className:"pull-right"},void 0,s.version))))))},a}(v.a),Object(r.a)(i,"propTypes",{intl:g.a.object.isRequired,instance:O.a.map.isRequired}),n=o))||n)||n}}]);
//# sourceMappingURL=admin-bfd2b24162cff959967e.chunk.js.map