var Drupal=Drupal||{};!function($,t){"use strict";t.behaviors.bootstrap={attach:function(t){$(t).find(".tabbable").once("bootstrap-tabs",function(){var t=$(this),o=t.find(".nav-tabs"),a=t.find(".tab-content"),s=parseInt(a.css("borderBottomRightRadius"),10),r=function(){(t.hasClass("tabs-left")||t.hasClass("tabs-right"))&&a.css("min-height",o.outerHeight())};r(),(t.hasClass("tabs-left")||t.hasClass("tabs-right"))&&o.on("shown.bs.tab",'a[data-toggle="tab"]',function(o){r(),t.hasClass("tabs-left")?$(o.target).parent().is(":first-child")?a.css("borderTopLeftRadius","0"):a.css("borderTopLeftRadius",s+"px"):$(o.target).parent().is(":first-child")?a.css("borderTopRightRadius","0"):a.css("borderTopRightRadius",s+"px")})})}},t.behaviors.bootstrapPopovers={attach:function(t,o){if(o.bootstrap&&o.bootstrap.popoverEnabled)for(var a=$(t).find('[data-toggle="popover"]').toArray(),s=0;s<a.length;s++){var r=$(a[s]),n=$.extend(!0,{},o.bootstrap.popoverOptions,r.data());r.popover(n)}}},t.behaviors.bootstrapTooltips={attach:function(t,o){if(o.bootstrap&&o.bootstrap.tooltipEnabled)for(var a=$(t).find('[data-toggle="tooltip"]').toArray(),s=0;s<a.length;s++){var r=$(a[s]),n=$.extend(!0,{},o.bootstrap.tooltipOptions,r.data());r.tooltip(n)}}};var o=$();t.behaviors.bootstrapAnchors={attach:function(t,a){var s,r=["html","body"];if(!o.length)for(s=0;s<r.length;s++){var n=$(r[s]);if(n.scrollTop()>0){o=n;break}if(n.scrollTop(1),n.scrollTop()>0){n.scrollTop(0),o=n;break}}if(a.bootstrap&&a.bootstrap.anchorsFix){var e=$(t).find("a").toArray();for(s=0;s<e.length;s++)e[s].scrollTo||this.bootstrapAnchor(e[s]);o.once("bootstrap-anchors",function(){o.on("click.bootstrap-anchors",'a[href*="#"]:not([data-toggle],[data-target])',function(t){this.scrollTo(t)})})}},bootstrapAnchor:function(a){a.validAnchor="A"===a.nodeName&&(location.hostname===a.hostname||!a.hostname)&&a.hash.replace(/#/,"").length,a.scrollTo=function(s){var r="id",n=$(a.hash);n.length||(r="name",n=$('[name="'+a.hash.replace("#","")+'"'));var e=n.offset().top-parseInt(o.css("paddingTop"),10)-parseInt(o.css("marginTop"),10);if(this.validAnchor&&n.length&&e>0){s&&s.preventDefault();var i=$("<div/>").addClass("element-invisible").attr(r,n.attr(r)).css({position:"absolute",top:e+"px",zIndex:-1e3}).appendTo(document);n.removeAttr(r);var l=function(){location.hash=a.hash,i.remove(),n.attr(r,a.hash.replace("#",""))};t.settings.bootstrap.anchorsSmoothScrolling?o.animate({scrollTop:e,avoidTransforms:!0},400,l):(o.scrollTop(e),l())}}}}}(jQuery,Drupal);