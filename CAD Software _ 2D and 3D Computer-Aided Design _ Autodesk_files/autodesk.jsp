Array.prototype.filter||(Array.prototype.filter=function(t,e){"use strict";if("Function"!=typeof t&&"function"!=typeof t||!this)throw new TypeError;var r=this.length>>>0,o=new Array(r),n=this,l=0,i=-1;if(void 0===e)for(;++i!==r;)i in this&&t(n[i],i,n)&&(o[l++]=n[i]);else for(;++i!==r;)i in this&&t.call(e,n[i],i,n)&&(o[l++]=n[i]);return o.length=l,o}),Array.prototype.forEach||(Array.prototype.forEach=function(t){var e,r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if("function"!=typeof t)throw new TypeError(t+" is not a function");for(arguments.length>1&&(e=arguments[1]),r=0;r<n;){var l;r in o&&(l=o[r],t.call(e,l,r,o)),r++}}),window.NodeList&&!NodeList.prototype.forEach&&(NodeList.prototype.forEach=Array.prototype.forEach),Array.prototype.indexOf||(Array.prototype.indexOf=function(t,e){var r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if(0===n)return-1;var l=0|e;if(l>=n)return-1;for(r=Math.max(l>=0?l:n-Math.abs(l),0);r<n;){if(r in o&&o[r]===t)return r;r++}return-1}),document.getElementsByClassName||(document.getElementsByClassName=function(t){var e,r,o,n=document,l=[];if(n.querySelectorAll)return n.querySelectorAll("."+t);if(n.evaluate)for(r=".//*[contains(concat(' ', @class, ' '), ' "+t+" ')]",e=n.evaluate(r,n,null,0,null);o=e.iterateNext();)l.push(o);else for(e=n.getElementsByTagName("*"),r=new RegExp("(^|\\s)"+t+"(\\s|$)"),o=0;o<e.length;o++)r.test(e[o].className)&&l.push(e[o]);return l}),document.querySelectorAll||(document.querySelectorAll=function(t){var e,r=document.createElement("style"),o=[];for(document.documentElement.firstChild.appendChild(r),document._qsa=[],r.styleSheet.cssText=t+"{x-qsa:expression(document._qsa && document._qsa.push(this))}",window.scrollBy(0,0),r.parentNode.removeChild(r);document._qsa.length;)(e=document._qsa.shift()).style.removeAttribute("x-qsa"),o.push(e);return document._qsa=null,o}),document.querySelector||(document.querySelector=function(t){var e=document.querySelectorAll(t);return e.length?e[0]:null}),Object.keys||(Object.keys=function(){"use strict";var t=Object.prototype.hasOwnProperty,e=!{toString:null}.propertyIsEnumerable("toString"),r=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],o=r.length;return function(n){if("function"!=typeof n&&("object"!=typeof n||null===n))throw new TypeError("Object.keys called on non-object");var l,i,s=[];for(l in n)t.call(n,l)&&s.push(l);if(e)for(i=0;i<o;i++)t.call(n,r[i])&&s.push(r[i]);return s}}()),"function"!=typeof String.prototype.trim&&(String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")}),String.prototype.replaceAll||(String.prototype.replaceAll=function(t,e){return"[object regexp]"===Object.prototype.toString.call(t).toLowerCase()?this.replace(t,e):this.replace(new RegExp(t,"g"),e)}),window.hasOwnProperty=window.hasOwnProperty||Object.prototype.hasOwnProperty;
if (typeof usi_commons === 'undefined') {
	usi_commons = {
		
		debug: location.href.indexOf("usidebug") != -1 || location.href.indexOf("usi_debug") != -1,
		
		log:function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log(msg.name + ': ' + msg.message);
					} else {
						console.log.apply(console, arguments);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_error: function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg.name + ': ' + msg.message);
					} else {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_success: function(msg) {
			if (usi_commons.debug) {
				try {
					console.log('%c USI Success:', usi_commons.log_styles.success, msg);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		dir:function(obj) {
			if (usi_commons.debug) {
				try {
					console.dir(obj);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_styles: {
			error: 'color: red; font-weight: bold;',
			success: 'color: green; font-weight: bold;'
		},
		domain: "https://app.upsellit.com",
		cdn: "https://www.upsellit.com",
		is_mobile: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()),
		device: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()) ? 'mobile' : 'desktop',
		gup:function(name) {
			try {
				name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
				var regexS = "[\\?&]" + name + "=([^&#\\?]*)";
				var regex = new RegExp(regexS);
				var results = regex.exec(window.location.href);
				if (results == null) return "";
				else return results[1];
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_script:function(source, callback, nocache) {
			try {
				if (source.indexOf("//www.upsellit.com") == 0) source = "https:"+source;
				var docHead = document.getElementsByTagName("head")[0];
				//if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
				var newScript = document.createElement('script');
				newScript.type = 'text/javascript';
				var usi_appender = "";
				if (!nocache && source.indexOf("/active/") == -1 && source.indexOf("_pixel.jsp") == -1 && source.indexOf("_throttle.jsp") == -1 && source.indexOf("metro") == -1 && source.indexOf("_suppress") == -1 && source.indexOf("product_recommendations.jsp") == -1 && source.indexOf("_pid.jsp") == -1 && source.indexOf("_zips") == -1) {
					usi_appender = (source.indexOf("?")==-1?"?":"&");
					if (source.indexOf("pv2.js") != -1) usi_appender = "%7C";
					usi_appender += "si=" + usi_commons.get_sess();
				}
				newScript.src = source + usi_appender;
				if (typeof callback == "function") {
					newScript.onload = function() {
						try {
							callback();
						} catch (e) {
							usi_commons.report_error(e);
						}
					};
				}
				docHead.appendChild(newScript);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_display:function(usiQS, usiSiteID, usiKey, callback) {
			try {
				usiKey = usiKey || "";
				var source = usi_commons.domain + "/launch.jsp?qs=" + usiQS + "&siteID=" + usiSiteID + "&keys=" + usiKey;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_view:function(usiHash, usiSiteID, usiKey, callback) {
			try {
				if (typeof(usi_force) != "undefined" || location.href.indexOf("usi_force") != -1 || (usi_cookies.get("usi_sale") == null && usi_cookies.get("usi_launched") == null && usi_cookies.get("usi_launched"+usiSiteID) == null)) {
					usiKey = usiKey || "";
					var usi_append = "";
					if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
					else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
					if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
					var source = usi_commons.domain + "/view.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
					if (typeof(usi_commons.last_view) !== "undefined" && usi_commons.last_view == usiSiteID+"_"+usiKey) return;
					usi_commons.last_view = usiSiteID+"_"+usiKey;
					if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') usi_js.cleanup();
					usi_commons.load_script(source, callback);
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		remove_loads:function() {
			try {
				if (document.getElementById("usi_obj") != null) {
					document.getElementById("usi_obj").parentNode.parentNode.removeChild(document.getElementById("usi_obj").parentNode);
				}
				if (typeof(usi_commons.usi_loads) !== "undefined") {
					for (var i in usi_commons.usi_loads) {
						if (document.getElementById("usi_"+i) != null) {
							document.getElementById("usi_"+i).parentNode.parentNode.removeChild(document.getElementById("usi_"+i).parentNode);
						}
					}
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load:function(usiHash, usiSiteID, usiKey, callback){
			try {
				if (typeof(window["usi_" + usiSiteID]) !== "undefined") return;
				usiKey = usiKey || "";
				var usi_append = "";
				if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
				else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
				if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
				var source = usi_commons.domain + "/usi_load.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
				usi_commons.load_script(source, callback);
				if (typeof(usi_commons.usi_loads) === "undefined") {
					usi_commons.usi_loads = {};
				}
				usi_commons.usi_loads[usiSiteID] = usiSiteID;
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_precapture:function(usiQS, usiSiteID, callback) {
			try {
				if (typeof(usi_commons.last_precapture_siteID) !== "undefined" && usi_commons.last_precapture_siteID == usiSiteID) return;
				usi_commons.last_precapture_siteID = usiSiteID;
				var source = usi_commons.domain + "/hound/monitor.jsp?qs=" + usiQS + "&siteID=" + usiSiteID;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_mail:function(qs, siteID, callback) {
			try {
				var source = usi_commons.domain + "/mail.jsp?qs=" + qs + "&siteID=" + siteID + "&domain=" + encodeURIComponent(usi_commons.domain);
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_products:function(options) {
			try {
				if (!options.siteID || !options.pid) return;
				var queryStr = "";
				var params = ['siteID', 'association_siteID', 'pid', 'less_expensive', 'rows', 'days_back', 'force_exact', 'match', 'nomatch', 'name_from', 'image_from', 'price_from', 'url_from', 'extra_from', 'custom_callback', 'allow_dupe_names', 'expire_seconds', 'name'];
				params.forEach(function(name, index){
					if (options[name]) {
						queryStr += (index == 0 ? "?" : "&") + name + '=' + options[name];
					}
				});
				if (options.filters) {
					queryStr += "&filters=" + encodeURIComponent(options.filters.join("&"));
				}
				usi_commons.load_script(usi_commons.cdn + '/utility/product_recommendations_filter.jsp' + queryStr, function(){
					if (typeof options.callback === 'function') {
						options.callback();
					}
				});
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		send_prod_rec:function(siteID, info, real_time) {
			var result = false;
			try {
				if (document.getElementsByTagName("html").length > 0 && document.getElementsByTagName("html")[0].className != null && document.getElementsByTagName("html")[0].className.indexOf("translated") != -1) {
					//Ignore translated pages
					return false;
				}
				var data = [siteID, info.name, info.link, info.pid, info.price, info.image];
				if (data.indexOf(undefined) == -1) {
					var queryString = [siteID, info.name.replace(/\|/g, "&#124;"), info.link, info.pid, info.price, info.image].join("|") + "|";
					if (info.extra) queryString += info.extra + "|";
					var filetype = real_time ? "jsp" : "js";
					usi_commons.load_script(usi_commons.domain + "/utility/pv2." + filetype + "?" + encodeURIComponent(queryString));
					result = true;
				}
			} catch (e) {
				usi_commons.report_error(e);
				result = false;
			}
			return result;
		},
		report_error:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
			usi_commons.log_error(err.message);
			usi_commons.dir(err);
		},
		report_error_no_console:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
		},
		gup_or_get_cookie: function(name, expireSeconds, forceCookie) {
			try {
				if (typeof usi_cookies === 'undefined') {
					usi_commons.log_error('usi_cookies is not defined');
					return;
				}
				expireSeconds = (expireSeconds || usi_cookies.expire_time.day);
				if (name == "usi_enable") expireSeconds = usi_cookies.expire_time.hour;
				var value = null;
				var qsValue = usi_commons.gup(name);
				if (qsValue !== '') {
					value = qsValue;
					usi_cookies.set(name, value, expireSeconds, forceCookie);
				} else {
					value = usi_cookies.get(name);
				}
				return (value || '');
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		get_sess: function() {
			var usi_si = null;
			if (typeof(usi_cookies) === "undefined") return "";
			try {
				if (usi_cookies.get('usi_si') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_si = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_si', usi_si, 24*60*60);
					return usi_si;
				}
				if (usi_cookies.get('usi_si') != null) usi_si = usi_cookies.get('usi_si');
				usi_cookies.set('usi_si', usi_si, 24*60*60);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_si;
		},
		get_id: function(usi_append) {
			if (!usi_append) usi_append = "";
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_v') == null && usi_cookies.get('usi_id'+usi_append) == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_v') != null) usi_id = usi_cookies.get('usi_v');
				if (usi_cookies.get('usi_id'+usi_append) != null) usi_id = usi_cookies.get('usi_id'+usi_append);
				usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		load_session_data: function(extended) {
			try {
				if (usi_cookies.get_json("usi_session_data") == null) {
					usi_commons.load_script(usi_commons.domain + '/utility/session_data.jsp?extended=' + (extended?"true":"false"));
				} else {
					usi_app.session_data = usi_cookies.get_json("usi_session_data");
					if (typeof(usi_app.session_data_callback) !== "undefined") {
						usi_app.session_data_callback();
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		},
		customer_ip:function(last_purchase) {
			try {
				if (last_purchase != -1) {
					usi_cookies.set("usi_suppress", "1", usi_cookies.expire_time.never);
				} else {
					usi_app.main();
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		},
		customer_check:function(company_id) {
			try {
				if (!usi_app.is_enabled && !usi_cookies.value_exists("usi_ip_checked")) {
					usi_cookies.set("usi_ip_checked", "1", usi_cookies.expire_time.day);
					usi_commons.load_script(usi_commons.domain + "/utility/customer_ip2.jsp?companyID=" + company_id);
					return false;
				}
				return true;
			} catch(err) {
				usi_commons.report_error(err);
			}
		}
	};
	setTimeout(function() {
		try {
			if (usi_commons.gup_or_get_cookie("usi_debug") != "") usi_commons.debug = true;
			if (usi_commons.gup_or_get_cookie("usi_qa") != "") {
				usi_commons.domain = usi_commons.cdn = "https://prod.upsellit.com";
			}
		} catch(err) {
			usi_commons.report_error(err);
		}
	}, 1000);
}
"undefined"==typeof usi_date&&(usi_date={},usi_date.PSTOffsetMinutes=480,usi_date.localOffsetMinutes=(new Date).getTimezoneOffset(),usi_date.offsetDeltaMinutes=usi_date.localOffsetMinutes-usi_date.PSTOffsetMinutes,usi_date.toPST=function(e){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*usi_date.offsetDeltaMinutes*1e3)},usi_date.add_hours=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*t*60*1e3)},usi_date.add_minutes=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*t*1e3)},usi_date.add_seconds=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+1e3*t)},usi_date.get_week_number=function(e){var t={year:-1,weekNumber:-1};try{if(usi_date.is_date(e)){var a=new Date(Date.UTC(e.getFullYear(),e.getMonth(),e.getDate()));a.setUTCDate(a.getUTCDate()+4-(a.getUTCDay()||7));var s=new Date(Date.UTC(a.getUTCFullYear(),0,1)),i=Math.ceil(((a-s)/864e5+1)/7);t.year=a.getUTCFullYear(),t.weekNumber=i}}catch(e){}finally{return t}},usi_date.is_date=function(e){return null!=e&&"object"==typeof e&&e instanceof Date==!0&&!1===isNaN(e.getTime())},usi_date.is_date_within_range=function(e,t,a){if(void 0===e&&(e=usi_date.set_date()),!1===usi_date.is_date(e))return!1;var s=usi_date.string_to_date(t,!1),i=usi_date.string_to_date(a,!1),r=usi_date.toPST(e);return r>=s&&r<i},usi_date.is_after=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),a=new Date(e);return t.getTime()>a.getTime()}catch(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}return!1},usi_date.is_before=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),a=new Date(e);return t.getTime()<a.getTime()}catch(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}return!1},usi_date.is_between=function(e,t){return usi_date.check_format(e,t),usi_date.is_after(e)&&usi_date.is_before(t)},usi_date.check_format=function(e,t){(-1!=e.indexOf(" ")||t&&-1!=t.indexOf(" "))&&"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error("Incorrect format: Use YYYY-MM-DDThh:mm:ss")},usi_date.is_date_after=function(e,t){if(!1===usi_date.is_date(e))return!1;var a=usi_date.string_to_date(t,!1);return usi_date.toPST(e)>a},usi_date.is_date_before=function(e,t){if(!1===usi_date.is_date(e))return!1;var a=usi_date.string_to_date(t,!1);return usi_date.toPST(e)<a},usi_date.string_to_date=function(e,t){t=t||!1;var a=null,s=/^[0-2]?[0-9]\/[0-3]?[0-9]\/\d{4}(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e),i=/^(\d{4}\-[0-2]?[0-9]\-[0-3]?[0-9])(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e);if(2===(s||[]).length){if(a=new Date(e),""===(s[1]||"")&&!0===t){var r=new Date;a=usi_date.add_hours(a,r.getHours()),a=usi_date.add_minutes(a,r.getMinutes()),a=usi_date.add_seconds(a,r.getSeconds())}}else if(3===(i||[]).length){var o=i[1].split(/\-/g),u=o[1]+"/"+o[2]+"/"+o[0];return u+=i[2]||"",usi_date.string_to_date(u,t)}return a},usi_date.set_date=function(){var e=new Date,t=usi_commons.gup("usi_force_date");if(""!==t){t=decodeURIComponent(t);var a=usi_date.string_to_date(t,!0);null!=a?(e=a,usi_cookies.set("usi_force_date",t,usi_cookies.expire_time.hour),usi_commons.log("Date forced to: "+e)):usi_cookies.del("usi_force_date")}else e=null!=usi_cookies.get("usi_force_date")?usi_date.string_to_date(usi_cookies.get("usi_force_date"),!0):new Date;return e},usi_date.diff=function(e,t,a,s){null==s&&(s=1),""!=(a||"")&&(a=usi_date.get_units(a));var i=null;if(!0===usi_date.is_date(t)&&!0===usi_date.is_date(e))try{var r=Math.abs(t-e);switch(a){case"ms":i=r;break;case"seconds":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3),s);break;case"minutes":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60),s);break;case"hours":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60)/parseFloat(60),s);break;case"days":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60)/parseFloat(60)/parseFloat(24),s)}}catch(e){i=null}return i},usi_date.convert_units=function(e,t,a,s){var i=null,r=null;switch(usi_date.get_units(t)){case"days":i=1e6*e*1e3*60*60*24;break;case"hours":i=1e6*e*1e3*60*60;break;case"minutes":i=1e6*e*1e3*60;break;case"seconds":i=1e6*e*1e3;break;case"ms":i=1e6*e}switch(usi_date.get_units(a)){case"days":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60)/parseFloat(60)/parseFloat(24),s);break;case"hours":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60)/parseFloat(60),s);break;case"minutes":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60),s);break;case"seconds":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3),s);break;case"ms":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6),s)}return r},usi_date.get_units=function(e){var t="";switch(e.toLowerCase()){case"days":case"day":case"d":t="days";break;case"hours":case"hour":case"hrs":case"hr":case"h":t="hours";break;case"minutes":case"minute":case"mins":case"min":case"m":t="minutes";break;case"seconds":case"second":case"secs":case"sec":case"s":t="seconds";break;case"ms":case"milliseconds":case"millisecond":case"millis":case"milli":t="ms"}return t});if("undefined"==typeof usi_cookies){if(usi_cookies={expire_time:{minute:60,hour:3600,two_hours:7200,four_hours:14400,day:86400,week:604800,two_weeks:1209600,month:2592e3,year:31536e3,never:31536e4},max_cookies_count:15,max_cookie_length:1e3,update_window_name:function(e,i,n){try{var t=-1;if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t=r.getTime()}var o=window.top||window,l=0;null!=i&&-1!=i.indexOf("=")&&(i=i.replace(RegExp("=","g"),"USIEQLS")),null!=i&&-1!=i.indexOf(";")&&(i=i.replace(RegExp(";","g"),"USIPRNS"));for(var a=o.name.split(";"),u="",f=0;f<a.length;f++){var c=a[f].split("=");3==c.length?(c[0]==e&&(c[1]=i,c[2]=t,l=1),null!=c[1]&&"null"!=c[1]&&(u+=c[0]+"="+c[1]+"="+c[2]+";")):""!=a[f]&&(u+=a[f]+";")}0==l&&(u+=e+"="+i+"="+t+";"),o.name=u}catch(s){}},flush_window_name:function(e){try{for(var i=window.top||window,n=i.name.split(";"),t="",r=0;r<n.length;r++){var o=n[r].split("=");3==o.length&&(0==o[0].indexOf(e)||(t+=n[r]+";"))}i.name=t}catch(l){}},get_from_window_name:function(e){try{for(var i,n,t=(window.top||window).name.split(";"),r=0;r<t.length;r++){var o=t[r].split("=");if(3==o.length){if(o[0]==e&&(n=o[1],-1!=n.indexOf("USIEQLS")&&(n=n.replace(/USIEQLS/g,"=")),-1!=n.indexOf("USIPRNS")&&(n=n.replace(/USIPRNS/g,";")),!("-1"!=o[2]&&0>usi_cookies.datediff(o[2]))))return i=[n,o[2]]}else if(2==o.length&&o[0]==e)return n=o[1],-1!=n.indexOf("USIEQLS")&&(n=n.replace(/USIEQLS/g,"=")),-1!=n.indexOf("USIPRNS")&&(n=n.replace(/USIPRNS/g,";")),i=[n,new Date().getTime()+6048e5]}}catch(l){}return null},datediff:function(e){return e-new Date().getTime()},count_cookies:function(e){return e=e||"usi_",usi_cookies.search_cookies(e).length},root_domain:function(){try{var e=document.domain.split("."),i=e[e.length-1];if("com"==i||"net"==i||"org"==i||"us"==i||"co"==i||"ca"==i)return e[e.length-2]+"."+e[e.length-1]}catch(n){}return document.domain},create_cookie:function(e,i,n){if(!1!==navigator.cookieEnabled){var t="";if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t="; expires="+r.toGMTString()}var o="samesite=none;";0==location.href.indexOf("https://")&&(o+="secure;");var l=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(l=usi_parent_domain),document.cookie=e+"="+encodeURIComponent(i)+t+"; path=/;domain="+l+"; "+o}},create_nonencoded_cookie:function(e,i,n){if(!1!==navigator.cookieEnabled){var t="";if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t="; expires="+r.toGMTString()}var o="samesite=none;";0==location.href.indexOf("https://")&&(o+="secure;");var l=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(l=usi_parent_domain),document.cookie=e+"="+i+t+"; path=/;domain="+l+"; "+o}},read_cookie:function(e){if(!1===navigator.cookieEnabled)return null;var i=e+"=",n=[];try{n=document.cookie.split(";")}catch(t){}for(var r=0;r<n.length;r++){for(var o=n[r];" "==o.charAt(0);)o=o.substring(1,o.length);if(0==o.indexOf(i))return decodeURIComponent(o.substring(i.length,o.length))}return null},del:function(e){usi_cookies.set(e,null,-100);try{null!=localStorage&&localStorage.removeItem(e),null!=sessionStorage&&sessionStorage.removeItem(e)}catch(i){}},get_ls:function(e){try{var i=localStorage.getItem(e);if(null!=i){if(0==i.indexOf("{")&&-1!=i.indexOf("usi_expires")){var n=JSON.parse(i);if(new Date().getTime()>n.usi_expires)return localStorage.removeItem(e),null;i=n.value}return decodeURIComponent(i)}}catch(t){}return null},get:function(e){var i=usi_cookies.read_cookie(e);if(null!=i)return i;try{if(null!=localStorage&&(i=usi_cookies.get_ls(e),null!=i))return i;if(null!=sessionStorage&&(i=sessionStorage.getItem(e),null!=i))return decodeURIComponent(i)}catch(n){}var t=usi_cookies.get_from_window_name(e);if(null!=t&&t.length>1)try{i=decodeURIComponent(t[0])}catch(r){return t[0]}return i},get_json:function(e){var i=null,n=usi_cookies.get(e);if(null==n)return null;try{i=JSON.parse(n)}catch(t){n=n.replace(/\\"/g,'"');try{i=JSON.parse(JSON.parse(n))}catch(r){try{i=JSON.parse(n)}catch(o){}}}return i},search_cookies:function(e){e=e||"";var i=[];return document.cookie.split(";").forEach(function(n){var t=n.split("=")[0].trim();(""===e||0===t.indexOf(e))&&i.push(t)}),i},set:function(e,i,n,t){"undefined"!=typeof usi_nevercookie&&!0==usi_nevercookie&&(t=!1),void 0===n&&(n=-1);try{i=i.replace(/(\r\n|\n|\r)/gm,"")}catch(r){}"undefined"==typeof usi_windownameless&&usi_cookies.update_window_name(e+"",i+"",n);try{if(n>0&&null!=localStorage){var o=new Date,l={value:i,usi_expires:o.getTime()+1e3*n};localStorage.setItem(e,JSON.stringify(l))}else null!=sessionStorage&&sessionStorage.setItem(e,i)}catch(a){}if(t||null==i){if(null!=i){if(null==usi_cookies.read_cookie(e)&&!t&&usi_cookies.search_cookies("usi_").length+1>usi_cookies.max_cookies_count){usi_cookies.report_error('Set cookie "'+e+'" failed. Max cookies count is '+usi_cookies.max_cookies_count);return}if(i.length>usi_cookies.max_cookie_length){usi_cookies.report_error('Cookie "'+e+'" truncated ('+i.length+"). Max single-cookie length is "+usi_cookies.max_cookie_length);return}}usi_cookies.create_cookie(e,i,n)}},set_json:function(e,i,n,t){var r=JSON.stringify(i).replace(/^"/,"").replace(/"$/,"");usi_cookies.set(e,r,n,t)},flush:function(e){e=e||"usi_";var i,n,t,r=document.cookie.split(";");for(i=0;i<r.length;i++)0==(n=r[i]).trim().toLowerCase().indexOf(e)&&(t=n.trim().split("=")[0],usi_cookies.del(t));usi_cookies.flush_window_name(e);try{if(null!=localStorage)for(var o in localStorage)0==o.indexOf(e)&&localStorage.removeItem(o);if(null!=sessionStorage)for(var o in sessionStorage)0==o.indexOf(e)&&sessionStorage.removeItem(o)}catch(l){}},print:function(){for(var e=document.cookie.split(";"),i="",n=0;n<e.length;n++){var t=e[n];0==t.trim().toLowerCase().indexOf("usi_")&&(console.log(decodeURIComponent(t.trim())+" (cookie)"),i+=","+t.trim().toLowerCase().split("=")[0]+",")}try{if(null!=localStorage)for(var r in localStorage)0==r.indexOf("usi_")&&"string"==typeof localStorage[r]&&-1==i.indexOf(","+r+",")&&(console.log(r+"="+usi_cookies.get_ls(r)+" (localStorage)"),i+=","+r+",");if(null!=sessionStorage)for(var r in sessionStorage)0==r.indexOf("usi_")&&"string"==typeof sessionStorage[r]&&-1==i.indexOf(","+r+",")&&(console.log(r+"="+sessionStorage[r]+" (sessionStorage)"),i+=","+r+",")}catch(o){}for(var l=(window.top||window).name.split(";"),a=0;a<l.length;a++){var u=l[a].split("=");if(3==u.length&&0==u[0].indexOf("usi_")&&-1==i.indexOf(","+u[0]+",")){var f=u[1];-1!=f.indexOf("USIEQLS")&&(f=f.replace(/USIEQLS/g,"=")),-1!=f.indexOf("USIPRNS")&&(f=f.replace(/USIPRNS/g,";")),console.log(u[0]+"="+f+" (window.name)"),i+=","+t.trim().toLowerCase().split("=")[0]+","}}},value_exists:function(){var e,i;for(e=0;e<arguments.length;e++)if(i=usi_cookies.get(arguments[e]),""===i||null===i||"null"===i||"undefined"===i)return!1;return!0},report_error:function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}},"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.gup&&"function"==typeof usi_commons.gup_or_get_cookie)try{""!=usi_commons.gup("usi_email_id")?usi_cookies.set("usi_email_id",usi_commons.gup("usi_email_id").split(".")[0],Number(usi_commons.gup("usi_email_id").split(".")[1]),!0):null==usi_cookies.read_cookie("usi_email_id")&&null!=usi_cookies.get_from_window_name("usi_email_id")&&(usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?usi_email_id_fix="+encodeURIComponent(usi_cookies.get_from_window_name("usi_email_id")[0])),usi_cookies.set("usi_email_id",usi_cookies.get_from_window_name("usi_email_id")[0],(usi_cookies.get_from_window_name("usi_email_id")[1]-new Date().getTime())/1e3,!0)),""!=usi_commons.gup_or_get_cookie("usi_debug")&&(usi_commons.debug=!0),""!=usi_commons.gup_or_get_cookie("usi_qa")&&(usi_commons.domain=usi_commons.cdn="https://prod.upsellit.com")}catch(e){usi_commons.report_error(e)}-1!=location.href.indexOf("usi_clearcookies")&&usi_cookies.flush()}
if (typeof usi_analytics === 'undefined') {
	usi_analytics = {
		cookie_length : 30,
		load_script:function(source) {
			var docHead = document.getElementsByTagName("head")[0];
			if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
			var newScript = document.createElement('script');
			newScript.type = 'text/javascript';
			newScript.src = source;
			docHead.appendChild(newScript);
		},
		get_id:function() {
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_analytics') == null && usi_cookies.get('usi_id') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_analytics') != null) usi_id = usi_cookies.get('usi_analytics');
				if (usi_cookies.get('usi_id') != null) usi_id = usi_cookies.get('usi_id');
				usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		send_page_hit:function(report_type, companyID, data1) {
			var qs = "";
			if (data1) qs += data1;
			usi_analytics.load_script(usi_commons.domain + "/analytics/hit.js?usi_a="+usi_analytics.get_id(companyID)+"&usi_t="+(Date.now())+"&usi_r="+report_type+"&usi_c="+companyID+qs+"&usi_u="+encodeURIComponent(location.href));
		}
	};
}"undefined"==typeof usi_dom&&(usi_dom={},usi_dom.get_elements=function(e,t){return t=t||document,Array.prototype.slice.call(t.querySelectorAll(e))},usi_dom.count_elements=function(e,t){return t=t||document,usi_dom.get_elements(e,t).length},usi_dom.get_nth_element=function(e,t,n){var o=null;n=n||document;var r=usi_dom.get_elements(t,n);return r.length>=e&&(o=r[e-1]),o},usi_dom.get_first_element=function(e,t){if(""===(e||""))return null;if(t=t||document,"[object Array]"===Object.prototype.toString.call(e)){for(var n=null,o=0;o<e.length;o++){var r=e[o];if(null!=(n=usi_dom.get_first_element(r,t)))break}return n}return t.querySelector(e)},usi_dom.get_element_text_no_children=function(e,t){var n="";if(null==t&&(t=!1),null!=(e=e||document)&&null!=e.childNodes)for(var o=0;o<e.childNodes.length;++o)3===e.childNodes[o].nodeType&&(n+=e.childNodes[o].textContent);return!0===t&&(n=usi_dom.clean_string(n)),n.trim()},usi_dom.clean_string=function(e){if("string"==typeof e){return(e=(e=(e=(e=(e=(e=(e=e.replace(/[\u2010-\u2015\u2043]/g,"-")).replace(/[\u2018-\u201B]/g,"'")).replace(/[\u201C-\u201F]/g,'"')).replace(/\u2024/g,".")).replace(/\u2025/g,"..")).replace(/\u2026/g,"...")).replace(/\u2044/g,"/")).replace(/[^\x20-\xFF\u0100-\u017F\u0180-\u024F\u20A0-\u20CF]/g,"").trim()}},usi_dom.encode=function(e){if("string"==typeof e){var t=encodeURIComponent(e);return t=t.replace(/[-_.!~*'()]/g,function(e){return"%"+e.charCodeAt(0).toString(16).toUpperCase()})}},usi_dom.get_closest=function(e,t){for(e=e||document,"function"!=typeof Element.prototype.matches&&(Element.prototype.matches=Element.prototype.matchesSelector||Element.prototype.mozMatchesSelector||Element.prototype.msMatchesSelector||Element.prototype.oMatchesSelector||Element.prototype.webkitMatchesSelector||function(e){for(var t=(this.document||this.ownerDocument).querySelectorAll(e),n=t.length;--n>=0&&t.item(n)!==this;);return n>-1});null!=e&&e!==document;e=e.parentNode)if(e.matches(t))return e;return null},usi_dom.get_classes=function(e){var t=[];return null!=e&&null!=e.classList&&(t=Array.prototype.slice.call(e.classList)),t},usi_dom.add_class=function(e,t){if(null!=e){var n=usi_dom.get_classes(e);-1===n.indexOf(t)&&(n.push(t),e.className=n.join(" "))}},usi_dom.string_to_decimal=function(e){var t=null;if("string"==typeof e)try{var n=parseFloat(e.replace(/[^0-9\.-]+/g,""));!1===isNaN(n)&&(t=n)}catch(e){usi_commons.log("Error: "+e.message)}return t},usi_dom.string_to_integer=function(e){var t=null;if("string"==typeof e)try{var n=parseInt(e.replace(/[^0-9-]+/g,""));!1===isNaN(n)&&(t=n)}catch(e){usi_commons.log("Error: "+e.message)}return t},usi_dom.get_currency_string_from_content=function(e){if("string"!=typeof e)return"";try{e=e.trim();var t=e.match(/^([^\$]*?)(\$(?:[\,\,]?\d{1,3})+(?:\.\d{2})?)(.*?)$/)||[];return 4===t.length?t[2]:""}catch(e){return usi_commons.log("Error: "+e.message),""}},usi_dom.get_absolute_url=function(){var e;return function(t){return(e=e||document.createElement("a")).href=t,e.href}}(),usi_dom.format_number=function(e,t){var n="";if("number"==typeof e){t=t||0;var o=e.toFixed(t).split(/\./g);if(1==o.length||2==o.length)n=o[0].replace(/./g,function(e,t,n){return t&&"."!==e&&(n.length-t)%3==0?","+e:e}),2==o.length&&(n+="."+o[1])}return n},usi_dom.format_currency=function(e,t,n){var o="";return e=Number(e),!1===isNaN(e)&&("object"==typeof Intl&&"function"==typeof Intl.NumberFormat?(t=t||"en-US",n=n||{style:"currency",currency:"USD"},o=e.toLocaleString(t,n)):o=e),o},usi_dom.to_decimal_places=function(e,t){if(null!=e&&"number"==typeof e&&null!=t&&"number"==typeof t){if(0==t)return parseFloat(Math.round(e));for(var n=10,o=1;o<t;o++)n*=10;return parseFloat(Math.round(e*n)/n)}return null},usi_dom.trim_string=function(e,t,n){return n=n||"",(e=e||"").length>t&&(e=e.substring(0,t),""!==n&&(e+=n)),e},usi_dom.attach_event=function(e,t,n){var o=usi_dom.find_supported_element(e,n);usi_dom.detach_event(e,t,o),o.addEventListener?o.addEventListener(e,t,!1):o.attachEvent("on"+e,t)},usi_dom.detach_event=function(e,t,n){var o=usi_dom.find_supported_element(e,n);o.removeEventListener?o.removeEventListener(e,t,!1):o.detachEvent("on"+e,t)},usi_dom.find_supported_element=function(e,t){return(t=t||document)===window?window:!0===usi_dom.is_event_supported(e,t)?t:t===document?window:usi_dom.find_supported_element(e,document)},usi_dom.is_event_supported=function(e,t){return null!=t&&void 0!==t["on"+e]},usi_dom.is_defined=function(e,t){if(null==e)return!1;if(""===(t||""))return!1;var n=!0,o=e;return t.split(".").forEach(function(e){!0===n&&(null==o||"object"!=typeof o||!1===o.hasOwnProperty(e)?n=!1:o=o[e])}),n},usi_dom.observe=function(e,t,n){var o=location.href,r=window.MutationObserver||window.WebkitMutationObserver;return t=t||{onUrlUpdate:!1,observerOptions:{childList:!0,subtree:!0}},function(e,n){var i=null,u=function(){var e=location.href;t.onUrlUpdate&&e!==o?(n(),o=e):n()};return r?(i=new r(function(e){var r=location.href,i=e[0].addedNodes.length||e[0].removedNodes.length;i&&t.onUrlUpdate&&r!==o?(n(),o=r):i&&n()})).observe(e,t.observerOptions):window.addEventListener&&(e.addEventListener("DOMNodeInserted",u,!1),e.addEventListener("DOMNodeRemoved",u,!1)),i}}(),usi_dom.params_to_object=function(e){var t={};""!=(e||"")&&e.split("&").forEach(function(e){var n=e.split("=");2===n.length?t[decodeURIComponent(n[0])]=decodeURIComponent(n[1]):1===n.length&&(t[decodeURIComponent(n[0])]=null)});return t},usi_dom.object_to_params=function(e){var t=[];if(null!=e)for(var n in e)!0===e.hasOwnProperty(n)&&t.push(encodeURIComponent(n)+"="+(null==e[n]?"":encodeURIComponent(e[n])));return t.join("&")},usi_dom.interval_with_timeout=function(e,t,n,o){if("function"!=typeof e)throw new Error("usi_dom.interval_with_timeout(): iterationFunction must be a function");if(null==t)t=function(e){return e};else if("function"!=typeof t)throw new Error("usi_dom.interval_with_timeout(): timeoutCallback must be a function");if(null==n)n=function(e){return e};else if("function"!=typeof n)throw new Error("usi_dom.interval_with_timeout(): completeCallback must be a function");var r=(o=o||{}).intervalMS||20,i=o.timeoutMS||2e3;if("number"!=typeof r)throw new Error("usi_dom.interval_with_timeout(): intervalMS must be a number");if("number"!=typeof i)throw new Error("usi_dom.interval_with_timeout(): timeoutMS must be a number");var u=!1,l=new Date,a=setInterval(function(){var o=new Date-l;if(o>=i)return clearInterval(a),t({elapsedMS:o});!1===u&&(u=!0,e(function(e,t){if(u=!1,!0===e)return clearInterval(a),(t=t||{}).elapsedMS=new Date-l,n(t)}))},r)},usi_dom.load_external_stylesheet=function(e,t,n){if(""!==(e||"")){""===(t||"")&&(t="usi_stylesheet_"+(new Date).getTime());var o={url:e,id:t},r=document.getElementsByTagName("head")[0];if(null!=r){var i=document.createElement("link");i.type="text/css",i.rel="stylesheet",i.id=o.id,i.href=e,usi_dom.attach_event("load",function(){if(null!=n)return n(null,o)},i),r.appendChild(i)}}else if(null!=n)return n(null,o)},usi_dom.ready=function(e){void 0!==document.readyState&&"complete"===document.readyState?e():window.addEventListener?window.addEventListener("load",e,!0):window.attachEvent?window.attachEvent("onload",e):setTimeout(e,5e3)},usi_dom.fit_text=function(e,t){t||(t={});var n={multiLine:!0,minFontSize:.1,maxFontSize:20,widthOnly:!1},o={};for(var r in n)t.hasOwnProperty(r)?o[r]=t[r]:o[r]=n[r];var i=Object.prototype.toString.call(e);function u(e,t){var n,o,r,i,u,l,a,s;r=e.innerHTML,u=parseInt(window.getComputedStyle(e,null).getPropertyValue("font-size"),10),i=function(e){var t=window.getComputedStyle(e,null);return(e.clientWidth-parseInt(t.getPropertyValue("padding-left"),10)-parseInt(t.getPropertyValue("padding-right"),10))/u}(e),o=function(e){var t=window.getComputedStyle(e,null);return(e.clientHeight-parseInt(t.getPropertyValue("padding-top"),10)-parseInt(t.getPropertyValue("padding-bottom"),10))/u}(e),i&&(t.widthOnly||o)||(t.widthOnly?usi_commons.log("Set a static width on the target element "+e.outerHTML):usi_commons.log("Set a static height and width on the target element "+e.outerHTML)),-1===r.indexOf("textFitted")?((n=document.createElement("span")).className="textFitted",n.style.display="inline-block",n.innerHTML=r,e.innerHTML="",e.appendChild(n)):n=e.querySelector("span.textFitted"),t.multiLine||(e.style["white-space"]="nowrap"),l=t.minFontSize,s=t.maxFontSize;for(var c=l,d=1e3;l<=s&&d>0;)d--,a=s+l-.1,n.style.fontSize=a+"em",n.scrollWidth/u<=i&&(t.widthOnly||n.scrollHeight/u<=o)?(c=a,l=a+.1):s=a-.1;n.style.fontSize!==c+"em"&&(n.style.fontSize=c+"em")}"[object Array]"!==i&&"[object NodeList]"!==i&&"[object HTMLCollection]"!==i&&(e=[e]);for(var l=0;l<e.length;l++)u(e[l],o)});
"undefined"==typeof usi_date&&(usi_date={},usi_date.PSTOffsetMinutes=480,usi_date.localOffsetMinutes=(new Date).getTimezoneOffset(),usi_date.offsetDeltaMinutes=usi_date.localOffsetMinutes-usi_date.PSTOffsetMinutes,usi_date.toPST=function(e){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*usi_date.offsetDeltaMinutes*1e3)},usi_date.add_hours=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*t*60*1e3)},usi_date.add_minutes=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*t*1e3)},usi_date.add_seconds=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+1e3*t)},usi_date.get_week_number=function(e){var t={year:-1,weekNumber:-1};try{if(usi_date.is_date(e)){var a=new Date(Date.UTC(e.getFullYear(),e.getMonth(),e.getDate()));a.setUTCDate(a.getUTCDate()+4-(a.getUTCDay()||7));var s=new Date(Date.UTC(a.getUTCFullYear(),0,1)),i=Math.ceil(((a-s)/864e5+1)/7);t.year=a.getUTCFullYear(),t.weekNumber=i}}catch(e){}finally{return t}},usi_date.is_date=function(e){return null!=e&&"object"==typeof e&&e instanceof Date==!0&&!1===isNaN(e.getTime())},usi_date.is_date_within_range=function(e,t,a){if(void 0===e&&(e=usi_date.set_date()),!1===usi_date.is_date(e))return!1;var s=usi_date.string_to_date(t,!1),i=usi_date.string_to_date(a,!1),r=usi_date.toPST(e);return r>=s&&r<i},usi_date.is_after=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),a=new Date(e);return t.getTime()>a.getTime()}catch(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}return!1},usi_date.is_before=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),a=new Date(e);return t.getTime()<a.getTime()}catch(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}return!1},usi_date.is_between=function(e,t){return usi_date.check_format(e,t),usi_date.is_after(e)&&usi_date.is_before(t)},usi_date.check_format=function(e,t){(-1!=e.indexOf(" ")||t&&-1!=t.indexOf(" "))&&"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error("Incorrect format: Use YYYY-MM-DDThh:mm:ss")},usi_date.is_date_after=function(e,t){if(!1===usi_date.is_date(e))return!1;var a=usi_date.string_to_date(t,!1);return usi_date.toPST(e)>a},usi_date.is_date_before=function(e,t){if(!1===usi_date.is_date(e))return!1;var a=usi_date.string_to_date(t,!1);return usi_date.toPST(e)<a},usi_date.string_to_date=function(e,t){t=t||!1;var a=null,s=/^[0-2]?[0-9]\/[0-3]?[0-9]\/\d{4}(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e),i=/^(\d{4}\-[0-2]?[0-9]\-[0-3]?[0-9])(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e);if(2===(s||[]).length){if(a=new Date(e),""===(s[1]||"")&&!0===t){var r=new Date;a=usi_date.add_hours(a,r.getHours()),a=usi_date.add_minutes(a,r.getMinutes()),a=usi_date.add_seconds(a,r.getSeconds())}}else if(3===(i||[]).length){var o=i[1].split(/\-/g),u=o[1]+"/"+o[2]+"/"+o[0];return u+=i[2]||"",usi_date.string_to_date(u,t)}return a},usi_date.set_date=function(){var e=new Date,t=usi_commons.gup("usi_force_date");if(""!==t){t=decodeURIComponent(t);var a=usi_date.string_to_date(t,!0);null!=a?(e=a,usi_cookies.set("usi_force_date",t,usi_cookies.expire_time.hour),usi_commons.log("Date forced to: "+e)):usi_cookies.del("usi_force_date")}else e=null!=usi_cookies.get("usi_force_date")?usi_date.string_to_date(usi_cookies.get("usi_force_date"),!0):new Date;return e},usi_date.diff=function(e,t,a,s){null==s&&(s=1),""!=(a||"")&&(a=usi_date.get_units(a));var i=null;if(!0===usi_date.is_date(t)&&!0===usi_date.is_date(e))try{var r=Math.abs(t-e);switch(a){case"ms":i=r;break;case"seconds":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3),s);break;case"minutes":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60),s);break;case"hours":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60)/parseFloat(60),s);break;case"days":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60)/parseFloat(60)/parseFloat(24),s)}}catch(e){i=null}return i},usi_date.convert_units=function(e,t,a,s){var i=null,r=null;switch(usi_date.get_units(t)){case"days":i=1e6*e*1e3*60*60*24;break;case"hours":i=1e6*e*1e3*60*60;break;case"minutes":i=1e6*e*1e3*60;break;case"seconds":i=1e6*e*1e3;break;case"ms":i=1e6*e}switch(usi_date.get_units(a)){case"days":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60)/parseFloat(60)/parseFloat(24),s);break;case"hours":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60)/parseFloat(60),s);break;case"minutes":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60),s);break;case"seconds":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3),s);break;case"ms":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6),s)}return r},usi_date.get_units=function(e){var t="";switch(e.toLowerCase()){case"days":case"day":case"d":t="days";break;case"hours":case"hour":case"hrs":case"hr":case"h":t="hours";break;case"minutes":case"minute":case"mins":case"min":case"m":t="minutes";break;case"seconds":case"second":case"secs":case"sec":case"s":t="seconds";break;case"ms":case"milliseconds":case"millisecond":case"millis":case"milli":t="ms"}return t});

usi_parent_domain = document.domain.replace("store.", "").replace("cart.", "").replace("checkout.", "").replace("www.", "");
if (window.usi_app === undefined && window === window.parent) {
	try {
		if (typeof usi_cookies !== "undefined") {
			usi_cookies.max_cookies_count = 50;
		}
		usi_app = {};
		usi_app.is_storage_supported = function (type) {
			try {
				window[type].setItem('usi_' + type, '1');
				window[type].removeItem('usi_' + type);
				return true;
			} catch (e) {
				return false;
			}
		}
		
usi_app.encode_link = function (dest) {
	if (usi_app.locale == "en-MY") return encodeURIComponent(encodeURIComponent(dest + "&usi_pids=")) + encodeURIComponent("{{usi_pids}}");
  else return encodeURIComponent(encodeURIComponent("https://" + document.domain + dest + "&usi_pids=")) + encodeURIComponent("{{usi_pids}}");
};
usi_app.aff_links = {
	"en-GB": "https://www.dpbolvw.net/click-2681135-14068235",
	"en-UK": "https://www.dpbolvw.net/click-2681135-14068235",
	"en-SE": "https://www.dpbolvw.net/click-2681135-14535970",
	"en-MY": "https://www.kqzyfj.com/click-2681135-14065794",
	"en-MY": "https://www.kqzyfj.com/click-2681135-14065794",
	"en-SG": "https://www.anrdoezrs.net/click-2681135-14065798",
	"en-SG": "https://www.anrdoezrs.net/click-2681135-14065798",
	"en-NZ": "https://t.cfjump.com/12927/t/15672",
	"en-AU": "https://t.cfjump.com/12927/t/15672",
	"en-AU": "https://t.cfjump.com/12927/t/15672",
	"en-EU": "https://www.anrdoezrs.net/click-2681135-14068240",
	"en-CA": "https://www.jdoqocy.com/click-2681135-12797027",
	"en-US": "https://www.anrdoezrs.net/click-2681135-14065590",
	"en-IN": "https://www.jdoqocy.com/click-2681135-14065797",
	"es-AR": "https://www.dpbolvw.net/click-2681135-14065695",
	"es-MX": "https://www.anrdoezrs.net/click-2681135-14065692",
	"es-MX": "https://www.anrdoezrs.net/click-2681135-14065692",
	"es-MX": "https://www.anrdoezrs.net/click-2681135-14065692",
	"es-ES": "https://www.dpbolvw.net/click-2681135-14068238",
	"fr-FR": "https://www.dpbolvw.net/click-2681135-14068237",
	"fr-CH": "https://www.jdoqocy.com/click-2681135-14068259",
	"fr-CA": "https://www.jdoqocy.com/click-2681135-14065693",
	"it-IT": "https://www.dpbolvw.net/click-2681135-14068239",
	"it-CH": "https://www.anrdoezrs.net/click-2681135-14068260",
	"pt-BR": "https://www.kqzyfj.com/click-2681135-14065694",
	"pt-PT": "https://www.anrdoezrs.net/click-2681135-14068256",
	"pl-PL": "https://www.jdoqocy.com/click-2681135-14068255",
	"de-DE": "https://www.anrdoezrs.net/click-2681135-14068236",
	"de-CH": "https://www.anrdoezrs.net/click-2681135-14068257",
	"no-NO": "https://www.tkqlhce.com/click-2681135-14068247",
	"nl-NL": "https://www.tkqlhce.com/click-2681135-14068249",
	"nl-BE": "https://www.tkqlhce.com/click-2681135-14068251",
	"fr-BE": "https://www.jdoqocy.com/click-2681135-14068252",
	"ru-RU": "https://www.dpbolvw.net/click-2681135-14068261",
	"tr-TR": "https://www.kqzyfj.com/click-2681135-14068262",
	"sv-SE": "https://www.jdoqocy.com/click-2681135-14068241",
	"ja-JP": "https://www.jdoqocy.com/click-2681135-14065795",
	"ko-KR": "https://www.anrdoezrs.net/click-2681135-14065796",
	"fi-FI": "https://www.tkqlhce.com/click-2681135-14068243",
	"hu-HU": "https://www.dpbolvw.net/click-2681135-14068254",
	"cs-CZ": "https://www.jdoqocy.com/click-2681135-14068253",
	"da-DK": "https://www.anrdoezrs.net/click-2681135-14068244",
	"zh-CN": "https://www.jdoqocy.com/click-2681135-14065793"
}
// Deal Days campaigns
usi_app.deal_days_matrix = {
	"en-US": {
		copy: "Don't miss out on Autodesk Deal Days! Sign up to be the first to know when our deals go live.",
		cta: "Sign Up",
		email: "Enter Email",
		destination: "https://www.autodesk.com/promotions",
		eligible_pages: [
			'https://www.autodesk.com/',
			'https://www.autodesk.com/products',
			'https://www.autodesk.com/benefits/overview',
			'https://www.autodesk.com/benefits/subscription-discount',
			'https://www.autodesk.com/benefits/financing',
			'https://www.autodesk.com/benefits/sales-support',
			'https://www.autodesk.com/benefits/refund-policy',
			'https://www.autodesk.com/benefits/buy-online-securely',
			'https://www.autodesk.com/benefits/add-a-seat',
			'https://www.autodesk.com/benefits/referral-program',
			'https://www.autodesk.com/free-trials',
			'https://www.autodesk.com/viewers',
			'https://www.autodesk.com/promotions'
		],
		deliv_dsktp: "/chatskins/3614/Autodesk-LC-6-2023-PT1-english.png",
		deliv_mbl: "/chatskins/3614/Autodesk-LC-6-2023-mbl-PT1-english.png",
		disclaimer: "Yes, please add me to your list. I agree to receiving emails in accordance with your Privacy Policy."
	},
	"en-CA": {
		copy: "Don't miss out on Autodesk Deal Days! Sign up to be the first to know when our deals go live.",
		cta: "Sign Up",
		email: "Enter Email",
		destination: "https://www.autodesk.ca/en/promotions",
		eligible_pages: [
			"https://www.autodesk.ca/en/",
			"https://www.autodesk.ca/en/products",
			"https://www.autodesk.ca/en/promotions"
		],
		deliv_dsktp: "/chatskins/3614/Autodesk-LC-6-2023-PT1-english.png",
		deliv_mbl: "/chatskins/3614/Autodesk-LC-6-2023-mbl-PT1-english.png",
		disclaimer: "Yes, please add me to your list. I agree to receiving emails in accordance with your Privacy Policy."
	},
	"fr-CA": {
		copy: "Ne manquez pas les Journ\u00E9es Promo Autodesk! Inscrivez-vous pour \u00EAtre parmi les premiers au courant.",
		cta: "S'inscrire",
		email: "Saisir l\u2019e-mail",
		destination: "https://www.autodesk.ca/fr/promotions",
		eligible_pages: [
			"https://www.autodesk.ca/fr/",
			"https://www.autodesk.ca/fr/products",
			"https://www.autodesk.ca/fr/promotions"
		],
		deliv_dsktp: "/chatskins/3614/Autodesk-LC-6-2023-PT1-french.png",
		deliv_mbl: "/chatskins/3614/Autodesk-LC-6-2023-mbl-PT1-french.png",
		disclaimer: "Oui, ajoutez-moi \u00E0 votre liste. J\u2019accepte de recevoir des courriels conform\u00E9ment \u00E0 votre  Politique de confidentialit\u00E9."
	},
	"es-MX": {
		copy: "\u00A1No te pierda los D\u00EDas de Oferta de Autodesk! Reg\u00EDstrate para ser el primero en saber cu\u00E1ndo estar\u00E1n disponibles.",
		cta: "Inscribirse",
		email: "Indicar email",
		destination: "https://www.autodesk.mx/promotions",
		eligible_pages: [
			"https://www.autodesk.mx/",
			"https://www.autodesk.mx/products",
			"https://www.autodesk.mx/promotions"
		],
		deliv_dsktp: "/chatskins/3614/Autodesk-LC-6-2023-PT1-spanish.png",
		deliv_mbl: "/chatskins/3614/Autodesk-LC-6-2023-mbl-PT1-spanish.png",
		disclaimer: "S\u00ED, por favor a\u00F1adidme a vuestra lista. Acepto recibir correos electr\u00F3nicos de acuerdo con vuestra Pol\u00EDtica de Privacidad"
	},
	"es-AR": {
		copy: "\u00A1No te pierda los D\u00EDas de Oferta de Autodesk! Reg\u00EDstrate para ser el primero en saber cu\u00E1ndo estar\u00E1n disponibles.",
		cta: "Inscribirse",
		email: "Indicar email",
		destination: "https://latinoamerica.autodesk.com/promotions",
		eligible_pages: [
			"https://latinoamerica.autodesk.com/",
			"https://latinoamerica.autodesk.com/products",
			"https://latinoamerica.autodesk.com/promotions"
		],
		deliv_dsktp: "/chatskins/3614/Autodesk-LC-6-2023-PT1-spanish.png",
		deliv_mbl: "/chatskins/3614/Autodesk-LC-6-2023-mbl-PT1-spanish.png",
		disclaimer: "S\u00ED, por favor a\u00F1adidme a vuestra lista. Acepto recibir correos electr\u00F3nicos de acuerdo con vuestra Pol\u00EDtica de Privacidad"
	},
	"pt-BR": {
		copy: "N\u00E3o perca os Dias de Desconto Autodesk! Inscreva-se para ser o primeiro a saber.",
		cta: "Inscrever-se",
		email: "digite e-mail",
		destination: "https://www.autodesk.com.br/promotions",
		eligible_pages: [
			"https://www.autodesk.com.br/",
			"https://www.autodesk.com.br/products",
			"https://www.autodesk.com.br/promotions"
		],
		deliv_dsktp: "/chatskins/3614/Autodesk-LC-6-2023-PT1-portugese.png",
		deliv_mbl: "/chatskins/3614/Autodesk-LC-6-2023-mbl-PT1-portugese.png",
		disclaimer: "Sim, por favor, me adicione \u00E0 sua lista. Eu concordo em receber e-mails de acordo com sua Pol\u00EDtica de Privacidade."
	}
};
// Deal Days Real campaigns
usi_app.deal_days_real_matrix = {
	"en-US": {
		copy: "3 Days Only - Save 20% on AutoCAD, AutoCAD LT, 3ds Max, Maya, and Revit LT Suite CTA: Save now",
		cta: "Save Now",
		destination: "https://www.autodesk.com/promotions",
		eligible_pages: [
			'https://www.autodesk.com/products',
			'https://www.autodesk.com/buying/overview',
			'https://www.autodesk.com/buying/how-to-buy',
			'https://www.autodesk.com/buying/plans',
			'https://www.autodesk.com/buying/terms-payments',
			'https://www.autodesk.com/buying/flex',
			'https://www.autodesk.com/buying/account',
			'https://www.autodesk.com/buying/renewal',
			'https://www.autodesk.com/free-trials',
			'https://www.autodesk.com/viewers',
			'https://www.autodesk.com/products/autocad/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.com/products/autocad-lt/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.com/products/revit-lt/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.com/products/3ds-max/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.com/products/maya/overview?term=1-YEAR&tab=subscription'
		],
		deliv_dsktp: "/chatskins/3614/Autodesk-TT-6-2023-english.png",
		deliv_mbl: "/chatskins/3614/Autodesk-TT-6-2023-english-mbl.png"
	},
	"en-CA": {
		copy: "3 Days Only - Save 20% on AutoCAD, AutoCAD LT, 3ds Max, Maya, and Revit LT Suite",
		cta: "Save Now",
		destination: "https://www.autodesk.ca/en/promotions",
		eligible_pages: [
			'https://www.autodesk.ca/en/products',
			'https://www.autodesk.ca/en/products/autocad/overview',
			'https://www.autodesk.ca/en/products/autocad-lt/overview',
			'https://www.autodesk.ca/en/products/revit-lt/overview',
			'https://www.autodesk.ca/en/products/3ds-max/',
			'https://www.autodesk.ca/en/products/maya/overview'
		],
		deliv_dsktp: "/chatskins/3614/Autodesk-TT-6-2023-english.png",
		deliv_mbl: "/chatskins/3614/Autodesk-TT-6-2023-english-mbl.png"
	},
	"fr-CA": {
		copy: "3 Jours Seulement - \u00C9conomisez 20 % sur AutoCAD, AutoCAD LT, 3ds Max, Maya et Revit LT Suite",
		cta: "\u00C9CONOMISER MAINTENANT",
		destination: "https://www.autodesk.ca/fr/promotions",
		eligible_pages: [
			'https://www.autodesk.ca/fr/products',
			'https://www.autodesk.ca/fr/products/autocad/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.ca/fr/products/autocad-lt/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.ca/fr/products/revit-lt/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.ca/fr/products/3ds-max/?term=1-YEAR&tab=subscription',
			'https://www.autodesk.ca/fr/products/maya/overview?term=1-YEAR&tab=subscription'
		],
		deliv_dsktp: "/chatskins/3614/Autodesk-TT-6-2023-french.png",
		deliv_mbl: "/chatskins/3614/Autodesk-TT-6-2023-french-mbl.png"
	},
	"es-MX": {
		copy: "S\u00F3lo Por 3 D\u00EDas - Ahorre un 20% en AutoCAD, AutoCAD LT, 3ds Max, Maya y Revit LT Suite",
		cta: "AHORRE AHORA",
		destination: "https://www.autodesk.mx/promotions",
		eligible_pages: [
			'https://www.autodesk.mx/products',
			'https://www.autodesk.mx/products/autocad/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.mx/products/autocad-lt/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.mx/products/revit-lt/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.mx/products/3ds-max/?term=1-YEAR&tab=subscription',
			'https://www.autodesk.mx/products/maya/overview?term=1-YEAR&tab=subscription'
		],
		deliv_dsktp: "/chatskins/3614/Autodesk-TT-6-2023-spanish.png",
		deliv_mbl: "/chatskins/3614/Autodesk-TT-6-2023-spanish-mbl.png"
	},
	"es-AR": {
		copy: "S\u00F3lo Por 3 D\u00EDas - Ahorre un 20% en AutoCAD, AutoCAD LT, 3ds Max, Maya y Revit LT Suite",
		cta: "AHORRE AHORA",
		destination: "https://latinoamerica.autodesk.com/promotions",
		eligible_pages: [
			'https://latinoamerica.autodesk.com/products',
			'https://latinoamerica.autodesk.com/products/autocad/overview?term=1-YEAR&tab=subscription',
			'https://latinoamerica.autodesk.com/products/autocad-lt/overview?term=1-YEAR&tab=subscription',
			'https://latinoamerica.autodesk.com/products/revit-lt/overview?term=1-YEAR&tab=subscription',
			'https://latinoamerica.autodesk.com/products/3ds-max/overview?term=1-YEAR&tab=subscription',
			'https://latinoamerica.autodesk.com/products/maya/overview?term=1-YEAR&tab=subscription'
		],
		deliv_dsktp: "/chatskins/3614/Autodesk-TT-6-2023-spanish.png",
		deliv_mbl: "/chatskins/3614/Autodesk-TT-6-2023-spanish-mbl.png"
	},
	"pt-BR": {
		copy: "S\u00F3 3 Dias - conomize 20% no AutoCAD, AutoCAD LT, 3ds Max, Maya e no Revit LT Suite",
		cta: "POUPE AGORA",
		destination: "https://www.autodesk.com.br/promotions",
		eligible_pages: [
			'https://www.autodesk.com.br/products',
			'https://www.autodesk.com.br/products/autocad/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.com.br/products/autocad-lt/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.com.br/products/revit-lt/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.com.br/products/3ds-max/overview?term=1-YEAR&tab=subscription',
			'https://www.autodesk.com.br/products/maya/overview?term=1-YEAR&tab=subscription'
		],
		deliv_dsktp: "/chatskins/3614/Autodesk-TT-6-2023-portugese.png",
		deliv_mbl: "/chatskins/3614/Autodesk-TT-6-2023-portugese-mbl.png"
	}
};
// Cloud products upsell
usi_app.cloud_products_upsell_matrix = {
	"en-SG": [{
		targets: ["MAYA", "3DSMAX"],
		upsell: "SGSUB",
		text: "Connect your team & scale workflows quickly in the cloud with Shotgrid.",
		cta: "ADD TO CART",
		region: "APAC"
	}, {
		targets: ["RVT", "CIV3D"],
		upsell: "COLLRP",
		text: "Collaborate anytime, anywhere securely in the cloud with BIM Collaborate Pro.",
		cta: "ADD TO CART",
		region: "APAC"
	}],
	"en-MY": [{
		targets: ["MAYA", "3DSMAX"],
		upsell: "SGSUB",
		text: "Connect your team & scale workflows quickly in the cloud with Shotgrid.",
		cta: "ADD TO CART",
		region: "APAC"
	}, {
		targets: ["RVT", "CIV3D"],
		upsell: "COLLRP",
		text: "Collaborate anytime, anywhere securely in the cloud with BIM Collaborate Pro.",
		cta: "ADD TO CART",
		region: "APAC"
	}],
	"en-AU": [{
		targets: ["MAYA", "3DSMAX"],
		upsell: "SGSUB",
		text: "Connect your team & scale workflows quickly in the cloud with Shotgrid.",
		cta: "ADD TO BASKET",
		region: "ANZ"
	}, {
		targets: ["RVT", "CIV3D"],
		upsell: "COLLRP",
		text: "Collaborate anytime, anywhere securely in the cloud with BIM Collaborate Pro.",
		cta: "ADD TO BASKET",
		region: "ANZ"
	}],
	"en-NZ": [{
		targets: ["MAYA", "3DSMAX"],
		upsell: "SGSUB",
		text: "Connect your team & scale workflows quickly in the cloud with Shotgrid.",
		cta: "ADD TO BASKET",
		region: "ANZ"
	}, {
		targets: ["RVT", "CIV3D"],
		upsell: "COLLRP",
		text: "Collaborate anytime, anywhere securely in the cloud with BIM Collaborate Pro.",
		cta: "ADD TO BASKET",
		region: "ANZ"
	}],
	"en-IN": [{
		targets: ["MAYA", "3DSMAX"],
		upsell: "SGSUB",
		text: "Connect your team & scale workflows quickly in the cloud with Shotgrid.",
		cta: "ADD TO BASKET",
		region: "APAC"
	}, {
		targets: ["RVT", "CIV3D"],
		upsell: "COLLRP",
		text: "Collaborate anytime, anywhere securely in the cloud with BIM Collaborate Pro.",
		cta: "ADD TO BASKET",
		region: "APAC"
	}],
	"ja-JP": [{
		targets: ["MAYA", "3DSMAX"],
		upsell: "SGSUB",
		text: "ShotGrid \u3067\u3001\u30AF\u30E9\u30A6\u30C9\u4E0A\u306E\u30C1\u30FC\u30E0\u9023\u643A\u3068\u3001\u30B9\u30E0\u30FC\u30BA\u306A\u30D7\u30ED\u30B8\u30A7\u30AF\u30C8\u9032\u884C\u3092\u3002",
		cta: "\u30AB\u30FC\u30C8\u306B\u8FFD\u52A0",
		region: "APAC"
	}, {
		targets: ["RVT", "CIV3D"],
		upsell: "COLLRP",
		text: "BIM Collaborate Pro \u306A\u3089\u3001\u3044\u3064\u3067\u3082\u3001\u3069\u3053\u3067\u3082\u3001\u5B89\u5168\u306B\u30AF\u30E9\u30A6\u30C9\u4E0A\u3067\u30B3\u30E9\u30DC\u30EC\u30FC\u30B7\u30E7\u30F3\u3002",
		cta: "\u30AB\u30FC\u30C8\u306B\u8FFD\u52A0",
		region: "APAC"
	}],
	"ko-KR": [{
		targets: ["MAYA", "3DSMAX"],
		upsell: "SGSUB",
		text: "\uD074\uB77C\uC6B0\uB4DC \uAE30\uBC18\uC758 ShotGrid\uB97C \uCD94\uAC00\uD558\uC5EC \uD504\uB85C\uC81D\uD2B8 \uAD00\uB9AC\uC5D0 \uD6A8\uC728\uC131\uC744 \uB354\uD558\uC138\uC694.",
		cta: "\uC7A5\uBC14\uAD6C\uB2C8\uC5D0 \uB2F4\uAE30",
		region: "APAC"
	}, {
		targets: ["RVT", "CIV3D"],
		upsell: "COLLRP",
		text: "\uD074\uB77C\uC6B0\uB4DC \uAE30\uBC18\uC758BIM Collaborate Pro\uB97C \uD1B5\uD574 \uC5B8\uC81C \uC5B4\uB514\uC11C\uB098 \uD6A8\uACFC\uC801\uC73C\uB85C \uD611\uC5C5\uD558\uC138\uC694.",
		cta: "\uC7A5\uBC14\uAD6C\uB2C8\uC5D0 \uB2F4\uAE30",
		region: "APAC"
	}],
	"en-US": [{
		targets: ["F360"],
		upsell: "F36MEIA",
		text: "Amplify your Fusion 360 CAM capabilities with the Machining Extension.",
		cta: "ADD TO CART",
		region: "AMERICAS"
	}],
	"en-CA": [{
		targets: ["F360"],
		upsell: "F36MEIA",
		text: "Amplify your Fusion 360 CAM capabilities with the Machining Extension.",
		cta: "ADD TO CART",
		region: "AMERICAS"
	}],
	"fr-CA": [{
		targets: ["F360"],
		upsell: "F36MEIA",
		text: "Amplify your Fusion 360 CAM capabilities with the Machining Extension.",
		cta: "ADD TO CART",
		region: "AMERICAS"
	}],
	"de-DE": [{
		targets: ["F360"],
		upsell: "F36MEIA",
		text: "Bauen Sie den CAM-Funktionsumfang von Fusion 360 aus.",
		cta: "IN DEN WARENKORB LEGEN",
		region: "EMEA"
	}],
	"en-EU": [{
		targets: ["F360"],
		upsell: "F36MEIA",
		text: "Amplify your Fusion 360 CAM capabilities with the Machining Extension.",
		cta: "ADD TO BASKET",
		region: "EMEA"
	}],
	"it-IT": [{
		targets: ["F360"],
		upsell: "F36MEIA",
		text: "Amplia le funzionalit\u00E0 CAM di Fusion 360 con Machining Extension.",
		cta: "AGGIUNGI AL CARRELLO",
		region: "EMEA"
	}],
	"fr-FR": [{
		targets: ["F360"],
		upsell: "F36MEIA",
		text: "Avec Machining Extension, \u00E9largissez les capacit\u00E9s FAO de Fusion 360.",
		cta: "AJOUTER AU PANIER",
		region: "EMEA"
	}],
	"en-UK": [{
		targets: ["F360"],
		upsell: "F36MEIA",
		text: "Amplify your Fusion 360 CAM capabilities with the Machining Extension.",
		cta: "ADD TO BASKET",
		region: "UK"
	}],
	"en-SE": [{
		targets: ["F360"],
		upsell: "F36MEIA",
		text: "Amplify your Fusion 360 CAM capabilities with the Machining Extension.",
		cta: "ADD TO CART",
		region: "UK"
	}]
};
// Define bundle offers
usi_app.bundle_offers = {
	'ACDIST_en-US_1-year': {
		copy: 'Save 15% on AutoCAD when you buy a bundle of three - ',
		cta: 'Get the bundle',
		url: '"https://checkout.autodesk.com/en-US?priceIds=27150%5Bqty:3%5D&promoCodes=1yrACAD3pack&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_en-US_3-year': {
		copy: 'Save 15% on AutoCAD when you buy a bundle of three - ',
		cta: 'Get the bundle',
		url: '"https://checkout.autodesk.com/en-US?priceIds=27152%5Bqty:3%5D&promoCodes=3yrACAD3pack&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_en-CA_1-year': {
		copy: 'Save 15% on AutoCAD when you buy a bundle of three - ',
		cta: 'Get the bundle',
		url: '"https://checkout.autodesk.com/en-CA?priceIds=23998%5Bqty:3%5D&promoCodes=1yrACAD3pack&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_en-CA_3-year': {
		copy: 'Save 15% on AutoCAD when you buy a bundle of three - ',
		cta: 'Get the bundle',
		url: '"https://checkout.autodesk.com/en-CA?priceIds=24000%5Bqty:3%5D&promoCodes=3yrACAD3pack&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_fr-CA_1-an': {
		copy: '\u00C9conomisez 15 % sur vos abonnements lorsque vous en achetez trois \u00E0 la fois - ',
		cta: 'PROFITEZ DE L\u2019OFFRE',
		url: '"https://checkout.autodesk.com/fr-CA?priceIds=23998%5Bqty:3%5D&promoCodes=1yrACAD3pack&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_fr-CA_3-ans': {
		copy: '\u00C9conomisez 15 % sur vos abonnements lorsque vous en achetez trois \u00E0 la fois - ',
		cta: 'PROFITEZ DE L\u2019OFFRE',
		url: '"https://checkout.autodesk.com/fr-CA?priceIds=24000%5Bqty:3%5D&promoCodes=3yrACAD3pack&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_en-US_1-year': {
		copy: 'Get 5 subscriptions of AutoCAD LT for the price of 4 - ',
		cta: 'Get the bundle',
		url: '"https://checkout.autodesk.com/en-US?priceIds=24131%5Bqty:5%5D&promoCodes=1yrlt5pack&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_en-US_3-year': {
		copy: 'Get 5 subscriptions of AutoCAD LT for the price of 4 - ',
		cta: 'Get the bundle',
		url: '"https://checkout.autodesk.com/en-US?priceIds=24147%5Bqty:5%5D&promoCodes=3yrlt5pack&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_en-CA_1-year': {
		copy: 'Get 5 subscriptions of AutoCAD LT for the price of 4 - ',
		cta: 'Get the bundle',
		url: '"https://checkout.autodesk.com/en-CA?priceIds=24117%5Bqty:5%5D&promoCodes=1yrlt5pack&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_en-CA_3-year': {
		copy: 'Get 5 subscriptions of AutoCAD LT for the price of 4 - ',
		cta: 'Get the bundle',
		url: '"https://checkout.autodesk.com/en-CA?priceIds=24133%5Bqty:5%5D&promoCodes=3yrlt5pack&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_fr-CA_1-an': {
		copy: 'Obtenez 5 abonnements \u00E0 AutoCAD LT pour le prix de 4 - ',
		cta: 'PROFITEZ DE L\u2019OFFRE',
		url: '"https://checkout.autodesk.com/fr-CA?priceIds=24117%5Bqty:5%5D&promoCodes=1yrlt5pack&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_fr-CA_3-ans': {
		copy: 'Obtenez 5 abonnements \u00E0 AutoCAD LT pour le prix de 4 - ',
		cta: 'PROFITEZ DE L\u2019OFFRE',
		url: '"https://checkout.autodesk.com/fr-CA?priceIds=24133%5Bqty:5%5D&promoCodes=3yrlt5pack&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_en-NZ_1-year': {
		copy: 'Get 3 AutoCAD LT subscriptions and save 20%. - ',
		cta: 'BUY NOW',
		url: '"https://commerce.autodesk.com/en-NZ?pid=5532232800%5Bqty:3%5D&offerid=63431897920"',
		qty: ['2', '3']
	},
	'ACDLT_en-NZ_3-year': {
		copy: 'Get 3 AutoCAD LT subscriptions and save 20%. - ',
		cta: 'BUY NOW',
		url: '"https://commerce.autodesk.com/en-NZ?pid=5532232900%5Bqty:3%5D&offerid=63431897920"',
		qty: ['2', '3']
	},
	'ACDIST_en-NZ_3-year': {
		copy: 'Get 3 AutoCAD subscriptions and save 20%. - ',
		cta: 'BUY NOW',
		url: '"https://commerce.autodesk.com/en-NZ?pid=5654504900%5Bqty%3A3%5D&offerid=63437020720"',
		qty: ['2', '3']
	},
	'ACDIST_en-NZ_1-year': {
		copy: 'Get 3 AutoCAD subscriptions and save 20%. - ',
		cta: 'BUY NOW',
		url: '"https://commerce.autodesk.com/en-NZ?pid=5654504800%5Bqty%3A3%5D&offerid=63437020720"',
		qty: ['2', '3']
	},
	/*
	'ACDLT_en-AU_3-year': {
		copy: 'Get 3 AutoCAD LT subscriptions and save 20%. - ',
		cta: 'BUY NOW',
		url: 'https://checkout.autodesk.com/en-AU/cart?offers=[country:AU;currency:AUD;priceRegionCode:AH;quantity:1;offeringName:AutoCAD%20LT;offeringId:OD-000031;offeringCode:ACDLT;accessModelCode:S;termCode:A06;intendedUsageCode:COM;connectivityCode:C100;connectivityIntervalCode:C04;billingFrequencyCode:B05;billingTypeCode:B100;billingBehaviorCode:A200;servicePlanIdCode:STND]',
		qty: ['2']
	},
	'ACDLT_en-AU_1-year': {
		copy: 'Get 3 AutoCAD LT subscriptions and save 20%. - ',
		cta: 'BUY NOW',
		url: 'https://checkout.autodesk.com/en-AU/cart?offers=[country:AU;currency:AUD;priceRegionCode:AH;quantity:1;offeringName:AutoCAD%20LT;offeringId:OD-000031;offeringCode:ACDLT;accessModelCode:S;termCode:A01;intendedUsageCode:COM;connectivityCode:C100;connectivityIntervalCode:C04;billingFrequencyCode:B05;billingTypeCode:B100;billingBehaviorCode:A200;servicePlanIdCode:STND]',
		qty: ['2']
	},
	'ACDIST_en-AU_3-year': {
		copy: 'Get 3 AutoCAD subscriptions and save 20%. - ',
		cta: 'BUY NOW',
		url: 'https://checkout.autodesk.com/en-AU/cart?offers=[country:AU;currency:AUD;priceRegionCode:AH;quantity:1;offeringName:ACAD%20-%20incld%20spclzd%20toolsets;offeringId:OD-000027;offeringCode:ACDIST;accessModelCode:S;termCode:A06;intendedUsageCode:COM;connectivityCode:C100;connectivityIntervalCode:C04;billingFrequencyCode:B05;billingTypeCode:B100;billingBehaviorCode:A200;servicePlanIdCode:STND]',
		qty: ['2']
	},
	'ACDIST_en-AU_1-year': {
		copy: 'Get 3 AutoCAD subscriptions and save 20%. - ',
		cta: 'BUY NOW',
		url: 'https://checkout.autodesk.com/en-AU/cart?offers=[country:AU;currency:AUD;priceRegionCode:AH;quantity:1;offeringName:ACAD%20-%20incld%20spclzd%20toolsets;offeringId:OD-000027;offeringCode:ACDIST;accessModelCode:S;termCode:A01;intendedUsageCode:COM;connectivityCode:C100;connectivityIntervalCode:C04;billingFrequencyCode:B05;billingTypeCode:B100;billingBehaviorCode:A200;servicePlanIdCode:STND]',
		qty: ['2']
	},
	*/
	'ACDLT_en-MY_1-year': {
		copy: 'Online exclusive! Get 3 AutoCAD LT subscriptions and save 20%. - ',
		cta: 'BUY NOW',
		url: '"https://store.autodesk.com/store/adskjp/en_MY/buy/productID.5763107700/quantity.3/OfferID.63543759920/Currency.MYR"',
		qty: ['2', '3']
	},
	'ACDLT_en-MY_3-year': {
		copy: 'Online exclusive! Get 3 AutoCAD LT subscriptions and save 20%. - ',
		cta: 'BUY NOW',
		url: '"https://store.autodesk.com/store/adskjp/en_MY/buy/productID.5763107900/quantity.3/OfferID.63543759920/Currency.MYR"',
		qty: ['2', '3']
	},
	'ACDLT_en-SG_1-year': {
		copy: 'Online exclusive! Get 3 AutoCAD LT subscriptions and save 20%. - ',
		cta: 'BUY NOW',
		url: '"https://store.autodesk.com/store/adsk/en_SG/buy/productID.5773506700/quantity.3/OfferID.63551570920/Currency.SGD"',
		qty: ['2', '3']
	},
	'ACDLT_en-SG_3-year': {
		copy: 'Online exclusive! Get 3 AutoCAD LT subscriptions and save 20%. - ',
		cta: 'BUY NOW',
		url: '"https://store.autodesk.com/store/adsk/en_SG/buy/productID.5773506800/quantity.3/OfferID.63551570920/Currency.SGD"',
		qty: ['2', '3']
	},
	'ACDIST_ko-KR_1-year': {
		copy: 'AutoCAD \uC138 \uC2DC\uD2B8 \uB2F9 \uCD5C\uB300 20%* \uD560\uC778. - ',
		cta: '\uC9C0\uAE08 \uD560\uC778\uBC1B\uAE30',
		url: '"https://store.autodesk.co.kr/store/adskkr/ko_KR/buy/productID.5759518600/quantity.3/OfferID.63538840920/Currency.KRW"',
		qty: ['2', '3']
	},
	'ACDIST_ko-KR_3-year': {
		copy: 'AutoCAD \uC138 \uC2DC\uD2B8 \uB2F9 \uCD5C\uB300 20%* \uD560\uC778.  - ',
		cta: '\uC9C0\uAE08 \uD560\uC778\uBC1B\uAE30',
		url: '"https://store.autodesk.co.kr/store/adskkr/ko_KR/buy/productID.5759518700/quantity.3/OfferID.63538840920/Currency.KRW"',
		qty: ['2', '3']
	},
	'ACDLT_ko-KR_1-year': {
		copy: 'AutoCAD LT \uC138 \uC2DC\uD2B8 \uB2F9 \uCD5C\uB300 20%* \uD560\uC778. - ',
		cta: '\uC9C0\uAE08 \uD560\uC778\uBC1B\uAE30',
		url: '"https://store.autodesk.co.kr/store/adskkr/ko_KR/buy/productID.5644220200/quantity.3/OfferID.63412857720/Currency.KRW"',
		qty: ['2', '3']
	},
	'ACDLT_ko-KR_3-year': {
		copy: 'AutoCAD LT \uC138 \uC2DC\uD2B8 \uB2F9 \uCD5C\uB300 20%* \uD560\uC778. - ',
		cta: '\uC9C0\uAE08 \uD560\uC778\uBC1B\uAE30',
		url: '"https://store.autodesk.co.kr/store/adskkr/ko_KR/buy/productID.5644220400/quantity.3/OfferID.63412857720/Currency.KRW"',
		qty: ['2', '3']
	},
	
	//UK
	'ACDIST_en-UK_1-year': {
		copy: 'Get 15% off three AutoCAD subscriptions - ',
		cta: 'Save now',
		url: '"https://checkout.autodesk.com/en-GB?priceIds=27340%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_en-UK_3-year': {
		copy: 'Get 15% off three AutoCAD subscriptions - ',
		cta: 'Save now',
		url: '"https://checkout.autodesk.com/en-GB?priceIds=33295%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_en-UK_1-year': {
		copy: 'Get 5 subscriptions for the price of 4 - ',
		cta: 'Save now',
		url: '"https://checkout.autodesk.com/en-GB?priceIds=27349%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_en-UK_3-year': {
		copy: 'Get 5 subscriptions for the price of 4 - ',
		cta: 'Save now',
		url: '"https://checkout.autodesk.com/en-GB?priceIds=33846%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//SE
	'ACDIST_en-SE_1-year': {
		copy: 'Get 15% off three AutoCAD subscriptions - ',
		cta: 'Save now',
		url: 'https://store.autodesk.com/store/adsk/en_SE/buy/productID.5533762400/quantity.3/OfferID.63351545410/Currency.USD',
		qty: ['2']
	},
	'ACDIST_en-SE_3-year': {
		copy: 'Get 15% off three AutoCAD subscriptions - ',
		cta: 'Save now',
		url: 'https://store.autodesk.com/store/adsk/en_SE/buy/productID.5533762500/quantity.3/OfferID.63351545410/Currency.USD',
		qty: ['2']
	},
	'ACDLT_en-SE_1-year': {
		copy: 'Get 5 subscriptions for the price of 4 - ',
		cta: 'Save now',
		url: 'https://store.autodesk.com/store/adsk/en_SE/buy/productID.5533762000/quantity.1/OfferID.63351545610/Currency.USD',
		qty: ['2', '3', '4']
	},
	'ACDLT_en-SE_3-year': {
		copy: 'Get 5 subscriptions for the price of 4 - ',
		cta: 'Save now',
		url: 'https://store.autodesk.com/store/adsk/en_SE/buy/productID.5533762100/quantity.1/OfferID.63351545610/Currency.USD',
		qty: ['2', '3', '4']
	},
	//EU
	'ACDIST_en-EU_1-year': {
		copy: 'Get 15% off three AutoCAD subscriptions - ',
		cta: 'Save now',
		url: '"https://checkout.autodesk.com/europe?priceIds=27631%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_en-EU_3-year': {
		copy: 'Get 15% off three AutoCAD subscriptions - ',
		cta: 'Save now',
		url: '"https://checkout.autodesk.com/europe?priceIds=33327%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_en-EU_1-year': {
		copy: 'Get 5 subscriptions for the price of 4 - ',
		cta: 'Save now',
		url: '"https://checkout.autodesk.com/europe?priceIds=27667%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_en-EU_3-year': {
		copy: 'Get 5 subscriptions for the price of 4 - ',
		cta: 'Save now',
		url: '"https://checkout.autodesk.com/europe?priceIds=33791%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//BE-FR
	'ACDIST_fr-BE_1-year': {
		copy: '\u00C9conomisez 15 % sur 3 abonnements AutoCAD - ',
		cta: 'J\u00B4en profite',
		url: '"https://checkout.autodesk.com/fr-BE?priceIds=27631%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_fr-BE_3-year': {
		copy: '\u00C9conomisez 15 % sur 3 abonnements AutoCAD - ',
		cta: 'J\u00B4en profite',
		url: '"https://checkout.autodesk.com/fr-BE?priceIds=33327%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_fr-BE_1-year': {
		copy: '5 abonnements pour le prix de 4 - ',
		cta: 'J\u00B4en profite',
		url: '"https://checkout.autodesk.com/fr-BE?priceIds=27667%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_fr-BE_3-year': {
		copy: '5 abonnements pour le prix de 4 - ',
		cta: 'J\u00B4en profite',
		url: '"https://checkout.autodesk.com/fr-BE?priceIds=33791%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//BE-NL
	'ACDIST_nl-BE_1-year': {
		copy: 'Krijg 15% korting op 3 AutoCAD-abonnementen - ',
		cta: 'Nu Besparen',
		url: '"https://checkout.autodesk.com/nl-BE?priceIds=27631%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_nl-BE_3-year': {
		copy: 'Krijg 15% korting op 3 AutoCAD-abonnementen - ',
		cta: 'Nu Besparen',
		url: '"https://checkout.autodesk.com/nl-BE?priceIds=33327%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_nl-BE_1-year': {
		copy: 'Krijg 5 abonnementen voor de prijs van 4 - ',
		cta: 'Nu Besparen',
		url: '"https://checkout.autodesk.com/nl-BE?priceIds=27667%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_nl-BE_3-year': {
		copy: 'Krijg 5 abonnementen voor de prijs van 4 - ',
		cta: 'Nu Besparen',
		url: '"https://checkout.autodesk.com/nl-BE?priceIds=33791%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//DE-DE
	'ACDIST_de-DE_1-year': {
		copy: '15 % Rabatt auf drei AutoCAD-Abonnements - ',
		cta: 'Jetzt sparen',
		url: '"https://checkout.autodesk.com/de-DE?priceIds=27633%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_de-DE_3-year': {
		copy: '15 % Rabatt auf drei AutoCAD-Abonnements - ',
		cta: 'Jetzt sparen',
		url: '"https://checkout.autodesk.com/de-DE?priceIds=33329%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_de-DE_1-year': {
		copy: 'Holen Sie sich 5 Abonnements zum Preis von 4 - ',
		cta: 'Jetzt sparen',
		url: '"https://checkout.autodesk.com/de-DE?priceIds=27665%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_de-DE_3-year': {
		copy: 'Holen Sie sich 5 Abonnements zum Preis von 4 - ',
		cta: 'Jetzt sparen',
		url: '"https://checkout.autodesk.com/de-DE?priceIds=33795%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//FR-FR
	'ACDIST_fr-FR_1-year': {
		copy: '\u00C9conomisez 15 % sur 3 abonnements AutoCAD - ',
		cta: 'J\u00B4en profite',
		url: '"https://checkout.autodesk.com/fr-FR?priceIds=27630%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_fr-FR_3-year': {
		copy: '\u00C9conomisez 15 % sur 3 abonnements AutoCAD - ',
		cta: 'J\u00B4en profite',
		url: '"https://checkout.autodesk.com/fr-FR?priceIds=33332%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_fr-FR_1-year': {
		copy: '5 abonnements pour le prix de 4 - ',
		cta: 'J\u00B4en profite',
		url: '"https://checkout.autodesk.com/fr-FR?priceIds=27664%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_fr-FR_3-year': {
		copy: '5 abonnements pour le prix de 4 - ',
		cta: 'J\u00B4en profite',
		url: '"https://checkout.autodesk.com/fr-FR?priceIds=33796%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//IT-IT
	'ACDIST_it-IT_1-year': {
		copy: 'Ottieni il 15% di sconto su 3 abbonamenti ad AutoCAD - ',
		cta: 'Risparmia Ora',
		url: '"https://checkout.autodesk.com/it-IT?priceIds=27629%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_it-IT_3-year': {
		copy: 'Ottieni il 15% di sconto su 3 abbonamenti ad AutoCAD - ',
		cta: 'Risparmia Ora',
		url: '"https://checkout.autodesk.com/it-IT?priceIds=33333%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_it-IT_1-year': {
		copy: '5 abbonamenti al prezzo di 4 - ',
		cta: 'Risparmia Ora',
		url: '"https://checkout.autodesk.com/it-IT?priceIds=27666%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_it-IT_3-year': {
		copy: '5 abbonamenti al prezzo di 4 - ',
		cta: 'Risparmia Ora',
		url: '"https://checkout.autodesk.com/it-IT?priceIds=33798%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//ES-ES
	'ACDIST_es-ES_1-year': {
		copy: 'Descuento de un 15% al comprar 3 suscripciones de AutoCAD - ',
		cta: 'AHORRE AHORA',
		url: '"https://checkout.autodesk.com/es-ES?priceIds=27632%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_es-ES_3-year': {
		copy: 'Descuento de un 15% al comprar 3 suscripciones de AutoCAD - ',
		cta: 'AHORRE AHORA',
		url: '"https://checkout.autodesk.com/es-ES?priceIds=33334%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_es-ES_1-year': {
		copy: 'Obtenga 5 suscripciones por el precio de 4 - ',
		cta: 'AHORRE AHORA',
		url: '"https://checkout.autodesk.com/es-ES?priceIds=27668%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_es-ES_3-year': {
		copy: 'Obtenga 5 suscripciones por el precio de 4 - ',
		cta: 'AHORRE AHORA',
		url: '"https://checkout.autodesk.com/es-ES?priceIds=33800%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//NL-NL
	'ACDIST_nl-NL_1-year': {
		copy: 'Krijg 15% korting op 3 AutoCAD-abonnementen - ',
		cta: 'Nu Besparen',
		url: '"https://checkout.autodesk.com/nl-NL?priceIds=27631%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_nl-NL_3-year': {
		copy: 'Krijg 15% korting op 3 AutoCAD-abonnementen - ',
		cta: 'Nu Besparen',
		url: '"https://checkout.autodesk.com/nl-NL?priceIds=33327%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_nl-NL_1-year': {
		copy: 'Krijg 5 abonnementen voor de prijs van 4 - ',
		cta: 'Nu Besparen',
		url: '"https://checkout.autodesk.com/nl-NL?priceIds=27667%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_nl-NL_3-year': {
		copy: 'Krijg 5 abonnementen voor de prijs van 4 - ',
		cta: 'Nu Besparen',
		url: '"https://checkout.autodesk.com/nl-NL?priceIds=33791%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//PT-PT
	'ACDIST_pt-PT_1-year': {
		copy: 'Obtenha 15% de desconto em 3 subscri\u00E7\u00F5es do AutoCAD - ',
		cta: 'Poupe Agora',
		url: '"https://checkout.autodesk.com/pt-PT?priceIds=27631%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_pt-PT_3-year': {
		copy: 'Obtenha 15% de desconto em 3 subscri\u00E7\u00F5es do AutoCAD - ',
		cta: 'Poupe Agora',
		url: '"https://checkout.autodesk.com/pt-PT?priceIds=33327%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_pt-PT_1-year': {
		copy: 'Obtenha 5 subscri\u00E7\u00F5es pelo pre\u00E7o de 4 - ',
		cta: 'Poupe Agora',
		url: '"https://checkout.autodesk.com/pt-PT?priceIds=27667%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_pt-PT_3-year': {
		copy: 'Obtenha 5 subscri\u00E7\u00F5es pelo pre\u00E7o de 4 - ',
		cta: 'Poupe Agora',
		url: '"https://checkout.autodesk.com/pt-PT?priceIds=33791%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//NO-NO
	'ACDIST_no-NO_1-year': {
		copy: 'F\u00E5 15% avslag p\u00E5 tre AutoCAD-abonnementer - ',
		cta: 'SPAR N\u00C5',
		url: '"https://checkout.autodesk.com/no-NO?priceIds=32268%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_no-NO_3-year': {
		copy: 'F\u00E5 15% avslag p\u00E5 tre AutoCAD-abonnementer - ',
		cta: 'SPAR N\u00C5',
		url: '"https://checkout.autodesk.com/no-NO?priceIds=32268%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_no-NO_1-year': {
		copy: 'F\u00E5 5 abonnementer for prisen av 4 - ',
		cta: 'SPAR N\u00C5',
		url: '"https://checkout.autodesk.com/no-NO?priceIds=32244%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_no-NO_3-year': {
		copy: 'F\u00E5 5 abonnementer for prisen av 4 - ',
		cta: 'SPAR N\u00C5',
		url: '"https://checkout.autodesk.com/no-NO?priceIds=33781%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//SV-SE
	'ACDIST_sv-SE_1-year': {
		copy: 'F\u00E5 15 % rabatt p\u00E5 3 AutoCAD-prenumerationer - ',
		cta: 'SPARA NU',
		url: '"https://checkout.autodesk.com/sv-SE?priceIds=30390%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_sv-SE_3-year': {
		copy: 'F\u00E5 15 % rabatt p\u00E5 3 AutoCAD-prenumerationer - ',
		cta: 'SPARA NU',
		url: '"https://checkout.autodesk.com/sv-SE?priceIds=33317%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_sv-SE_1-year': {
		copy: 'F\u00E5 5 prenumerationer till priset av 4 - ',
		cta: 'SPARA NU',
		url: '"https://checkout.autodesk.com/sv-SE?priceIds=30425%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_sv-SE_3-year': {
		copy: 'F\u00E5 5 prenumerationer till priset av 4 - ',
		cta: 'SPARA NU',
		url: '"https://checkout.autodesk.com/sv-SE?priceIds=33833%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//DA-DK
	'ACDIST_da-DK_1-year': {
		copy: 'F\u00E5 15% rabat p\u00E5 tre AutoCAD-abonnementer - ',
		cta: 'Spar Nu',
		url: '"https://checkout.autodesk.com/da-DK?priceIds=30388%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_da-DK_3-year': {
		copy: 'F\u00E5 15% rabat p\u00E5 tre AutoCAD-abonnementer - ',
		cta: 'Spar Nu',
		url: '"https://checkout.autodesk.com/da-DK?priceIds=33313%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_da-DK_1-year': {
		copy: 'F\u00E5 fem abonnementer - ',
		cta: 'Spar Nu',
		url: '"https://checkout.autodesk.com/da-DK?priceIds=30423%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_da-DK_3-year': {
		copy: 'F\u00E5 fem abonnementer - ',
		cta: 'Spar Nu',
		url: '"https://checkout.autodesk.com/da-DK?priceIds=33830%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//FI-FI
	'ACDIST_fi-FI_1-year': {
		copy: '15 %:n alennus kolmesta AutoCAD-tilauksesta - ',
		cta: 'S\u00C4\u00C4ST\u00C4 NYT',
		url: '"https://checkout.autodesk.com/fi-FI?priceIds=27631%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_fi-FI_3-year': {
		copy: '15 %:n alennus kolmesta AutoCAD-tilauksesta - ',
		cta: 'S\u00C4\u00C4ST\u00C4 NYT',
		url: '"https://checkout.autodesk.com/fi-FI?priceIds=33327%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_fi-FI_1-year': {
		copy: 'Hanki viisi tilausta nelj\u00E4n hinnalla - ',
		cta: 'S\u00C4\u00C4ST\u00C4 NYT',
		url: '"https://checkout.autodesk.com/fi-FI?priceIds=27667%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_fi-FI_3-year': {
		copy: 'Hanki viisi tilausta nelj\u00E4n hinnalla - ',
		cta: 'S\u00C4\u00C4ST\u00C4 NYT',
		url: '"https://checkout.autodesk.com/fi-FI?priceIds=33791%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//PL-PL
	'ACDIST_pl-PL_1-year': {
		copy: 'Zyskaj 15% zni\u017Cki na 3 subskrypcje AutoCAD - ',
		cta: 'ZAOSZCZ\u0118D\u0179',
		url: '"https://checkout.autodesk.com/pl-PL?priceIds=30389%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_pl-PL_3-year': {
		copy: 'Zyskaj 15% zni\u017Cki na 3 subskrypcje AutoCAD - ',
		cta: 'ZAOSZCZ\u0118D\u0179',
		url: '"https://checkout.autodesk.com/pl-PL?priceIds=33321%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_pl-PL_1-year': {
		copy: '5 subskrypcji w cenie 4 - ',
		cta: 'ZAOSZCZ\u0118D\u0179',
		url: '"https://checkout.autodesk.com/pl-PL?priceIds=30424%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_pl-PL_3-year': {
		copy: '5 subskrypcji w cenie 4 - ',
		cta: 'ZAOSZCZ\u0118D\u0179',
		url: '"https://checkout.autodesk.com/pl-PL?priceIds=33831%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//CS-CZ
	'ACDIST_cs-CZ_1-year': {
		copy: 'Z\u00EDskejte 15% slevu za 3 p\u0159edplatn\u00E1 aplikace Autodesk - ',
		cta: 'CHCI \u0160ET\u0158IT',
		url: '"https://checkout.autodesk.com/cs-CZ?priceIds=32094%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_cs-CZ_3-year': {
		copy: 'Z\u00EDskejte 15% slevu za 3 p\u0159edplatn\u00E1 aplikace Autodesk - ',
		cta: 'CHCI \u0160ET\u0158IT',
		url: '"https://checkout.autodesk.com/cs-CZ?priceIds=33366%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_cs-CZ_1-year': {
		copy: 'Z\u00EDskejte 5 p\u0159edplatn\u00FDch za cenu 4 - ',
		cta: 'CHCI \u0160ET\u0158IT',
		url: '"https://checkout.autodesk.com/cs-CZ?priceIds=32153%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_cs-CZ_3-year': {
		copy: 'Z\u00EDskejte 5 p\u0159edplatn\u00FDch za cenu 4 - ',
		cta: 'CHCI \u0160ET\u0158IT',
		url: '"https://checkout.autodesk.com/cs-CZ?priceIds=33777%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//HU-HU
	'ACDIST_hu-HU_1-year': {
		copy: '15% kedvezm\u00E9ny 3 AutoCAD-el\u0151fizet\u00E9sre - ',
		cta: 'TAKAR\u00CDTSON MEG MOST',
		url: '"https://checkout.autodesk.com/hu-HU?priceIds=27631%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_hu-HU_3-year': {
		copy: '15% kedvezm\u00E9ny 3 AutoCAD-el\u0151fizet\u00E9sre - ',
		cta: 'TAKAR\u00CDTSON MEG MOST',
		url: '"https://checkout.autodesk.com/hu-HU?priceIds=33327%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_hu-HU_1-year': {
		copy: '5 el\u0151fizet\u00E9s 4 \u00E1r\u00E1\u00E9rt - ',
		cta: 'TAKAR\u00CDTSON MEG MOST',
		url: '"https://checkout.autodesk.com/hu-HU?priceIds=27667%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_hu-HU_3-year': {
		copy: '5 el\u0151fizet\u00E9s 4 \u00E1r\u00E1\u00E9rt - ',
		cta: 'TAKAR\u00CDTSON MEG MOST',
		url: '"https://checkout.autodesk.com/hu-HU?priceIds=33791%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//TR-TR
	'ACDIST_tr-TR_1-year': {
		copy: '3 AutoCAD aboneli\u011Fini %15\'e varan indirimle al\u0131n - ',
		cta: 'TASARRUF ET',
		url: 'https://store.autodesk.com/store/adsk/tr_TR/buy/productID.5774389300/quantity.3/OfferID.63552039920/Currency.TRY',
		qty: ['2']
	},
	'ACDIST_tr-TR_3-year': {
		copy: '3 AutoCAD aboneli\u011Fini %15\'e varan indirimle al\u0131n - ',
		cta: 'TASARRUF ET',
		url: 'https://store.autodesk.com/store/adsk/tr_TR/buy/productID.5774389400/quantity.3/OfferID.63552039920/Currency.TRY',
		qty: ['2']
	},
	'ACDLT_tr-TR_1-year': {
		copy: '4 abonelik fiyat\u0131na 5 abonelik edinin - ',
		cta: 'TASARRUF ET',
		url: 'https://store.autodesk.com/store/adsk/tr_TR/buy/productID.5774389600/quantity.5/OfferID.63552040120/Currency.TRY',
		qty: ['2', '3', '4']
	},
	'ACDLT_tr-TR_3-year': {
		copy: '4 abonelik fiyat\u0131na 5 abonelik edinin - ',
		cta: 'TASARRUF ET',
		url: 'https://store.autodesk.com/store/adsk/tr_TR/buy/productID.5774389700/quantity.5/OfferID.63552040120/Currency.TRY',
		qty: ['2', '3', '4']
	},
	//DE-CH
	'ACDIST_de-CH_1-year': {
		copy: '15 % Rabatt auf drei AutoCAD-Abonnements - ',
		cta: 'Jetzt sparen',
		url: '"https://checkout.autodesk.com/de-CH?priceIds=30386%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_de-CH_3-year': {
		copy: '15 % Rabatt auf drei AutoCAD-Abonnements - ',
		cta: 'Jetzt sparen',
		url: '"https://checkout.autodesk.com/de-CH?priceIds=33300%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_de-CH_1-year': {
		copy: 'Holen Sie sich 5 Abonnements zum Preis von 4 - ',
		cta: 'Jetzt sparen',
		url: '"https://checkout.autodesk.com/de-CH?priceIds=30421%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_de-CH_3-year': {
		copy: 'Holen Sie sich 5 Abonnements zum Preis von 4 - ',
		cta: 'Jetzt sparen',
		url: '"https://checkout.autodesk.com/de-CH?priceIds=33824%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//FR-CH
	'ACDIST_fr-CH_1-year': {
		copy: '\u00C9conomisez 15 % sur 3 abonnements AutoCAD - ',
		cta: 'J\u00B4en profite',
		url: '"https://checkout.autodesk.com/fr-CH?priceIds=30386%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_fr-CH_3-year': {
		copy: '\u00C9conomisez 15 % sur 3 abonnements AutoCAD - ',
		cta: 'J\u00B4en profite',
		url: '"https://checkout.autodesk.com/fr-CH?priceIds=33300%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_fr-CH_1-year': {
		copy: '5 abonnements pour le prix de 4 - ',
		cta: 'J\u00B4en profite',
		url: '"https://checkout.autodesk.com/fr-CH?priceIds=30421%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_fr-CH_3-year': {
		copy: '5 abonnements pour le prix de 4 - ',
		cta: 'J\u00B4en profite',
		url: '"https://checkout.autodesk.com/fr-CH?priceIds=33824%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	//IT-CH
	'ACDIST_it-CH_1-year': {
		copy: 'Ottieni il 15% di sconto su 3 abbonamenti ad AutoCAD - ',
		cta: 'Risparmia Ora',
		url: '"https://checkout.autodesk.com/it-CH?priceIds=30386%5Bqty:3%5D&promoCodes=3PACK1YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDIST_it-CH_3-year': {
		copy: 'Ottieni il 15% di sconto su 3 abbonamenti ad AutoCAD - ',
		cta: 'Risparmia Ora',
		url: '"https://checkout.autodesk.com/it-CH?priceIds=33300%5Bqty:3%5D&promoCodes=3PACK3YEMEA&plc=ACDIST"',
		qty: ['2']
	},
	'ACDLT_it-CH_1-year': {
		copy: '5 abbonamenti al prezzo di 4 - ',
		cta: 'Risparmia Ora',
		url: '"https://checkout.autodesk.com/it-CH?priceIds=30421%5Bqty:5%5D&promoCodes=LT5PACK1YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	},
	'ACDLT_it-CH_3-year': {
		copy: '5 abbonamenti al prezzo di 4 - ',
		cta: 'Risparmia Ora',
		url: '"https://checkout.autodesk.com/it-CH?priceIds=33824%5Bqty:5%5D&promoCodes=LT5PACK3YEMEA&plc=ACDLT"',
		qty: ['2', '3', '4']
	}
};
usi_app.deals_copy = {
	"en": {
		"head": "SAVE {{price}} NOW!",
		"subhead": "Special online deal: Save 25% on a 3-year subscription of {{name}}",
		"cta": "SAVE NOW",
		"close": "No, thanks"
	},
	"fr": {
		"head": "\u00C9CONOMISEZ {{price}} MAINTENANT!",
		"subhead": "Offre sp\u00E9ciale en ligne: \u00E9conomisez 25% sur un abonnement de 3 ans \u00E0 {{name}}",
		"cta": "\u00C9CONOMISEZ MAINTENANT",
		"close": "Non merci"
	},
	"es": {
		"head": "AHORRA {{price}}",
		"subhead": "Oferta especial en Linea: Ahorre 25% en una suscripci\u00F3n de 3 a\u00F1os de {{name}}",
		"cta": "AHORRA HOY",
		"close": "No, gracias"
	},
	"en_special": {
		"head": "Special offer!",
		"subhead": "Upgrade to a {{type}} subscription and save {{discount}}. Limited time only.",
		"cta": "SAVE NOW",
		"close": "No, thanks",
		"terms": "Terms & Conditions"
	},
	"en_25": {
		"head": "Special offer!",
		"subhead": "Upgrade to a {{type}} subscription and save 25%. Limited time only.",
		"cta": "SAVE NOW",
		"close": "No, thanks",
		"terms": "Terms & Conditions"
	},
	"en_20": {
		"head": "Special offer!",
		"subhead": "Upgrade to a 3-year plan and save 20% instantly. Don\u2019t miss this one-time offer.",
		"cta": "SAVE NOW",
		"close": "No, thanks",
		"terms": "Terms & Conditions"
	},
	"au_20": {
		"head": "Special offer!",
		"subhead": "Don't miss 20% in savings. Upgrade to a Revit 3-year plan and save $1,933 AUD instantly.",
		"cta": "SAVE NOW",
		"close": "No, thanks",
		"terms": "Terms & Conditions"
	},
	"nz_20": {
		"head": "Special offer!",
		"subhead": "Don't miss 20% in savings. Upgrade to a Revit 3-year plan and save $2,010 NZD instantly.",
		"cta": "SAVE NOW",
		"close": "No, thanks",
		"terms": "Terms & Conditions"
	},
	"en_lto": {
		"head": "Limited Time Offer",
		"subhead": "Upgrade to a {{type}} subscription and save up to 25%*.",
		"cta": "SAVE NOW",
		"close": "No, thanks",
		"terms": "Terms & Conditions"
	},
	"kr": {
		"head": "\uAE30\uAC04 \uD55C\uC815 \uD560\uC778",
		"subhead": "3\uB144 \uC11C\uBE0C\uC2A4\uD06C\uB9BD\uC158\uC73C\uB85C 20% \uD560\uC778\uC744 \uBC1B\uC73C\uC138\uC694.",
		"cta": "\uC9C0\uAE08 \uD560\uC778 \uBC1B\uAE30",
		"close": "\uC544\uB2C8\uC694, \uAD1C\uCC2E\uC2B5\uB2C8\uB2E4.",
		"terms": "\uC774\uC6A9 \uC57D\uAD00 \uBCF4\uAE30"
	},
	"zh": {
		"head": "<span style=\"font-size: 0.75em;\">\u9650\u65F6\u7279\u60E0</span>",
		"subhead": "\u5347\u7EA7\u81F3\u4E09\u5E74\u671F\u6709\u673A\u4F1A\u7ACB\u4EAB8\u6298*\u4F18\u60E0",
		"cta": "\u7ACB\u5373\u70B9\u51FB\u8BA2\u8D2D",
		"close": "\u4E0D\u9700\u8981\uFF0C\u8C22\u8C22",
		"terms": "\u8BF7\u53C2\u89C1\u6761\u6B3E\u548C\u6761\u4EF6"
	}
};
usi_app.deals = {
	"en-US": {
		"ACDLT": {
			"name": "AutoCAD LT",
			"price": "$280",
			"link": "https://checkout.autodesk.com/en-US?priceIds=24147[qty:1]&promoCodes=LIGHTNING3Y25&plc=ACDLT",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.en
		},
		"ACDIST": {
			"name": "AutoCAD",
			"price": "$1,140",
			"link": "https://checkout.autodesk.com/en-US?priceIds=24042[qty:1]&promoCodes=LIGHTNING3Y25&plc=ACDIST",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.en
		},
		"MAYA": {
			"name": "Maya",
			"price": "$1,090",
			"link": "https://checkout.autodesk.com/en-US?priceIds=24567[qty:1]&promoCodes=LIGHTNING3Y25&plc=MAYA",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.en
		},
		"3DSMAX": {
			"name": "3ds Max",
			"price": "$1,090",
			"link": "https://checkout.autodesk.com/en-US?priceIds=23772[qty:1]&promoCodes=LIGHTNING3Y25&plc=3DSMAX",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.en
		}
	},
	"fr-CA": {
		"ACDLT": {
			"name": "AutoCAD LT",
			"price": "$365.00",
			"link": "https://checkout.autodesk.com/fr-CA?priceIds=24133[qty:1]&promoCodes=LIGHTNING3Y25&plc=ACDLT",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.fr
		},
		"ACDIST": {
			"name": "AutoCAD",
			"price": "$1,480",
			"link": "https://checkout.autodesk.com/fr-CA?priceIds=24000[qty:1]&promoCodes=LIGHTNING3Y25&plc=ACDIST",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.fr
		},
		"MAYA": {
			"name": "Maya",
			"price": "$1,420",
			"link": "https://checkout.autodesk.com/fr-CA?priceIds=24525[qty:1]&promoCodes=LIGHTNING3Y25&plc=MAYA",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.fr
		},
		"3DSMAX": {
			"name": "3ds Max",
			"price": "$1,420",
			"link": "https://checkout.autodesk.com/fr-CA?priceIds=23784[qty:1]&promoCodes=LIGHTNING3Y25&plc=3DSMAX",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.fr
		}
	},
	"en-CA": {
		"ACDLT": {
			"name": "AutoCAD LT",
			"price": "$365.00",
			"link": "https://checkout.autodesk.com/en-CA?priceIds=24133[qty:1]&promoCodes=LIGHTNING3Y25&plc=ACDLT",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.en
		},
		"ACDIST": {
			"name": "AutoCAD",
			"price": "$1,480",
			"link": "https://checkout.autodesk.com/en-CA?priceIds=24000[qty:1]&promoCodes=LIGHTNING3Y25&plc=ACDIST",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.en
		},
		"MAYA": {
			"name": "Maya",
			"price": "$1,420",
			"link": "https://checkout.autodesk.com/en-CA?priceIds=24525[qty:1]&promoCodes=LIGHTNING3Y25&plc=MAYA",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.en
		},
		"3DSMAX": {
			"name": "3ds Max",
			"price": "$1,420",
			"link": "https://checkout.autodesk.com/en-CA?priceIds=23784[qty:1]&promoCodes=LIGHTNING3Y25&plc=3DSMAX",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.en
		}
	},
	"es-AR": {
		"ACDLT": {
			"name": "AutoCAD LT",
			"price": "25%",
			"link": "",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.es
		},
		"ACDIST": {
			"name": "AutoCAD",
			"price": "25%",
			"link": "",
			"start": "2020-08-18",
			"end": "2020-08-21",
			"copy": usi_app.deals_copy.es
		}
	},
	"en-AU": {
		"RVT": {
			"name": "Revit",
			"price": "",
			"link": "https://checkout.autodesk.com/en-AU?priceIds=27108[qty:1]&promoCodes=LIGHTNINGRVT20&plc=RVT",
			"terms": "https://www.autodesk.com.au/campaigns/upsell-offer-terms-conditions",
			"copy": usi_app.deals_copy.au_20,
			"upsell_pid": "27108",
			"orig_pid": "27107",
			"modal_pid": "27108"
		}
	},
	"en-NZ": {
		"RVT": {
			"name": "Revit",
			"price": "",
			"link": "https://commerce.autodesk.com/en-NZ?pid=5537281700&offerid=63227835410",
			"terms": "https://www.autodesk.co.nz/campaigns/upsell-offer-terms-conditions",
			"copy": usi_app.deals_copy.nz_20,
			"upsell_pid": "5537281700",
			"orig_pid": "5342419400",
			"modal_pid": "5342419500"
		}
	},
	"ko-KR": {
		"ACDLT": {
			"name": "AutoCAD LT",
			"price": "",
			"link": "http://store.autodesk.co.kr/store/adskkr/ko_KR/buy/productID.5467231600/quantity.1/OfferID.63227865810/Currency.KRW",
			"terms": "https://www.autodesk.co.kr/campaigns/upsell-offer-terms-conditions",
			"copy": usi_app.deals_copy.kr,
			"upsell_pid": "5467231600",
			"orig_pid": "334570800",
			"modal_pid": "334571000"
		}
	},
	"en-SG": {
		"3DSMAX": {
			"name": "3ds Max",
			"price": "",
			"link": "https://commerce.autodesk.com/en-SG?pid=5433761700&offerid=62997195410",
			"terms": "https://www.autodesk.com.sg/campaigns/upsell-offer-terms-conditions",
			"start": "2020-08-24 9:00:00",
			"end": "2020-09-03 9:00:00",
			"copy": usi_app.deals_copy.en_25
		},
		"MAYA": {
			"name": "Maya",
			"price": "",
			"link": "https://commerce.autodesk.com/en-SG?pid=5433762300&offerid=62997195410",
			"terms": "https://www.autodesk.com.sg/campaigns/upsell-offer-terms-conditions",
			"start": "2020-08-24 9:00:00",
			"end": "2020-09-03 9:00:00",
			"copy": usi_app.deals_copy.en_25
		}
	},
	"en-MY": {
		"3DSMAX": {
			"name": "3ds Max",
			"price": "",
			"link": "https://commerce.autodesk.com/en-MY?pid=5433761700&offerid=62997195410",
			"terms": "https://asean.autodesk.com/campaigns/upsell-offer-terms-conditions",
			"start": "2020-08-24 9:00:00",
			"end": "2020-09-03 9:00:00",
			"copy": usi_app.deals_copy.en_25
		},
		"MAYA": {
			"name": "Maya",
			"price": "",
			"link": "https://commerce.autodesk.com/en-MY?pid=5433762300&offerid=62997195410",
			"terms": "https://asean.autodesk.com/campaigns/upsell-offer-terms-conditions",
			"start": "2020-08-24 9:00:00",
			"end": "2020-09-03 9:00:00",
			"copy": usi_app.deals_copy.en_25
		}
	},
	"zh-CN": {
		"3DSMAX": {
			"name": "3ds Max",
			"price": "",
			"link": "http://store.autodesk.com.cn/store/adskcn/zh_CN/buy/productID.5433334400/quantity.1/OfferID.62996167810/Currency.CNY/",
			"terms": "https://www.autodesk.com.cn/campaigns/upsell-offer-terms-conditions",
			"start": "2020-08-24 9:00:00",
			"end": "2020-09-03 9:00:00",
			"copy": usi_app.deals_copy.zh
		},
		"MAYA": {
			"name": "Maya",
			"price": "",
			"link": "http://store.autodesk.com.cn/store/adskcn/zh_CN/buy/productID.5433334700/quantity.1/OfferID.62996167810/Currency.CNY/",
			"terms": "https://www.autodesk.com.cn/campaigns/upsell-offer-terms-conditions",
			"start": "2020-08-24 9:00:00",
			"end": "2020-09-03 9:00:00",
			"copy": usi_app.deals_copy.zh
		}
	},
	"en-IN": {
		"3DSMAX": {
			"name": "3ds Max",
			"price": "",
			"link": "http://store.autodesk.com/store/adskin/en_IN/buy/productID.5433335100/quantity.1/OfferID.62996168010/Currency.INR/",
			"terms": "https://www.autodesk.in/campaigns/upsell-offer-terms-conditions",
			"start": "2020-08-24 11:30:00",
			"end": "2020-09-03 11:30:00",
			"copy": usi_app.deals_copy.en_lto
		},
		"MAYA": {
			"name": "Maya",
			"price": "",
			"link": "http://store.autodesk.com/store/adskin/en_IN/buy/productID.5433335400/quantity.1/OfferID.62996168010/Currency.INR/",
			"terms": "https://www.autodesk.in/campaigns/upsell-offer-terms-conditions",
			"start": "2020-08-24 11:30:00",
			"end": "2020-09-03 11:30:00",
			"copy": usi_app.deals_copy.en_lto
		}
	}
};
usi_app.email_info = {
	"es-AR": {
		"link": usi_app.aff_links["es-AR"] + "?url=" + usi_app.encode_link("/store?Action=DisplayPage&Locale=es_AR&SiteID=adsk&id=QuickBuyCartPage&mktvar002=afc_la_usi_email&Currency=USD"),
		"from_name": "Equipo de atenci\u00F3n al cliente de Autodesk",
		"optin_head": "\u00BFTienes Prisa?",
		"optin_desc": "Quiero recibir por email el contenido de mi carrito.",
		"optin_ok": "Enviar ahora",
		"tt_head": "Cree. Gestione. Colabore.<br />Todo en uno.",
		"tt_btn": "Compre ahora"
	},
	"en-GB": {
		"link": usi_app.aff_links["en-GB"] + "?url=" + usi_app.encode_link("/en-GB?mktvar002=afc_gb_usi_email"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"en-UK": {
		"link": usi_app.aff_links["en-UK"] + "?url=" + usi_app.encode_link("/en-GB?mktvar002=afc_gb_usi_email"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"en-SE": {
		"link": usi_app.aff_links["en-SE"] + "?url=" + usi_app.encode_link("/store?Action=DisplayPage&Locale=en-SE&SiteID=adsk&id=QuickBuyCartPage&mktvar002=afc_ae_usi_email&usi_var002=afc_ae_usi_email"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"en-MY": {
		"link": usi_app.aff_links["en-MY"] + "?url=" + usi_app.encode_link("/store?Action=DisplayPage&Locale=en_MY&SiteID=adskjp&id=QuickBuyCartPage&mktvar002=afc_my_usi_email"),
		"link2": usi_app.aff_links["en-MY"] + "?url=" + encodeURIComponent("https://asean.autodesk.com/benefits/multi-year-subscriptions?mktvar002=afc_my_upsellit_cartabandonmentemail"),
		"link3": usi_app.aff_links["en-MY"] + "?url=" + encodeURIComponent("https://asean.autodesk.com/benefits/buy-online-securely?mktvar002=afc_my_upsellit_cartabandonmentemail"),
		"link4": usi_app.aff_links["en-MY"] + "?url=" + encodeURIComponent("https://asean.autodesk.com/benefits/refund-policy?mktvar002=afc_my_upsellit_cartabandonmentemail"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"en-MY": {
		"link": usi_app.aff_links["en-MY"] + "?url=" + usi_app.encode_link("/store?Action=DisplayPage&Locale=en_MY&SiteID=adskjp&id=QuickBuyCartPage&mktvar002=afc_my_usi_email&usi_var002=afc_my_usi_email"),
		"link2": usi_app.aff_links["en-MY"] + "?url=" + encodeURIComponent("https://asean.autodesk.com/benefits/multi-year-subscriptions?mktvar002=afc_my_upsellit_cartabandonmentemail"),
		"link3": usi_app.aff_links["en-MY"] + "?url=" + encodeURIComponent("https://asean.autodesk.com/benefits/buy-online-securely?mktvar002=afc_my_upsellit_cartabandonmentemail"),
		"link4": usi_app.aff_links["en-MY"] + "?url=" + encodeURIComponent("https://asean.autodesk.com/benefits/refund-policy?mktvar002=afc_my_upsellit_cartabandonmentemail"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"en-SG": {
		"link": usi_app.aff_links["en-SG"] + "?url=" + usi_app.encode_link("/en-SG?mktvar002=afc_sg_usi_email"),
		"link2": usi_app.aff_links["en-SG"] + "?url=" + encodeURIComponent("https://www.autodesk.com.sg/benefits/multi-year-subscriptions?mktvar002=afc_sg_upsellit_cartabandonmentemail"),
		"link3": usi_app.aff_links["en-SG"] + "?url=" + encodeURIComponent("https://www.autodesk.com.sg/benefits/buy-online-securely?mktvar002=afc_sg_upsellit_cartabandonmentemail"),
		"link4": usi_app.aff_links["en-SG"] + "?url=" + encodeURIComponent("https://www.autodesk.com.sg/benefits/refund-policy?mktvar002=afc_sg_upsellit_cartabandonmentemail"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"en-SG": {
		"link": usi_app.aff_links["en-SG"] + "?url=" + usi_app.encode_link("/store?Action=DisplayPage&Locale=en_SG&SiteID=adsk&id=QuickBuyCartPage&mktvar002=afc_sg_usi_email"),
		"link2": usi_app.aff_links["en-SG"] + "?url=" + encodeURIComponent("https://www.autodesk.com.sg/benefits/multi-year-subscriptions?mktvar002=afc_sg_upsellit_cartabandonmentemail"),
		"link3": usi_app.aff_links["en-SG"] + "?url=" + encodeURIComponent("https://www.autodesk.com.sg/benefits/buy-online-securely?mktvar002=afc_sg_upsellit_cartabandonmentemail"),
		"link4": usi_app.aff_links["en-SG"] + "?url=" + encodeURIComponent("https://www.autodesk.com.sg/benefits/refund-policy?mktvar002=afc_sg_upsellit_cartabandonmentemail"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"en-NZ": {
		"link": usi_app.aff_links["en-NZ"] + "?url=" + usi_app.encode_link("/store?Action=DisplayPage&Locale=en_NZ&SiteID=adsk&id=QuickBuyCartPage&mktvar002=afc_nz_usi_email"),
		"link2": usi_app.aff_links["en-NZ"] + "?url=" + encodeURIComponent("https://www.autodesk.co.nz/benefits/multi-year-subscriptions?mktvar002=afc_nz_upsellit_cartabandonmentemail"),
		"link3": usi_app.aff_links["en-NZ"] + "?url=" + encodeURIComponent("https://www.autodesk.co.nz/benefits/buy-online-securely?mktvar002=afc_nz_upsellit_cartabandonmentemail"),
		"link4": usi_app.aff_links["en-NZ"] + "?url=" + encodeURIComponent("https://www.autodesk.co.nz/benefits/refund-policy?mktvar002=afc_nz_upsellit_cartabandonmentemail"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"en-AU": {
		"link": usi_app.aff_links["en-AU"] + "?url=" + usi_app.encode_link("/en-AU?mktvar002=afc_aus_usi_email&usi_var002=afc_aus_usi_email"),
		"link2": usi_app.aff_links["en-AU"] + "?url=" + encodeURIComponent("https://www.autodesk.com.au/benefits/multi-year-subscriptions?mktvar002=afc_aus_upsellit_cartabandonmentemail"),
		"link3": usi_app.aff_links["en-AU"] + "?url=" + encodeURIComponent("https://www.autodesk.com.au/benefits/buy-online-securely?mktvar002=afc_aus_upsellit_cartabandonmentemail"),
		"link4": usi_app.aff_links["en-AU"] + "?url=" + encodeURIComponent("https://www.autodesk.com.au/benefits/refund-policy?mktvar002=afc_aus_upsellit_cartabandonmentemail"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"en-AU": {
		"link": usi_app.aff_links["en-AU"] + "?url=" + usi_app.encode_link("/store?Action=DisplayPage&Locale=en_AU&SiteID=adsk&id=QuickBuyCartPage&mktvar002=afc_aus_usi_email&usi_var002=afc_aus_usi_email"),
		"link2": usi_app.aff_links["en-AU"] + "?url=" + encodeURIComponent("https://www.autodesk.com.au/benefits/multi-year-subscriptions?mktvar002=afc_aus_upsellit_cartabandonmentemail"),
		"link3": usi_app.aff_links["en-AU"] + "?url=" + encodeURIComponent("https://www.autodesk.com.au/benefits/buy-online-securely?mktvar002=afc_aus_upsellit_cartabandonmentemail"),
		"link4": usi_app.aff_links["en-AU"] + "?url=" + encodeURIComponent("https://www.autodesk.com.au/benefits/refund-policy?mktvar002=afc_aus_upsellit_cartabandonmentemail"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"en-EU": {
		"link": usi_app.aff_links["en-EU"] + "?url=" + usi_app.encode_link("/europe?mktvar002=afc_eu_usi_email"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"en-CA": {
		"link": usi_app.aff_links["en-CA"] + "?url=" + usi_app.encode_link("/en-CA?mktvar002=afc_ca_usi_email"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"en-US": {
		"link": usi_app.aff_links["en-US"] + "?url=" + usi_app.encode_link("/en-US?mktvar002=afc_us_usi_email"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"en-IN": {
		"link": usi_app.aff_links["en-IN"] + "?url=" + usi_app.encode_link("/store?Action=DisplayPage&Locale=en_IN&SiteID=adskin&id=QuickBuyCartPage&mktvar002=afc_in_usi_email"),
		"link2": usi_app.aff_links["en-IN"] + "?url=" + encodeURIComponent("https://www.autodesk.in/benefits/multi-year-subscriptions?mktvar002=afc_in_upsellit_cartabandonmentemail"),
		"link3": usi_app.aff_links["en-IN"] + "?url=" + encodeURIComponent("https://www.autodesk.in/benefits/buy-online-securely?mktvar002=afc_in_upsellit_cartabandonmentemail"),
		"link4": usi_app.aff_links["en-IN"] + "?url=" + encodeURIComponent("https://www.autodesk.in/benefits/refund-policy?mktvar002=afc_in_upsellit_cartabandonmentemail"),
		"from_name": "Autodesk Support",
		"optin_head": "In A Hurry?",
		"optin_desc": "Please email me the contents of my cart.",
		"optin_ok": "OK",
		"tt_head": "Create. Manage. Collaborate.<br />All in one place.",
		"tt_btn": "CONTINUE CHECKOUT"
	},
	"es-MX": {
		"link": usi_app.aff_links["es-MX"] + "?url=" + usi_app.encode_link("/es-MX?mktvar002=afc_mx_usi_email"),
		"from_name": "Equipo de atenci\u00F3n al cliente de Autodesk",
		"optin_head": "\u00BFTienes Prisa?",
		"optin_desc": "Quiero recibir por email el contenido de mi carrito.",
		"optin_ok": "Enviar ahora",
		"tt_head": "Cree. Gestione. Colabore. <br />Todo en uno.",
		"tt_btn": "COMPRE AHORA"
	},
	"es-MX": {
		"link": usi_app.aff_links["es-MX"] + "?url=" + usi_app.encode_link("/store?Action=DisplayPage&Locale=es_MX&SiteID=adsk&id=QuickBuyCartPage&mktvar002=afc_mx_usi_email"),
		"from_name": "Equipo de atenci\u00F3n al cliente de Autodesk",
		"optin_head": "\u00BFTienes Prisa?",
		"optin_desc": "Quiero recibir por email el contenido de mi carrito.",
		"optin_ok": "Enviar ahora",
		"tt_head": "Cree. Gestione. Colabore. <br />Todo en uno.",
		"tt_btn": "COMPRE AHORA"
	},
	"es-ES": {
		"link": usi_app.aff_links["es-ES"] + "?url=" + usi_app.encode_link("/es-ES?mktvar002=afc_es_usi_email"),
		"from_name": "Autodesk tienda online",
		"optin_head": "\u00BFTienes Prisa?",
		"optin_desc": "Quiero recibir por email el contenido de mi carrito.",
		"optin_ok": "Enviar ahora",
		"tt_head": "Cree. Gestione. Colabore. <br />Todo en uno.",
		"tt_btn": "COMPRE AHORA"
	},
	"fr-FR": {
		"link": usi_app.aff_links["fr-FR"] + "?url=" + usi_app.encode_link("/fr-FR?mktvar002=afc_fr_usi_email"),
		"from_name": "Autodesk Boutique en ligne",
		"optin_head": "Vous \u00EAtes press\u00E9?",
		"optin_desc": "Nous pouvons vous envoyer le contenu de votre panier par e-mail.",
		"optin_ok": "OK",
		"tt_head": "Cr\u00E9er. G\u00E9rer. Collaborer.<br /> De mani\u00E8re centralis\u00E9e",
		"tt_btn": "CONTINUER LA COMMANDE"
	},
	"fr-CH": {
		"link": usi_app.aff_links["fr-CH"] + "?url=" + usi_app.encode_link("/fr-CH?mktvar002=afc_frch_usi_email"),
		"from_name": "Autodesk Boutique en ligne",
		"optin_head": "Vous \u00EAtes press\u00E9?",
		"optin_desc": "Nous pouvons vous envoyer le contenu de votre panier par e-mail.",
		"optin_ok": "OK",
		"tt_head": "Cr\u00E9er. G\u00E9rer. Collaborer.<br /> De mani\u00E8re centralis\u00E9e",
		"tt_btn": "CONTINUER LA COMMANDE"
	},
	"fr-CA": {
		"link": usi_app.aff_links["fr-CA"] + "?url=" + usi_app.encode_link("/fr-CA?mktvar002=afc_frca_usi_email"),
		"from_name": "Autodesk Boutique en ligne",
		"optin_head": "Vous \u00EAtes press\u00E9?",
		"optin_desc": "Nous pouvons vous envoyer le contenu de votre panier par e-mail.",
		"optin_ok": "OK",
		"tt_head": "Cr\u00E9er. G\u00E9rer. Collaborer.<br /> De mani\u00E8re centralis\u00E9e",
		"tt_btn": "CONTINUER LA COMMANDE"
	},
	"it-IT": {
		"link": usi_app.aff_links["it-IT"] + "?url=" + usi_app.encode_link("/it-IT?mktvar002=afc_it_usi_email"),
		"from_name": "Autodesk negozio online",
		"optin_head": "Hai fretta?",
		"optin_desc": "Inviami il contenuto del carrello tramite e-mail.",
		"optin_ok": "OK",
		"tt_head": "Creare. Amministrare. Collaborare.<br />Tutto nello stesso posto",
		"tt_btn": "PROCEDI ALL\u2019ACQUISTO"
	},
	"it-CH": {
		"link": usi_app.aff_links["it-CH"] + "?url=" + usi_app.encode_link("/it-CH?mktvar002=afc_itch_usi_email"),
		"from_name": "Autodesk negozio online",
		"optin_head": "Hai fretta?",
		"optin_desc": "Inviami il contenuto del carrello tramite e-mail.",
		"optin_ok": "OK",
		"tt_head": "Creare. Amministrare. Collaborare.<br />Tutto nello stesso posto",
		"tt_btn": "PROCEDI ALL\u2019ACQUISTO"
	},
	"pt-BR": {
		"link": usi_app.aff_links["pt-BR"] + "?url=" + usi_app.encode_link("/store?Action=DisplayPage&Locale=pt_BR&SiteID=adskbr&id=QuickBuyCartPage&mktvar002=afc_br_usi_email"),
		"from_name": "Autodesk Support",
		"optin_head": "Precisa de mais tempo?",
		"optin_desc": "Envie os itens do carrinho para o seu email.",
		"optin_ok": "OK",
		"tt_head": "Crie. Gerencie. Colabore. <br />Tudo em um s\u00F3 lugar.",
		"tt_btn": "PROSSIGA CHECKOUT"
	},
	"pt-PT": {
		"link": usi_app.aff_links["pt-PT"] + "?url=" + usi_app.encode_link("/pt-PT?mktvar002=afc_pt_usi_email"),
		"from_name": "Suporte Autodesk",
		"optin_head": "Est\u00E1 com pressa?",
		"optin_desc": "Por favor, enviem-me por e-mail o conte\u00FAdo do meu carrinho.",
		"optin_ok": "OK",
		"tt_head": "Crie. Gerencie. Colabore. <br />Tudo em um s\u00F3 lugar.",
		"tt_btn": "PROSSIGA CHECKOUT"
	},
	"pl-PL": {
		"link": usi_app.aff_links["pl-PL"] + "?url=" + usi_app.encode_link("/pl-PL?mktvar002=afc_pl_usi_email"),
		"from_name": "Pomoc techniczna Autodesk",
		"optin_head": "\u015Apieszysz si\u0119?",
		"optin_desc": "Prosz\u0119 wys\u0142a\u0107 mi zawarto\u015B\u0107 koszyka w wiadomo\u015Bci e-mail.",
		"optin_ok": "OK",
		"tt_head": "Tw\u00F3rz. Zarz\u0105dzaj. Wsp\u00F3\u0142pracuj. <br />Wszystko w jednym miejscu.",
		"tt_btn": "KONTYNUUJ ZAM\u00D3WIENIE"
	},
	"de-DE": {
		"link": usi_app.aff_links["de-DE"] + "?url=" + usi_app.encode_link("/de-DE?mktvar002=afc_de_usi_email"),
		"from_name": "Autodesk Online-Shop",
		"optin_head": "Ben\u00F6tigen Sie mehr Zeit?",
		"optin_desc": "Bitte schicken Sie mir den Inhalt meines Einkaufswagens per E-Mail.",
		"optin_ok": "OK",
		"tt_head": "Gemeinsam gestalten und alles <br />zentral verwalten",
		"tt_btn": "MIT KAUF FORTFAHREN"
	},
	"de-CH": {
		"link": usi_app.aff_links["de-CH"] + "?url=" + usi_app.encode_link("/de-CH?mktvar002=afc_de_usi_email"),
		"from_name": "Autodesk Online-Shop",
		"optin_head": "Ben\u00F6tigen Sie mehr Zeit?",
		"optin_desc": "Bitte schicken Sie mir den Inhalt meines Einkaufswagens per E-Mail.",
		"optin_ok": "OK",
		"tt_head": "Gemeinsam gestalten und alles <br />zentral verwalten",
		"tt_btn": "MIT KAUF FORTFAHREN"
	},
	"no-NO": {
		"link": usi_app.aff_links["no-NO"] + "?url=" + usi_app.encode_link("/no-NO?mktvar002=afc_no_usi_email"),
		"from_name": "Autodesk-st\u00F8tte",
		"optin_head": "Har det travelt?",
		"optin_desc": "Send meg en e-post om innholdet i handlevognen min.",
		"optin_ok": "OK",
		"tt_head": "SKAP. ADMINISTRER. SAMARBEID.<br /> ALT P\u00C5 ETT STED.",
		"tt_btn": "FORTSETT TIL KASSEN"
	},
	"nl-NL": {
		"link": usi_app.aff_links["nl-NL"] + "?url=" + usi_app.encode_link("/nl-NL?mktvar002=afc_nl_usi_email"),
		"from_name": "Autodesk-helpdesk",
		"optin_head": "Heeft u haast?",
		"optin_desc": "E-mail mij de inhoud van mijn winkelwagentje.",
		"optin_ok": "OK",
		"tt_head": "Samen ontwerpen en alles <br />centraal beheren",
		"tt_btn": "BESTELLING AFRONDEN"
	},
	"nl-BE": {
		"link": usi_app.aff_links["nl-BE"] + "?url=" + usi_app.encode_link("/nl-BE?mktvar002=afc_nlbe_usi_email"),
		"from_name": "Autodesk-helpdesk",
		"optin_head": "Heeft u haast?",
		"optin_desc": "E-mail mij de inhoud van mijn winkelwagentje.",
		"optin_ok": "OK",
		"tt_head": "Samen ontwerpen en alles <br />centraal beheren",
		"tt_btn": "BESTELLING AFRONDEN"
	},
	"fr-BE": {
		"link": usi_app.aff_links["fr-BE"] + "?url=" + usi_app.encode_link("/fr-BE?mktvar002=afc_frbe_usi_email"),
		"from_name": "Autodesk Boutique en ligne",
		"optin_head": "Vous \u00EAtes press\u00E9?",
		"optin_desc": "Nous pouvons vous envoyer le contenu de votre panier par e-mail.",
		"optin_ok": "OK",
		"tt_head": "Cr\u00E9er. G\u00E9rer. Collaborer.<br /> De mani\u00E8re centralis\u00E9e",
		"tt_btn": "CONTINUER LA COMMANDE"
	},
	"ru-RU": {
		"link": usi_app.aff_links["ru-RU"] + "?url=" + usi_app.encode_link("/ru-RU?mktvar002=afc_ru_usi_email"),
		"from_name": "\u0421\u043B\u0443\u0436\u0431\u0430 \u043F\u043E\u0434\u0434\u0435\u0440\u0436\u043A\u0438 \u043A\u043B\u0438\u0435\u043D\u0442\u043E\u0432 Autodesk",
		"optin_head": "\u041D\u0443\u0436\u043D\u043E \u0431\u043E\u043B\u044C\u0448\u0435 \u0432\u0440\u0435\u043C\u0435\u043D\u0438?",
		"optin_desc": "\u041F\u043E\u0436\u0430\u043B\u0443\u0439\u0441\u0442\u0430 \u043F\u043E\u0448\u043B\u0438\u0442\u0435 \u043C\u043D\u0435 \u0441\u043E\u0434\u0435\u0440\u0436\u0438\u043C\u043E\u0435 \u043C\u043E\u0435\u0439 \u043A\u043E\u0440\u0437\u0438\u043D\u044B",
		"optin_ok": "\u0414\u0410",
		"tt_head": "\u0421\u041E\u0417\u0414\u0410\u0412\u0410\u0419\u0422\u0415. \u0423\u041F\u0420\u0410\u0412\u041B\u042F\u0419\u0422\u0415. \u041E\u0411\u042A\u0415\u0414\u0418\u041D\u042F\u0419\u0422\u0415\u0421\u042C. <br />\u0412\u0421\u0415 \u0412 \u041E\u0414\u041D\u041E\u041C \u041C\u0415\u0421\u0422\u0415.",
		"tt_btn": "\u041F\u0420\u041E\u0414\u041E\u041B\u0416\u0418\u0422\u042C \u041F\u041E\u041A\u0423\u041F\u041A\u0418"
	},
	"tr-TR": {
		"link": usi_app.aff_links["tr-TR"] + "?url=" + usi_app.encode_link("/store?Action=DisplayPage&Locale=tr_TR&SiteID=adsk&id=QuickBuyCartPage&mktvar002=afc_tr_usi_email"),
		"from_name": "Autodesk m\u00FC\u015Fteri hizmetleri ekibi",
		"optin_head": "Daha fazla zamana ihtiyac\u0131m\u0131z var?",
		"optin_desc": "Sepetin i\u00E7eri\u011Finideki ileri e-postaya g\u00F6nderin l\u00FCtfen",
		"optin_ok": "Tamam",
		"tt_head": "YARATIN. Y\u00D6NETIN. BIRLIKTE \u00C7ALI\u015EIN. <br />T\u00DCM\u00DC SADECE BIR YERDE.",
		"tt_btn": "\u00D6DEMEYE DEVAM"
	},
	"sv-SE": {
		"link": usi_app.aff_links["sv-SE"] + "?url=" + usi_app.encode_link("/sv-SE?mktvar002=afc_se_usi_email"),
		"from_name": "Autodesk Support",
		"optin_head": "Har du br\u00E5ttom?",
		"optin_desc": "Mejla mig inneh\u00E5llet i min kundvagn.",
		"optin_ok": "OK",
		"tt_head": "SKAPA. HANTERA. SAMMARBETA. <br />ALLT P\u00C5 ETT ST\u00C4LLE.",
		"tt_btn": "FORTS\u00C4TT TILL KASSAN"
	},
	"ja-JP": {
		"link": usi_app.aff_links["ja-JP"] + "?url=" + usi_app.encode_link("/ja-JP?mktvar002=afc_jp_usi_email"),
		"link2": usi_app.aff_links["ja-JP"] + "?url=" + encodeURIComponent("https://www.autodesk.co.jp/benefits/multi-year-subscriptions?mktvar002=afc_jp_upsellit_cartabandonmentemail"),
		"link3": usi_app.aff_links["ja-JP"] + "?url=" + encodeURIComponent("https://www.autodesk.co.jp/benefits/buy-online-securely?mktvar002=afc_jp_upsellit_cartabandonmentemail"),
		"link4": usi_app.aff_links["ja-JP"] + "?url=" + encodeURIComponent("https://www.autodesk.co.jp/benefits/refund-policy?mktvar002=afc_jp_upsellit_cartabandonmentemail"),
		"from_name": "\u30AA\u30FC\u30C8\u30C7\u30B9\u30AF\u30B9\u30C8\u30A2\u30AB\u30B9\u30BF\u30DE\u30FC\u30B5\u30DD\u30FC\u30C8",
		"optin_head": "\u3054\u6C7A\u5B9A\u306B\u3082\u3063\u3068\u6642\u9593\u304C\u5FC5\u8981\u3067\u3059\u304B\uFF1F",
		"optin_desc": "\u6CE8\u6587\u5185\u5BB9\u306B\u3064\u3044\u3066\u30E1\u30FC\u30EB\u3092\u9001\u3063\u3066\u4E0B\u3055\u3044\u3002",
		"optin_ok": "\u306F\u3044",
		"tt_head": "\u5275\u9020\u3002\u7BA1\u7406\u3002\u5354\u50CD\u3002<br />\u3059\u3079\u3066\u304C\u4E00\u3064\u306E\u5834\u6240\u306B\u3002",
		"tt_btn": "\u8CFC\u5165\u624B\u7D9A\u304D\u3092\u7D9A\u3051\u308B"
	},
	"ko-KR": {
		"link": usi_app.aff_links["ko-KR"] + "?url=" + usi_app.encode_link("/store?Action=DisplayPage&Locale=ko_KR&SiteID=adskkr&id=QuickBuyCartPage&mktvar002=afc_kr_usi_email"),
		"link2": usi_app.aff_links["ko-KR"] + "?url=" + encodeURIComponent("https://www.autodesk.co.kr/benefits/multi-year-subscriptions?mktvar002=afc_kr_upsellit_cartabandonmentemail"),
		"link3": usi_app.aff_links["ko-KR"] + "?url=" + encodeURIComponent("https://www.autodesk.co.kr/benefits/buy-online-securely?mktvar002=afc_kr_upsellit_cartabandonmentemail"),
		"link4": usi_app.aff_links["ko-KR"] + "?url=" + encodeURIComponent("https://www.autodesk.co.kr/benefits/refund-policy?mktvar002=afc_kr_upsellit_cartabandonmentemail"),
		"from_name": "\uC624\uD1A0\uB370\uC2A4\uD06C \uC2A4\uD1A0\uC5B4",
		"optin_head": "\uC2DC\uAC04\uC774 \uB354 \uD544\uC694\uD558\uC2E0\uAC00\uC694?",
		"optin_desc": "\uC7A5\uBC14\uAD6C\uB2C8 \uB0B4\uC5ED\uC744 \uC774\uBA54\uC77C\uB85C \uBC1B\uB294\uB370 \uB3D9\uC758\uD569\uB2C8\uB2E4.",
		"optin_ok": "\uC644\uB8CC",
		"tt_head": "\uCC3D\uC870. \uAD00\uB9AC. \uD611\uB825.<br />\uBAA8\uB450 \uD55C\uACF3\uC5D0\uC11C.",
		"tt_btn": "\uACB0\uC81C \uC9C4\uD589\uD558\uAE30"
	},
	"fi-FI": {
		"link": usi_app.aff_links["fi-FI"] + "?url=" + usi_app.encode_link("/fi-FI?mktvar002=afc_fi_usi_email{{usi_pids}}"),
		"from_name": "Autodesk-tuki",
		"optin_head": "Onko sinulla kiire?",
		"optin_desc": "L\u00E4het\u00E4 minulle ostoskorini sis\u00E4lt\u00F6 s\u00E4hk\u00F6postilla.",
		"optin_ok": "OK",
		"tt_head": "LUO. K\u00C4SITTELE. TEE YHTEISTY\u00D6T\u00C4. <br />KAIKKI SAMASSA PAIKASSA.",
		"tt_btn": "JATKA TILAUKSEN L\u00C4HETYKSEEN"
	},
	"hu-HU": {
		"link": usi_app.aff_links["hu-HU"] + "?url=" + usi_app.encode_link("/hu-HU?mktvar002=afc_hu_usi_email"),
		"from_name": "Autodesk t\u00E1mogat\u00E1s",
		"optin_head": "Siet?",
		"optin_desc": "K\u00E9rem, k\u00FCldj\u00E9k el e-mailben a kosaram tartalm\u00E1t.",
		"optin_ok": "OK",
		"tt_head": "ALKOSSON. IR\u00C1NY\u00CDTSON. M\u0170K\u00D6DJ\u00D6N EGY\u00DCTT. <br />MINDEN EGY HELYEN.",
		"tt_btn": "TOV\u00C1BB A KASSZ\u00C1RA"
	},
	"cs-CZ": {
		"link": usi_app.aff_links["cs-CZ"] + "?url=" + usi_app.encode_link("/cs-CZ?mktvar002=afc_cz_usi_email"),
		"from_name": "Podpora spole\u010Dnosti Autodesk",
		"optin_head": "M\u00E1te nasp\u011Bch?",
		"optin_desc": "Za\u0161lete mi e-mailem obsah ko\u0161\u00EDku.",
		"optin_ok": "OK",
		"tt_head": "Tvo\u0159te. Spravujte. Spolupracujte.<br />V\u0161echno na jednom m\u00EDst\u011B.",
		"tt_btn": "POKRA\u010CUJTE V PLATB\u011A"
	},
	"da-DK": {
		"link": usi_app.aff_links["da-DK"] + "?url=" + usi_app.encode_link("/da-DK?mktvar002=afc_dk_usi_email"),
		"from_name": "Autodesk Support",
		"optin_head": "Har du travlt?",
		"optin_desc": "Email mig venligst indholdet i min kurv.",
		"optin_ok": "OK",
		"tt_head": "OPRET. ADMINISTR\u00C9R. SAMARBEJDE. <br />ALT SAMLET P\u00C5 \u00C9T STED",
		"tt_btn": "FORTS\u00C6T BETALING"
	},
	"zh-CN": {
		"link": usi_app.aff_links["zh-CN"] + "?url=" + usi_app.encode_link("/store?Action=DisplayPage&Locale=zh_CN&SiteID=adskcn&id=QuickBuyCartPage&mktvar002=afc_cn_usi_email"),
		"link2": usi_app.aff_links["zh-CN"] + "?url=" + encodeURIComponent("https://www.autodesk.com.cn/benefits/multi-year-subscriptions?mktvar002=afc_cn_upsellit_cartabandonmentemail"),
		"link3": usi_app.aff_links["zh-CN"] + "?url=" + encodeURIComponent("https://www.autodesk.com.cn/benefits/buy-online-securely?mktvar002=afc_cn_upsellit_cartabandonmentemail"),
		"link4": usi_app.aff_links["zh-CN"] + "?url=" + encodeURIComponent("https://www.autodesk.com.cn/benefits/buy-online-securely?mktvar002=afc_cn_upsellit_cartabandonmentemail"),
		"from_name": "\u6B27\u7279\u514B\u5BA2\u670D",
		"optin_head": "\u8D76\u65F6\u95F4\u5417\uFF1F",
		"optin_desc": "\u628A\u8D2D\u7269\u8F66\u5185\u5BB9\u53D1\u5230\u6211\u7684\u90AE\u7BB1\u3002",
		"optin_ok": "\u597D\u7684",
		"tt_head": "\u521B\u9020 \u7BA1\u7406 \u534F\u4F5C<br />\u4E00\u7AD9\u5F0F\u8F6F\u4EF6\u4EA7\u54C1",
		"tt_btn": "\u70B9\u51FB\u7EE7\u7EED"
	}
};
usi_app.upsell_list = {
	"ACDIST": {
		5175204500: 5175204700,
		5175178900: 5175179100,
		5175203600: 5175203800,
		5265851400: 5265851600,
		24016: 24026,
		24015: 24025,
		24014: 24024,
		24013: 24023,
		24012: 24022,
		24034: 24036,
		24040: 24042,
		23998: 24000
	},
	"ACDLT": {
		334624900: 334625100,
		5064672900: 5064673100,
		334805700: 334805900,
		24124: 24140,
		24127: 24143,
		24126: 24142,
		24123: 24139,
		24125: 24141,
		24129: 24145,
		24131: 24147,
		24117: 24133
	},
	"ACDLTM": {
		5343030900: 5343031000,
		21827: 21811,
		21830: 21813,
		21829: 21814,
		21826: 21816,
		21828: 21817,
		21831: 21812,
		21818: 21815,
		22131: 22133
	},
	"MAYA": {
		5282211400: 5276772200,
		5026767800: 5026768000,
		5064675600: 5064675800,
		332331300: 332331700,
		5342460100: 5342460200,
		24542: 24551,
		24545: 24553,
		24544: 24554,
		24541: 24555,
		24543: 24561,
		24559: 24552,
		24565: 24567,
		24523: 24525
	},
	"MAYALT": {
		5343130400: 5343130500,
		5023725400: 5023725600,
		5109132800: 5109133000,
		325558800: 4426974500,
		24579: 24590,
		24580: 24591,
		24581: 24592,
		24582: 24593,
		24583: 24597,
		24595: 24589,
		24601: 24602,
		24571: 24573
	},
	"RVT": {
		5282506000: 5282505900,
		5342419400: 5342419500,
		334478800: 334479000,
		5106958300: 5106958500,
		5250171200: 5250171400,
		24918: 24928,
		24916: 24926,
		24914: 24924,
		24917: 24927,
		24915: 24925,
		24932: 24934,
		24938: 24940,
		24896: 24898
	},
	"RVTLT": {
		5343022500: 5343022600,
		334576200: 334576400,
		5146831400: 5146831600,
		5145960000: 5145960200,
		24963: 24973,
		24966: 24976,
		24965: 24975,
		24962: 24972,
		24964: 24974,
		24980: 24982,
		24984: 24986,
		24944: 24946
	},
	"3DSMAX": {
		5342420600: 5342420700,
		334495200: 334495400,
		5064674700: 5064674900,
		335051800: 335052000,
		23746: 23778,
		23747: 23779,
		23748: 23780,
		23749: 23781,
		23750: 23782,
		23738: 23770,
		23740: 23772,
		23752: 23784
	},
	"AECCOL": {
		5342419700: 5342419800,
		23970: 23980,
		23973: 23983,
		23972: 23982,
		23969: 23979,
		23971: 23981,
		23987: 23989,
		23993: 23995,
		23951: 23953,
		5282507500: 5282507400,
		5056161400: 5056161600,
		5064643100: 5064643300,
		5056951700: 5056951900
	},
	"PDCOLL": {
		5282507800: 5282507700,
		5056953400: 5056953600,
		24843: 24854,
		24844: 24855,
		24845: 24856,
		24846: 24857,
		24847: 24863,
		24861: 24853,
		5342521500: 5342521600,
		5056163100: 5056163300,
		5064644000: 5064644200,
		24867: 24869,
		24825: 24827
	},
	"MECOLL": {
		5342420000: 5342420100,
		5282508200: 5282508100,
		5056164800: 5056165000,
		5064644900: 5064645100,
		5056159500: 5056159700
	},
	"CIV3D": {
		5342421200: 5342421300,
		5282505700: 5282505600,
		334627700: 334627900,
		5064676500: 5064676700,
		334803200: 334803400,
		24250: 24260,
		24253: 24263,
		24252: 24262,
		24249: 24259,
		24251: 24261,
		24267: 24269,
		24273: 24275,
		24231: 24233
	}
}

usi_app.upsell_pids_list = {
	"18179": 21889,
	"18181": 21892,
	"18183": 21895,
	"18185": 21898,
	"18187": 21904,
	"18191": 21907,
	"23498": 23514,
	"23499": 23515,
	"23500": 23516,
	"23501": 23517,
	"23502": 23518,
	"23503": 23519,
	"23504": 23520,
	"23505": 23521,
	"23807": 23809,
	"23821": 23831,
	"23822": 23804,
	"23823": 23832,
	"23824": 23833,
	"23825": 23834,
	"23842": 23844,
	"23848": 23850,
	"24072": 24082,
	"24073": 24083,
	"24074": 24084,
	"24075": 24085,
	"24076": 24086,
	"24094": 24096,
	"24447": 24457,
	"24448": 24458,
	"24449": 24459,
	"24450": 24460,
	"24451": 24461,
	"24463": 24465,
	"24781": 24783,
	"24799": 24809,
	"24800": 24810,
	"24801": 24811,
	"24802": 24812,
	"24803": 24813,
	"24815": 24817,
	"24819": 24821,
	"25220": 25221,
	"25227": 25234,
	"25228": 25235,
	"25229": 25236,
	"25230": 25232,
	"25231": 25233,
	"25238": 25239,
	"25241": 25242,
	"25480": 25481,
	"25486": 26018,
	"25501": 25502,
	"25512": 25513,
	"25553": 25554,
	"25750": 25756,
	"25752": 25758,
	"25753": 25759,
	"25882": 25888,
	"25884": 25890,
	"25885": 25891,
	"25936": 25942,
	"25938": 25944,
	"25939": 25945,
	"25972": 25978,
	"25974": 25980,
	"25975": 25981,
	"26173": 26179,
	"26175": 26181,
	"26176": 26182,
	"26387": 26388,
	"26409": 26410,
	"26418": 26419,
	"26424": 26425,
	"26481": 26184,
	"26594": 26595,
	"26616": 26617,
	"26625": 26626,
	"26631": 26632,
	"26660": 26183,
	"26899": 26900,
	"26906": 26913,
	"26907": 26914,
	"26908": 26915,
	"26909": 26911,
	"26910": 26912,
	"26917": 26918,
	"26920": 26921,
	"26923": 26924,
	"26930": 26935,
	"26932": 26937,
	"26933": 26938,
	"26934": 26939,
	"26941": 26942,
	"27018": 27019,
	"27021": 27022,
	"27024": 27025,
	"27027": 27028,
	"27030": 27031,
	"27034": 27035,
	"27037": 27038,
	"27042": 27043,
	"27045": 27046,
	"27048": 27049,
	"27050": 27051,
	"27053": 27054,
	"27055": 27056,
	"27066": 27067,
	"27068": 27069,
	"27070": 27071,
	"27072": 27073,
	"27075": 27076,
	"27078": 27079,
	"27082": 27083,
	"27085": 27086,
	"27088": 27089,
	"27090": 27091,
	"27093": 27094,
	"27096": 27097,
	"27099": 27100,
	"27102": 27103,
	"27104": 27105,
	"27107": 27108,
	"27110": 27111,
	"27112": 27113,
	"27115": 27116,
	"27118": 27119,
	"27121": 27122,
	"27127": 27129,
	"27132": 27134,
	"27138": 27140,
	"27145": 27147,
	"27150": 27152,
	"27157": 27159,
	"27162": 27164,
	"27171": 27172,
	"27174": 27175,
	"27177": 27178,
	"27179": 27180,
	"27184": 27186,
	"27190": 27192,
	"27210": 27211,
	"27212": 27213,
	"27214": 27216,
	"27218": 27220,
	"27223": 27224,
	"27228": 27230,
	"27235": 27237,
	"27239": 27240,
	"27245": 27247,
	"27248": 27250,
	"27255": 27257,
	"27261": 27263,
	"27270": 27272,
	"27274": 27275,
	"27277": 27278,
	"27281": 27284,
	"27288": 27290,
	"27291": 27293,
	"27298": 27300,
	"27304": 27306,
	"27310": 27312,
	"27317": 27319,
	"27322": 27324,
	"27328": 27330,
	"27335": 27337,
	"27340": 27342,
	"27349": 27351,
	"27352": 27354,
	"27361": 27362,
	"27363": 27364,
	"27366": 27367,
	"27368": 27369,
	"27373": 27375,
	"27377": 27379,
	"27397": 27398,
	"27399": 27400,
	"27401": 27403,
	"27405": 27407,
	"27410": 27411,
	"27415": 27417,
	"27422": 27424,
	"27426": 27428,
	"27432": 27434,
	"27435": 27437,
	"27442": 27444,
	"27454": 27456,
	"27458": 27459,
	"27460": 27461,
	"27465": 27467,
	"27471": 27473,
	"27474": 27476,
	"27481": 27483,
	"27485": 27487,
	"27491": 27493,
	"27514": 27524,
	"27515": 27525,
	"27516": 27526,
	"27517": 27527,
	"27518": 27528,
	"27539": 27549,
	"27541": 27551,
	"27543": 27553,
	"27545": 27555,
	"27547": 27557,
	"27569": 27579,
	"27571": 27581,
	"27573": 27583,
	"27575": 27585,
	"27577": 27587,
	"27604": 27614,
	"27605": 27615,
	"27606": 27616,
	"27607": 27617,
	"27608": 27618,
	"27629": 27639,
	"27630": 27640,
	"27631": 27641,
	"27632": 27642,
	"27633": 27643,
	"27664": 27674,
	"27665": 27675,
	"27666": 27676,
	"27667": 27677,
	"27668": 27678,
	"27679": 27689,
	"27680": 27690,
	"27681": 27691,
	"27682": 27692,
	"27683": 27693,
	"27724": 27731,
	"27725": 27732,
	"27726": 27733,
	"27727": 27729,
	"27728": 27730,
	"27739": 27746,
	"27740": 27747,
	"27741": 27748,
	"27742": 27744,
	"27743": 27745,
	"27754": 27761,
	"27755": 27762,
	"27756": 27763,
	"27757": 27759,
	"27758": 27760,
	"27764": 27771,
	"27765": 27772,
	"27766": 27773,
	"27767": 27769,
	"27768": 27770,
	"27789": 27799,
	"27790": 27800,
	"27791": 27801,
	"27792": 27802,
	"27793": 27803,
	"27809": 27819,
	"27810": 27820,
	"27811": 27821,
	"27812": 27822,
	"27813": 27823,
	"27909": 27916,
	"27910": 27917,
	"27911": 27918,
	"27912": 27914,
	"27913": 27915,
	"27919": 27926,
	"27920": 27927,
	"27921": 27928,
	"27922": 27924,
	"27923": 27925,
	"27929": 27939,
	"27930": 27940,
	"27931": 27941,
	"27933": 27943,
	"27949": 27959,
	"27950": 27960,
	"27951": 27961,
	"27952": 27962,
	"27953": 27963,
	"27974": 27979,
	"27975": 27980,
	"27976": 27981,
	"27977": 27982,
	"27978": 27983,
	"27999": 28009,
	"28000": 28010,
	"28001": 28011,
	"28002": 28012,
	"28003": 28013,
	"28034": 28044,
	"28035": 28045,
	"28036": 28046,
	"28037": 28047,
	"28038": 28048,
	"28054": 28064,
	"28055": 28065,
	"28056": 28066,
	"28057": 28067,
	"28058": 28068,
	"28084": 28094,
	"28085": 28095,
	"28086": 28096,
	"28087": 28097,
	"28088": 28098,
	"28099": 28109,
	"28101": 28111,
	"28103": 28113,
	"28105": 28115,
	"28107": 28117,
	"28134": 28144,
	"28135": 28145,
	"28136": 28146,
	"28137": 28147,
	"28138": 28148,
	"28164": 28174,
	"28165": 28175,
	"28166": 28176,
	"28167": 28177,
	"28168": 28178,
	"28194": 28204,
	"28195": 28205,
	"28196": 28206,
	"28197": 28207,
	"28198": 28208,
	"28214": 28221,
	"28215": 28222,
	"28216": 28223,
	"28217": 28219,
	"28218": 28220,
	"28229": 28234,
	"28230": 28235,
	"28231": 28236,
	"28232": 28237,
	"28233": 28238,
	"28254": 28264,
	"28255": 28265,
	"28258": 28268,
	"28274": 28284,
	"28275": 28285,
	"28276": 28286,
	"28277": 28287,
	"28278": 28288,
	"28299": 28309,
	"28301": 28311,
	"28303": 28313,
	"28305": 28315,
	"28307": 28317,
	"28334": 28344,
	"28335": 28345,
	"28336": 28346,
	"28337": 28347,
	"28338": 28348,
	"28364": 28374,
	"28365": 28375,
	"28366": 28376,
	"28367": 28377,
	"28368": 28378,
	"28394": 28404,
	"28395": 28405,
	"28396": 28406,
	"28397": 28407,
	"28398": 28408,
	"28413": 28415,
	"28418": 28420,
	"28424": 28426,
	"28431": 28433,
	"28436": 28438,
	"28445": 28447,
	"28450": 28452,
	"28459": 28460,
	"28461": 28462,
	"28464": 28465,
	"28471": 28473,
	"28475": 28477,
	"28494": 28496,
	"28498": 28499,
	"28500": 28502,
	"28504": 28506,
	"28509": 28510,
	"28514": 28516,
	"28521": 28523,
	"28525": 28527,
	"28531": 28533,
	"28534": 28536,
	"28541": 28543,
	"28546": 28548,
	"28553": 28555,
	"28557": 28558,
	"28559": 28560,
	"28564": 28566,
	"28570": 28572,
	"28573": 28575,
	"28580": 28582,
	"28586": 28588,
	"28592": 28594,
	"30314": 30320,
	"30316": 30322,
	"30317": 30323,
	"30318": 30324,
	"30319": 30325,
	"30332": 30338,
	"30334": 30340,
	"30335": 30341,
	"30336": 30342,
	"30337": 30343,
	"30350": 30356,
	"30352": 30358,
	"30353": 30359,
	"30354": 30360,
	"30355": 30361,
	"30368": 30374,
	"30370": 30376,
	"30371": 30377,
	"30372": 30378,
	"30373": 30379,
	"30386": 30392,
	"30388": 30394,
	"30389": 30395,
	"30390": 30396,
	"30391": 30397,
	"30403": 30409,
	"30405": 30411,
	"30406": 30412,
	"30407": 30413,
	"30408": 30414,
	"30421": 30427,
	"30423": 30429,
	"30424": 30430,
	"30425": 30431,
	"30426": 30432,
	"30439": 30445,
	"30441": 30447,
	"30442": 30448,
	"30443": 30449,
	"30444": 30450,
	"30469": 30475,
	"30471": 30477,
	"30472": 30478,
	"30473": 30479,
	"30474": 30480,
	"30487": 30493,
	"30489": 30495,
	"30490": 30496,
	"30491": 30497,
	"30492": 30498,
	"30505": 30511,
	"30507": 30513,
	"30508": 30514,
	"30509": 30515,
	"30510": 30516,
	"30517": 30523,
	"30519": 30525,
	"30520": 30526,
	"30521": 30527,
	"30522": 30528,
	"30535": 30541,
	"30537": 30543,
	"30538": 30544,
	"30539": 30545,
	"30540": 30546,
	"30552": 30558,
	"30554": 30560,
	"30555": 30561,
	"30556": 30562,
	"30557": 30563,
	"30618": 30624,
	"30620": 30626,
	"30621": 30627,
	"30622": 30628,
	"30623": 30629,
	"30634": 30641,
	"30635": 30642,
	"30637": 30640,
	"30638": 30644,
	"30639": 30645,
	"30646": 30652,
	"30648": 30654,
	"30649": 30655,
	"30650": 30656,
	"30651": 30657,
	"30658": 30664,
	"30660": 30666,
	"30661": 30667,
	"30662": 30668,
	"30663": 30669,
	"30676": 30682,
	"30678": 30684,
	"30679": 30685,
	"30680": 30686,
	"30681": 30687,
	"30694": 30700,
	"30696": 30702,
	"30697": 30703,
	"30698": 30704,
	"30699": 30705,
	"30718": 30724,
	"30720": 30726,
	"30721": 30727,
	"30722": 30728,
	"30723": 30729,
	"30736": 30742,
	"30738": 30744,
	"30739": 30745,
	"30740": 30746,
	"30741": 30747,
	"30754": 30760,
	"30756": 30762,
	"30757": 30763,
	"30758": 30764,
	"30759": 30765,
	"30770": 30776,
	"30772": 30778,
	"30773": 30779,
	"30774": 30780,
	"30775": 30781,
	"30788": 30794,
	"30790": 30796,
	"30791": 30797,
	"30792": 30798,
	"30793": 30799,
	"30806": 30812,
	"30808": 30814,
	"30809": 30815,
	"30810": 30816,
	"30811": 30817,
	"30824": 30830,
	"30826": 30832,
	"30827": 30833,
	"30828": 30834,
	"30829": 30835,
	"30842": 30848,
	"30844": 30850,
	"30845": 30851,
	"30846": 30852,
	"30847": 30853,
	"30859": 30865,
	"30861": 30867,
	"30862": 30868,
	"30863": 30869,
	"30864": 30870,
	"30877": 30883,
	"30879": 30885,
	"30880": 30886,
	"30881": 30887,
	"30882": 30888,
	"30894": 30900,
	"30896": 30902,
	"30897": 30903,
	"30898": 30904,
	"30899": 30905,
	"30911": 30917,
	"30913": 30919,
	"30914": 30920,
	"30915": 30921,
	"30916": 30922,
	"30929": 30935,
	"30931": 30937,
	"30932": 30938,
	"30933": 30939,
	"30934": 30940,
	"30947": 30953,
	"30949": 30955,
	"30950": 30956,
	"30951": 30957,
	"30952": 30958,
	"30965": 30971,
	"30967": 30973,
	"30968": 30974,
	"30969": 30975,
	"30970": 30976,
	"31171": 31216,
	"31174": 31217,
	"31178": 31219,
	"31190": 31221,
	"31191": 31222,
	"31192": 31223,
	"31193": 31224,
	"31194": 31225,
	"31202": 31231,
	"31210": 31233,
	"31211": 31234,
	"31212": 31235,
	"31213": 31236,
	"31214": 31237,
	"31215": 31238,
	"31267": 31268,
	"31270": 31271,
	"31273": 31274,
	"31276": 31277,
	"31279": 31280,
	"31283": 31284,
	"31286": 31287,
	"31289": 31290,
	"31292": 31293,
	"31295": 31296,
	"31298": 31299,
	"31301": 31302,
	"31304": 31305,
	"31308": 31309,
	"31310": 31311,
	"31312": 31313,
	"31314": 31315,
	"31317": 31318,
	"31320": 31321,
	"31329": 31330,
	"31332": 31333,
	"31334": 31335,
	"31336": 31337,
	"31338": 31340,
	"31342": 31343,
	"31346": 31347,
	"31349": 31350,
	"31352": 31353,
	"31355": 31356,
	"31358": 31359,
	"31361": 31362,
	"31364": 31365,
	"31367": 31368,
	"31370": 31371,
	"31373": 31374,
	"31376": 31377,
	"31379": 31380,
	"31382": 31383,
	"31385": 31386,
	"320236000": 320236200,
	"325558800": 4426974500,
	"332331300": 332331700,
	"332902900": 332903100,
	"333863000": 333863200,
	"334506000": 334506200,
	"334508800": 334509000,
	"334509600": 334509800,
	"334570800": 334571000,
	"334602100": 334602300,
	"334602900": 334603100,
	"334605700": 334605900,
	"334612600": 334612800,
	"334613400": 334613600,
	"334614300": 334614500,
	"334803200": 334803400,
	"334805700": 334805900,
	"334808100": 334808300,
	"334818600": 334818800,
	"334819400": 334819600,
	"334820200": 334820400,
	"334821000": 334821200,
	"335051800": 335052000,
	"335075100": 335075300,
	"1703520900": 1703521100,
	"2957206500": 2957206700,
	"3411569100": 3411569300,
	"27448": 27450,
	"27932": 27942,
	"28256": 28266,
	"5342418900": 5342419000,
	"5342460100": 5342460200,
	"5342419400": 5342419500,
	"5342419700": 5342419800,
	"5342420000": 5342420100,
	"5342420300": 5342420400,
	"5342420600": 5342420700,
	"5342420900": 5342421000,
	"5342421200": 5342421300,
	"5342521500": 5342521600,
	"5343021700": 5343021800,
	"5343023300": 5343023400,
	"5343023700": 5343023800,
	"5343024500": 5343024600,
	"5343129700": 5343129800,
	"5343026500": 5343026600,
	"5343026900": 5343027000,
	"5343027300": 5343027400,
	"5350614700": 5350614800,
	"5343028100": 5343028200,
	"5343028900": 5343029000,
	"5343029300": 5343029400,
	"5343030100": 5343030200,
	"5343030500": 5343030600,
	"5343063500": 5343063600,
	"5343063900": 5343064000,
	"5343064300": 5343064400,
	"5343064700": 5343064800,
	"5343130400": 5343130500,
	"5350615100": 5350615200,
	"5361225400": 5361225500,
	"5403743200": 5403743300,
	"5470242000": 5470242100,
	"5476961700": 5476961800,
	"5476962100": 5476962200,
	"5476962500": 5476962600,
	"5476962900": 5476963000,
	"5476963300": 5476963400,
	"5518111900": 5518112000,
	"5343022500": 5343022600,
	"5343025700": 5343025800,
	"5365151600": 5365151700,
	"5365152000": 5365152100,
	"5512493500": 5512493600,
	"5354508700": 5354508800,
	"5355291600": 5355291700,
	"5355292000": 5355292100,
	"5355292400": 5355292500,
	"5355292800": 5355292900,
	"5355293200": 5355293300,
	"5355294000": 5355294100,
	"5355294400": 5355294500,
	"5355294800": 5355294900,
	"5355295200": 5355295300,
	"5355338600": 5355338700,
	"5355339000": 5355339100,
	"5355339400": 5355339500,
	"5355339800": 5355339900,
	"5355341000": 5355341100,
	"5362831900": 5362832000,
	"5458662100": 5458662200,
	"5476471900": 5476472000,
	"5476472300": 5476472400,
	"5476472700": 5476472800,
	"5477212500": 5477212600,
	"5476473100": 5476473200,
	"5502121600": 5502121700,
	"5502122000": 5502122100,
	"5507001800": 5507001900,
	"5506981600": 5506981700,
	"5505021600": 5505021700,
	"5518873200": 5518873300,
	"5109491100": 5109491200,
	"5109491700": 5109491800,
	"5056508900": 5056509700,
	"5056511000": 5056511800,
	"5056512200": 5056512400,
	"5057001300": 5057001500,
	"5056971800": 5056972000,
	"5057003200": 5057003400,
	"5062041000": 5062041200,
	"5078233900": 5078234100,
	"5094063600": 5094063800,
	"5102021100": 5102713900,
	"5130211300": 5130211500,
	"5130211800": 5130212000,
	"5175179800": 5175180000,
	"5175204900": 5175205400,
	"5175204500": 5175204700,
	"5228007900": 5228008100,
	"5266342300": 5266342500,
	"5271518300": 5271518500,
	"5361224100": 5361224300,
	"5470362500": 5470362700,
	"5476474600": 5476474800,
	"5476475100": 5476475300,
	"5476475600": 5476475800,
	"5477713100": 5477713300,
	"5476477500": 5476477600,
	"5518792600": 5518792800,
	"5343024900": 5343025000,
	"5265851400": 5265851600,
	"5276772300": 5276772200,
	"5282211400": 5282211300,
	"5282505700": 5282505600,
	"5282506000": 5282505900,
	"5282506300": 5282506200,
	"5282506600": 5282506500,
	"5282506900": 5282506800,
	"5282507200": 5282507100,
	"5282507500": 5282507400,
	"5282507800": 5282507700,
	"5282508200": 5282508100,
	"5394892000": 5394891900,
	"5320061200": 5320061300,
	"5322801900": 5322802000,
	"5322802200": 5322802300,
	"5322802500": 5322802600,
	"5322802800": 5322802900,
	"5322803100": 5322803200,
	"5322803700": 5322803800,
	"5322804000": 5322804100,
	"5322804600": 5322804700,
	"5322804900": 5322805000,
	"5322805200": 5322805300,
	"5322806100": 5322806200,
	"5322806400": 5322806500,
	"5322806700": 5322806800,
	"5322807000": 5322807100,
	"5322807300": 5322807400,
	"5322807600": 5322807700,
	"5334481500": 5334481600,
	"5334481800": 5334481900,
	"5334482100": 5334482200,
	"5334482400": 5334482500,
	"5336683600": 5336683700,
	"5336683900": 5336684000,
	"5340676800": 5340676900,
	"5347507100": 5347507200,
	"5347507400": 5347507500,
	"5361225700": 5361225800,
	"5398223300": 5398223400,
	"5477051500": 5477051600,
	"5477051800": 5477051900,
	"5477052100": 5477052200,
	"5477211800": 5477211900,
	"5477052400": 5477052500,
	"5518873800": 5518873900,
	"5507461400": 5507461500,
	"5507441400": 5507441500,
	"4318736500": 4318736700,
	"5056159500": 5056159700,
	"5056951700": 5056951900,
	"5056953400": 5056953600,
	"5059471200": 5059471400,
	"5078626600": 5078626800,
	"5101750700": 5105052300,
	"5123431800": 5123432000,
	"5125261200": 5125261400,
	"5145960000": 5145960200,
	"5175180700": 5175180900,
	"5175203600": 5175203800,
	"5250171200": 5250171400,
	"5361222500": 5361222600,
	"5448052200": 5448052400,
	"5466101900": 5466102100,
	"5518794100": 5518794300,
	"5509331600": 5509331700,
	"5509332000": 5509332100,
	"5509332400": 5509332500,
	"5509332800": 5509332900,
	"5509333200": 5509333300,
	"5509333600": 5509333700,
	"5509334000": 5509334100,
	"5509334400": 5509334500,
	"5509334800": 5509334900,
	"5509335200": 5509335300,
	"5509335600": 5509335700,
	"5509336000": 5509336100,
	"5509336400": 5509336500,
	"5509336800": 5509336900,
	"5520212100": 5520212200
};

usi_app.upsell_pids_list_monthly = {
	"16171": 27248,
	"16186": 28534,
	"18162": 24066,
	"18208": 27155,
	"23482": 23498,
	"23488": 23504,
	"25269": 27212,
	"27273": 27274,
	"28556": 28557,
	"31172": 31174,
	"31200": 31202,
	"31240": 27171,
	"31241": 28459,
	"31249": 27177,
	"31250": 28464,
	"31257": 28461,
	"31259": 27174,
	"32368": 23807,
	"32369": 27184,
	"32375": 28424,
	"32405": 28471,
	"32419": 23848,
	"32427": 27138,
	"32432": 28498,
	"32434": 28443,
	"32453": 27298,
	"32469": 27255,
	"32485": 27203,
	"32493": 28559,
	"32496": 28580,
	"32497": 28457,
	"32512": 28488,
	"32531": 27277,
	"32543": 27169,
	"32545": 28541,
	"32555": 28509,
	"32561": 27223,
	"32568": 26899,
	"32574": 27195,
	"32587": 28480,
	"32606": 28531,
	"32608": 26920,
	"32610": 28450,
	"32616": 28586,
	"32655": 27304,
	"32672": 27162,
	"32676": 28413,
	"32684": 27310,
	"32689": 28445,
	"32699": 27157,
	"32702": 27245,
	"32716": 28592,
	"32726": 28570,
	"32727": 31456,
	"32750": 27127,
	"32753": 28514,
	"32768": 31436,
	"32804": 27228,
	"32805": 27288,
	"32808": 27132,
	"32818": 28564,
	"32828": 28418,
	"32850": 24064,
	"32856": 27281,
	"32859": 28546,
	"32870": 25220,
	"32877": 31156,
	"32878": 25241,
	"32910": 31128,
	"32930": 28431,
	"32931": 27261,
	"32946": 27207,
	"32950": 28492,
	"32964": 27145,
	"32969": 28521,
	"32972": 27235,
	"32986": 28436,
	"33011": 27150,
	"33017": 28553,
	"33019": 27210,
	"33021": 27270,
	"33047": 28494,
	"33052": 27239,
	"33058": 28525,
	"33924": 33962,
	"33941": 33948,
	"33970": 34008,
	"33987": 33994
}
		usi_app.main = function () {
			try {

				// Suppress all USI solutions
				if (usi_commons.gup_or_get_cookie("usi_suppress_all", usi_cookies.expire_time.minute * 10, true)) {
					usi_commons.log('[ main ] Suppressing all USI code...');
					return;
				}

				// Suppress on invalid docs
				if (typeof window['document'] === "undefined") {
					usi_commons.log('[ main ] Suppressing due to invalid window object...');
					return;
				}

				// Suppress on invalid session storage
				if (!usi_app.is_storage_supported('sessionStorage')) {
					usi_commons.log('[ main ] Suppressing due to invalid session storage...');
					return;
				}

				// General
				usi_app.company_id = "3614";
				usi_app.recommendation_site_product = "42917";
				usi_app.url = location.href.toLowerCase();
				usi_app.path_name = location.pathname.toLowerCase();
				usi_app.product_page_data = {};
				usi_app.products = [];
				usi_app.pids_in_cart = "";
				usi_app.plcs_in_cart = [];
				usi_app.cart_reference = "";
				usi_app.loading = 0;
				usi_app.upsell_inpage = {};
				usi_app.plc = '';
				usi_app.upsell_plcs = ['3DSMAX', 'AECCOL', 'ACD', 'ACDIST', 'ACDLT', 'ACDLTM', 'RVTLTS', 'CIV3D', 'MAYA', 'MAYALT', 'MECOLL', 'PDCOLL', 'RVT', 'RVTLT'];
				usi_app.upsell_plcs_monthly = ['3DSMAX', 'AECCOL', 'ACD', 'ACDIST', 'ACDLT', 'ACDLTM', 'RVTLTS', 'CIV3D', 'MAYA', 'MAYALT', 'MECOLL', 'PDCOLL', 'RVT', 'RVTLT'];
				usi_app.upsell_key = '';

				// Check KR CJ Suppressions
				usi_app.kr_pid_suppressions = ['100407173', '100407533', '100407518', '100407533', '100407521', '100407499', '100408074', '100408167', '100407449', '5813072', '100408056', '100435345', '5809536', '100407445', '5819192', '100415360', '100431256', '100431260', '100431261', '100431262', '100431265', '100431266', '100431267', '5810411', '100407173', '100435891', '100435905', '5815207', '100415282', '100431247', '100431251', '100431252', '5812054', '100407495', '100445865', '100445867', '100445868', '100445869', '5812221', '100407518', '100434019', '100434022', '100434023', '5812033', '100407533', '100431263', '100435364', '100435365', '100435366', '100435367', '5809348', '100407521', '100431326', '5812036', '100407499', '5812303', '100408074', '5815382', '100417119', '100432005', '5915879', '100477338', '100480086', '100480089', '100480090', '100480097', '5909077', '100472462', '5813123', '100408167', '5901938', '100468771', '100477373', '5949385', '100498922', '100498924', '5812231', '100415381', '5812038', '100407449', '5920717', '100480010', '5914746', '100476550'];
				usi_app.url_pid = usi_commons.gup('pid') || usi_commons.gup('PID');
				if (usi_app.url_pid && usi_app.kr_pid_suppressions.indexOf(usi_app.url_pid) !== -1) {
					usi_cookies.set('usi_suppress_kr', '1', usi_cookies.expire_time.week, true);
				}

				// Flags
				usi_app.suppress_delay_load = false;
				usi_app.force_date = usi_commons.gup_or_get_cookie('usi_force_date');
				usi_app.is_enabled = usi_commons.gup_or_get_cookie("usi_enable", usi_cookies.expire_time.hour, true) != "";
				usi_app.is_forced = usi_commons.gup_or_get_cookie("usi_force", usi_cookies.expire_time.hour, true) != "";
				usi_app.force_group = usi_commons.gup_or_get_cookie('usi_force_group');
				usi_app.should_rebuild = usi_cookies.get("usi_redirect_happened") == null && usi_commons.gup("usi_pids") != "" && document.querySelector(".dr_emptyCart, .empty-cart-copy, .checkout--empty-cart--text") != null;
				usi_app.clear_cart_in_progress = false;

				// Regions
				usi_app.americas = ["en-US", "en-CA", "fr-CA", "es-MX", "es-MX", "pt-BR", "es-AR"];
				usi_app.northamerica = ["en-US", "en-CA", "fr-CA", "es-MX", "es-MX"];
				usi_app.emea = ["fr-BE", "nl-BE", "cs-CZ", "da-DK", "fi-FI", "fr-FR", "de-DE", "hu-HU", "it-IT", "nl-NL", "no-NO", "pl-PL", "ru-RU", "pt-PT", "es-ES", "sv-SE", "de-CH", "it-CH", "fr-CH", "tr-TR", "en-EU"];
				usi_app.emea_uk = ["fr-BE", "nl-BE", "cs-CZ", "da-DK", "fi-FI", "fr-FR", "de-DE", "hu-HU", "it-IT", "nl-NL", "no-NO", "pl-PL", "ru-RU", "pt-PT", "es-ES", "sv-SE", "de-CH", "it-CH", "fr-CH", "tr-TR", "en-EU", "en-UK"];
				usi_app.anz = ["en-NZ", "en-AU"];
				usi_app.uk = ["en-UK", "en-SE"]; // en-SE is Middle East (new)
				usi_app.apac = ["en-MY", "en-SG", "ja-JP", "ko-KR", "en-IN", "zh-CN"];
				usi_app.latinamerica = ["es-MX", "pt-BR", "es-AR"]; // Latin America locales are included in Americas

				// Special copy
				usi_app.is_in_promo_time = false;
				usi_app.is_cn_promo_time = false;
				usi_app.lightning_deal = undefined;

				// Pages & cart types
				usi_app.is_product_page = usi_app.url.match("/products/") != null;
				usi_app.is_renewal_cart_page = location.href.indexOf("adskeren") != -1;
				usi_app.is_confirmation_page = usi_app.url.indexOf("order-confirmation") != -1;
				usi_app.efulfilment = document.getElementsByClassName("dr_legalResellerStatement")[0] != null && document.getElementsByClassName("dr_legalResellerStatement")[0].textContent.toLowerCase().indexOf("efulfilment") != -1;
				usi_app.guac_cart = usi_app.url.indexOf("checkout.autodesk.com/") != -1 || usi_app.url.indexOf("commerce.autodesk.com/") != -1 || usi_app.url.indexOf("commerce-stg.autodesk.com/") != -1 || usi_app.url.indexOf("checkout-pt.autodesk") != -1;
				usi_app.dr_cart = usi_app.url.indexOf("action=displaypage") != -1 && usi_app.url.indexOf("thankyoupage") == -1;
				usi_app.dr_cart_available = document.getElementsByClassName('product-row').length > 0;
				usi_app.is_checkout_page = usi_app.url.indexOf("checkout.autodesk") != -1 || usi_app.url.indexOf("commerce.autodesk") != -1 || usi_app.url.indexOf("store.autodesk") != -1 || usi_app.url.indexOf("checkout-pt.autodesk") != -1;
				usi_app.is_first_checkout_page = typeof window['utag'] != 'undefined' && typeof window['utag']['data'] != 'undefined' && typeof window['utag']['data']['page_name'] != 'undefined' && window['utag']['data']['page_name'].indexOf('cart details') != -1;
				usi_app.is_aec_collections_page = usi_app.url.indexOf('/collections/architecture-engineering-construction/overview') != -1;
				usi_app.is_me_collections_page = usi_app.url.indexOf('/collections/media-entertainment/overview') != -1;
				usi_app.is_pdm_collections_page = usi_app.url.indexOf('/collections/product-design-manufacturing/overview') != -1;
				usi_app.is_acd_page = usi_app.url.indexOf('/products/autocad/overview') != -1;
				usi_app.is_acdlt_page = usi_app.url.indexOf('/products/autocad-lt/overview') != -1;
				usi_app.is_odm_cart = localStorage.getItem('cart') != null && document.querySelector('div.odm-cart-section') != null;

				usi_app.is_staging = usi_app.url.indexOf('checkout-pt.autodesk.com') != -1 || usi_app.url.indexOf('checkout-apollo.autodesk.com') != -1;

				if (usi_app.is_staging && !usi_app.is_enabled) {
					return;
				}

				// ODM cart rebuilder link [en-AU and en-NZ only]
				if (usi_commons.gup("usi_offers") && document.querySelector(".dr_emptyCart, .empty-cart-copy, .checkout--empty-cart--text") != null) {
					location.href = location.href.replace("usi_offers", "offers");
				}

				if (document.referrer.indexOf("autodesk.com") == -1) {
					if ((/cjevent/i).test(location.href) || (/cfclick/i).test(location.href)) {
						usi_cookies.set("usi_aff_suppress", "1", usi_cookies.expire_time.two_weeks, true);
					}
				}

				// Settings
				usi_app.locale = usi_app.get_locale();
				if (usi_cookies.get("usi_locale_reported") == null) {
					usi_cookies.set("usi_locale_reported", "1");
					usi_app.report_locale();
				}

				usi_app.set_mk_vars();

				// Collect product page data
				if (usi_app.is_product_page) {
					usi_app.product_page_data = usi_app.scrape_product_page();
					if (usi_app.product_page_data != null && usi_app.product_page_data.name && usi_app.product_page_data.pid && usi_app.product_page_data.extra) {
						usi_commons.log('[ main ] product_page_data:', usi_app.product_page_data);
						usi_commons.send_prod_rec(usi_app.recommendation_site_product, usi_app.product_page_data, (usi_app.locale));
					}
				}

				// Suppress other solutions on renewal page
				if (usi_app.is_renewal_cart_page) {
					usi_app.init_renewal_cart();
					return;
				}

				// Look for locale prompt modal
				if (usi_app.is_checkout_page) usi_app.look_for_locale_modal();

				// Record last plc and term shown in url
				if (usi_commons.gup('plc')) {
					usi_commons.log('[ main ] PCL found in url:', usi_commons.gup('plc'));
					usi_cookies.set('usi_last_plc', usi_commons.gup('plc'), usi_cookies.expire_time.week);
				}
				if (usi_commons.gup('term')) {
					usi_commons.log('[ main ] Term found in url:', usi_commons.gup('term'));
					usi_cookies.set('usi_last_term', usi_commons.gup('term'), usi_cookies.expire_time.week);
				}

				// Scrape carts
				usi_app.rescrape_cart();

				// Idle modal suppression
				usi_app.close_on_idle_modal();

				// Save products
				if (usi_app.products && usi_app.products.length == 0 && usi_cookies.value_exists("usi_app_products")) {
					usi_app.products = usi_cookies.get_json("usi_app_products");
				} else if (usi_app.products && usi_app.products.length > 0) {
					usi_cookies.set_json("usi_app_products", usi_app.products, usi_cookies.expire_time.day);
				}
				usi_app.save_sale_notes();

				// Check suppressions
				usi_app.check_url_suppressions();
				if (usi_cookies.value_exists("usi_suppress")) {
					usi_commons.log("[ main ] Suppression cookie exists");
					return;
				}

				if(usi_commons.gup("plc") == "FLEXACCESS" || location.href.indexOf("benefits/flex") > -1){
					usi_commons.log("[USI] Suppressing on flex pdp");
					return;
				}

				// Rebuild carts
				if (usi_app.should_rebuild) {
					if (usi_app.dr_cart) {
						setTimeout(usi_app.rebuild_dr_cart, 1500);
					} else if (usi_app.guac_cart) {
						setTimeout(usi_app.rebuild_guac_cart, 1500);
					}
					return;
				}

				if(["en-US","en-CA","es-MX", "pt-BR", "es-AR"].indexOf(usi_app.locale) != -1 && !usi_app.is_checkout_page){
					if (!usi_app.cart_timeout) usi_app.start_cart_monitor();
				}

				// Apply event listener on category pages
				if (location.href.indexOf('/products') !== -1 && !usi_app.events_bound) {
					usi_app.apply_event_listener_recheck_cart('.wp-product-card-box a.wp-add-to-cart', 'click');
				}

				// Load campaigns
				usi_app.load();
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.load = function () {
			try {
				// Clean up previous solutions
				if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') {
					usi_js.cleanup();
				}

				//Jan Flash Sale [US + CA]
				if(["en-US", "en-CA"].indexOf(usi_app.locale) != -1 && usi_date.is_between('2024-01-08T00:00', '2024-01-11T23:59')){
					//On AutoCAD LT pdp page or has AutoCAD LT in cart
					if ((usi_cookies.value_exists('usi_app_products') && usi_cookies.get('usi_app_products').indexOf('AutoCAD LT') != -1) || (usi_cookies.value_exists('usi_prod_name_1') && usi_cookies.get('usi_prod_name_1').indexOf('AutoCAD LT') != -1) || (usi_app.path_name == '/products/autocad-lt/overview' || usi_app.path_name == '/ca-en/products/autocad-lt/overview')){
						usi_commons.load_view("627fL1tJraFIFgBx0VkFvFR", "47601", usi_commons.device + "_" + usi_app.locale);
					}
				}

				//Jan Flash Sale [LATAM]
				if(["es-MX", "pt-BR", "es-AR"].indexOf(usi_app.locale) != -1 && usi_date.is_between('2024-01-15T00:00', '2024-01-18T23:59')){
					//On AutoCAD LT pdp page or has AutoCAD LT in cart
					if ((usi_cookies.value_exists('usi_app_products') && usi_cookies.get('usi_app_products').indexOf('AutoCAD LT') != -1) || (usi_cookies.value_exists('usi_prod_name_1') && usi_cookies.get('usi_prod_name_1').indexOf('AutoCAD LT') != -1) || (usi_app.path_name == '/products/autocad-lt/overview')){
						usi_commons.load_view("627fL1tJraFIFgBx0VkFvFR", "47601", usi_commons.device + "_" + usi_app.locale);
					}
				}

				// US - Cart Preserver LC | Cart Rebuilder
				if (["en-US"].indexOf(usi_app.locale) != -1 && !usi_app.is_checkout_page && (usi_cookies.value_exists('usi_pids','usi_prod_price_1','usi_prod_name_1','usi_prod_image_1') || usi_cookies.value_exists('usi_app_products'))){
					if(usi_cookies.value_exists('usi_app_products')){
						//Mini cart behavior is unpredictable. If it doesnt appear, scrape values from 'usi_app_products' instead
						var prods = usi_cookies.get_json('usi_app_products');
						var pids = "";
						prods.forEach(function(p, i){
							pids += p.product_id + ",";
							if(i == 3) return;
							usi_cookies.set('usi_prod_image_' + (i+1), p.pic, usi_cookies.expire_time.week);
							usi_cookies.set('usi_prod_name_' + (i+1), p.name, usi_cookies.expire_time.week);
							usi_cookies.set('usi_prod_price_' + (i+1), p.price, usi_cookies.expire_time.week);
							usi_cookies.set('usi_prod_qty_' + (i+1), p.qty, usi_cookies.expire_time.week);
						});
						usi_cookies.set('usi_pids', pids, usi_cookies.expire_time.week);
						usi_cookies.set('usi_num_items', prods.length, usi_cookies.expire_time.week);
					}
					if(typeof usi_app.cart != 'undefined' && typeof usi_app.cart.items != 'undefined'){
						usi_cookies.set('usi_num_items', usi_app.cart.items.length, usi_cookies.expire_time.week);
					}
					if(usi_cookies.value_exists('usi_num_items')){
						usi_commons.load_view("QIVeyLvqeRX6Y8fOjEAf4sk", "49313", usi_commons.device);
					}
				}

				// Americas - Precise Promotion | Free Trial | AutoCAD & AutoCADLT PDPs
		

				// Suppress Fusion products in UK, DE, US
				usi_app.suppressf360 = false;
				var fusion_suppressed_locales = ["en-US", "de-DE", "en-UK"];
				if (fusion_suppressed_locales.indexOf(usi_app.locale) !== -1) {
					if (location.href.indexOf("checkout.autodesk") !== -1) {
						if (usi_app.products.length == 0) {
							usi_commons.log("[ load ] Delaying till all products are in the cart (so we can check for Fusion)");
							return;
						}
						for (var i = 0; i < usi_app.products.length; i++) {
							if (usi_app.products[i].name.toLowerCase().indexOf("fusion") != -1) {
								usi_commons.log("[ load ] Suppression Fusion product in cart");
								usi_app.suppressf360 = true;
							}
						}
					} else if (location.href.indexOf("F360") !== -1 || location.href.indexOf("fusion") !== -1) {
						usi_commons.log("[ load ] Suppression Fusion URL");
						usi_app.suppressf360 = true;
					}
				}

				// Init cart page
				if(usi_app.is_odm_cart){
					// New cart platform [en-AU and en-NZ only]
					usi_app.monitor_for_guac_payment_page();
				} else if (usi_app.guac_cart) {
					// 30159, 30149
					usi_app.monitor_for_guac_payment_page();
				} else if (usi_app.dr_cart && (usi_app.dr_cart_available || usi_app.efulfilment)) {
					//30153, 30143
					usi_app.monitor_for_dr_payment_page();
				}

				// Init PCs
				if (!usi_app.suppressf360) {
					usi_app.load_email();
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.start_cart_monitor = function(){
			try {
				usi_commons.log("usi_app.start_cart_monitor()");
				var monitor_cart = function() {
					var total = usi_app.scrape_subtotal_us() || 0;
					var items = usi_app.scrape_cart_us() || [];
					var cart = document.querySelector('ul.mini-cart');
					if (usi_app.total != total || (items && usi_app.items && JSON.stringify(usi_app.items) != JSON.stringify(items))) {
						usi_app.total = total;
						usi_app.items = items;
						if (cart) {
							usi_app.save_cart_us();
						}
						usi_app.load();
					}
					setTimeout(monitor_cart, 1000);
				};
				monitor_cart();
				if (!usi_app.cart_timeout) {
					usi_app.cart_timeout = setTimeout(monitor_cart, 1000);
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.save_cart_us = function(){
			try {
				usi_commons.log("usi_app.save_cart()");
				var cart_prefix = "usi_prod_";
				usi_cookies.flush("usi_subtotal");
				usi_cookies.flush(cart_prefix);
				usi_app.cart = {
					items: usi_app.scrape_cart_us(),
					subtotal: usi_app.scrape_subtotal_us()
				}
				usi_commons.log(usi_app.cart);

				if (typeof usi_app.cart.items != "undefined" && typeof usi_app.cart.subtotal != "undefined") {
					usi_cookies.set("usi_subtotal", usi_app.cart.subtotal, usi_cookies.expire_time.week);
					var usi_pids = usi_app.cart.items.map(function(item) {
						return item.pid;
					});
					usi_cookies.set("usi_pids", usi_pids.join(","), usi_cookies.expire_time.week);
					usi_app.cart.items.forEach(function(product, index){
						var prop;
						if (index >= 3) return;
						for (prop in product) {
							if (product.hasOwnProperty(prop)) {
								usi_cookies.set(cart_prefix + prop + "_" + (index + 1), product[prop], usi_cookies.expire_time.week);
							}
						}
					});
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.scrape_subtotal_us = function() {
			try {
				var subtotal = document.querySelector('footer p.dhig-typography-headline-small');
				if (subtotal != null) {
					subtotal = subtotal.textContent;
					return subtotal.replace(/[^0-9.]/g, '');
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.scrape_cart_us = function() {
			try {
				return usi_dom.get_elements('div.checkout--product-bar[data-line-item]').map(function(container){
					var product = {};
					product.pid = container.getAttribute('data-line-item');
					product.image = container.querySelector("img").src;
					product.name = container.querySelector("img").alt;
					product.qty = container.querySelector("input[id*='checkout--product-bar--info-column--quantity--']").value;
					product.price = container.querySelector("h5[data-testid]").textContent.trim();
					return product;
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.scrape_odm_cart = function () {
			var prod_array = [];
			try {
				if (localStorage.getItem('cart') != null) {
					var ls_cart = JSON.parse(localStorage.getItem('cart'))[usi_app.get_locale()]['offers'];
					var cart_rows = document.querySelectorAll('div[data-testid*="product-line-item"]');
					for (var i = 0; i < cart_rows.length; i++) {
						var product = {};
						product.type = ls_cart[i]['termCode'];
						if (product.type == "A01") {
							product.type = "1-year";
						} else if (product.type == "A02") {
							product.type = "1-month";
						} else if (product.type == "A06") {
							product.type = "3-year";
						}
						product.qty = ls_cart[i]['quantity'].toString();
						product.plc = ls_cart[i]['offeringCode'];
						product.product_id = ls_cart[i]['offeringId'];
						product.pic = cart_rows[i].querySelector('img').src;
						product.name = cart_rows[i].querySelector('img').alt;
						product.price = cart_rows[i].querySelector('p[data-testid=formatted-calculated-price] > span').innerText;
						prod_array.push(product);
					}
					usi_commons.log(prod_array);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return prod_array;
		};
		usi_app.scrape_guac_cart = function () {
			try {
				// Extract PLC list from window object
				usi_app.pids_in_cart = "";
				var plcs = [];
				if (utag_data && utag_data['product_line_list_pipe_delimiter']) {
					if (utag_data['product_line_list_pipe_delimiter'].indexOf('|') !== -1) {
						plcs = utag_data['product_line_list_pipe_delimiter'].split('|');
					} else {
						plcs.push(utag_data['product_line_list_pipe_delimiter']);
					}
				} else if (utag_data && utag_data['products_line'] && utag_data['products_line'].length > 0){
					plcs.push(utag_data['products_line'][0].toUpperCase());
				}
				var cart_rows = document.getElementsByClassName("checkout--product-bar");
				var prod_array = [], i, product, last_plc;
				for (i = 0; i < cart_rows.length; i++) {
					product = {};
					if (cart_rows[i].getElementsByClassName("checkout--product-bar--info-column--name-sub-column--image-container--badge").length > 0) {
						product.pic = cart_rows[i].getElementsByClassName("checkout--product-bar--info-column--name-sub-column--image-container--badge")[0].src;
						if (product.pic.indexOf("http") != -1) {
							if (cart_rows[i].querySelector("#product-term, #term") != null) {
								product.type = cart_rows[i].querySelectorAll("#product-term option, #term option")[cart_rows[i].querySelector("#product-term, #term").selectedIndex].textContent.toLowerCase();
							} else {
								product.type = cart_rows[i].getElementsByClassName("checkout--product-bar--info-column--name-sub-column--term-description")[0].getElementsByTagName("span")[0].textContent.trim();
							}
							// JAPAN translate
							if (usi_app.locale === 'ja-JP' && typeof product.type != "undefined") {
								if (product.type.indexOf("1 \u30F5\u6708") != -1) {
									product.type = "1 \u30F5\u6708";
								} else if (product.type.indexOf("3 \u5E74") != -1) {
									product.type = "3 \u5E74";
								} else if (product.type.indexOf("\u5E74") != -1) {
									product.type = "1 \u5E74";
								}
							}
							product.type_full = product.type;
							if (cart_rows[i].querySelector(".checkout--product-bar--info-column--name-sub-column--promo-title") != null) {
								product.type_full = cart_rows[i].querySelector(".checkout--product-bar--info-column--name-sub-column--promo-title").textContent.trim();
							} else if (cart_rows[i].querySelector(".checkout--product-bar--info-column--name-sub-column--term-description") != null) {
								product.type_full = cart_rows[i].querySelector(".checkout--product-bar--info-column--name-sub-column--term-description").textContent.trim();
							}
							product.name = cart_rows[i].getElementsByClassName("checkout--product-bar--info-column--name-sub-column--name")[0].textContent.trim();
							product.product_id = cart_rows[i].getAttribute("data-line-item");
							if (usi_app.pids_in_cart != "") usi_app.pids_in_cart += ",";
							usi_app.pids_in_cart += product.product_id;
							product.qty = "1";
							var qty_el = cart_rows[i].querySelector('input[name="quantity-' + product.product_id + '"]') != null ? cart_rows[i].querySelector('input[name="quantity-' + product.product_id + '"]') : cart_rows[i].querySelector('input[name*="quantity-"]');
							if (qty_el && qty_el.value) {
								product.qty = qty_el.value;
							}
							if (cart_rows[i].getElementsByClassName("checkout--product-bar--product-price-column--calculated-price").length > 0) {
								product.price = cart_rows[i].getElementsByClassName("checkout--product-bar--product-price-column--calculated-price")[0].innerHTML;
							} else if (cart_rows[i].querySelector('[class*="innerAnchorStyle-Price"]') != null) {
								product.price = cart_rows[i].querySelector('[class*="innerAnchorStyle-Price"]').innerHTML;
							} else if (cart_rows[i].querySelector('[data-testid="formatted-calculated-price"]') != null){
								product.price = cart_rows[i].querySelector('[data-testid="formatted-calculated-price"]').innerHTML;
							} else {
								product.price = "0";
							}
							if (cart_rows[i].querySelector('[class*="innerAnchorStyle-strikeThrough-Price"]') != null) {
								product.old_price = cart_rows[i].querySelector('[class*="innerAnchorStyle-strikeThrough-Price"]').innerHTML;
							} else if (cart_rows[i].getElementsByClassName("checkout--product-bar--product-price-column--promotion-price").length > 0) {
								product.old_price = product.price;
								product.price = cart_rows[i].getElementsByClassName("checkout--product-bar--product-price-column--promotion-price")[0].innerHTML;
							}
							var promo = cart_rows[i].querySelectorAll(".show-for-large-up .checkout--product-bar--info-column--name-sub-column--promo-title");
							if (promo.length > 1) {
								product.promo = promo[promo.length - 1].innerHTML.trim();
							}
							if (typeof plcs[i] !== "undefined") {
								product.plc = plcs[i];
								last_plc = plcs[i];
							}
							// Scrape terms
							product.terms = {};
							var term_options = cart_rows[i].querySelectorAll('#product-term option');
							if (term_options && term_options.length > 0) {
								term_options.forEach(function (option_el) {
									if (option_el && option_el.getAttribute('value') && option_el.textContent) {
										if (usi_app.locale === 'ja-JP') {
											product.terms[option_el.textContent] = option_el.getAttribute('value');
											if (option_el.textContent.indexOf("1 \u30F5\u6708") != -1) {
												product.terms["1 MONTH"] = option_el.getAttribute('value');
											} else if (option_el.textContent.indexOf("3\u5E74") != -1) {
												product.terms["3 YEAR"] = option_el.getAttribute('value');
											} else if (option_el.textContent.indexOf("\u5E74") != -1) {
												product.terms["1 YEAR"] = option_el.getAttribute('value');
											}
										} else {
											product.terms[option_el.textContent] = option_el.getAttribute('value');
										}
									}
								});
							}
							prod_array.push(product);
						}
					}
				}
				return prod_array;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.scrape_dr_cart = function () {
			try {
				usi_app.pids_in_cart = "";
				if (typeof (dr_currentProdsInOrder) != "undefined") {
					for (var p = 0; p < dr_currentProdsInOrder.split(",").length; p++) {
						if (usi_app.pids_in_cart != "") usi_app.pids_in_cart += ",";
						usi_app.pids_in_cart += dr_currentProdsInOrder.split(",")[p].split("?")[1];
					}
				}
				var cart_rows = document.getElementsByClassName("product-row");
				var prod_array = [], i, product;
				var found = 0;
				for (i = 0; i < cart_rows.length; i++) {
					product = {};
					if (cart_rows[i].getElementsByClassName("dr_productThumbnail").length == 0) {
						break;
					}
					product.pic = cart_rows[i].getElementsByClassName("dr_productThumbnail")[0].src;
					if (product.pic.indexOf("http") != -1) {
						product.name = cart_rows[i].getElementsByClassName("dr_productThumbnail")[0].alt.replace(/([(\[]).*([)\]])/, "").trim();
						product.name_dr_full = cart_rows[i].getElementsByClassName("dr_productThumbnail")[0].alt;
						if (/(1 |3 )?(year|monthly) subscription/i.test(product.name)) {
							product.type = product.name.match(/(1 |3 )?(year|monthly)/i)[0].replace(/monthly/i, "Month");
							product.name = product.name.replace(/(1 |3 )?(year|monthly) subscription/i, "").trim();
						} else if (/suscripci\u00F3n.*(a\u00F1o|mensual)/i.test(product.name)) {
							product.type = product.name.match(/(1 |3 )?(a\u00F1o|mensual)/i)[0];
							product.name = product.name.replace(/suscripci\u00F3n.*(a\u00F1o|mensual)/i, "").trim();
						} else if (/((de 1 |de 3 )?ano|mensal)/i.test(product.name)) {
							product.type = product.name.match(/((de 1 |de 3 )?ano|mensal)/i)[0];
							product.name = product.name.replace(/((de 1 |de 3 )?ano|mensal)/i, "").trim();
							if (product.name.indexOf("mensal") !== -1) product.type = product.type.replace("ano", "mensal");
						} else if (/((([13])\uB144)|\uC6D4\uBCC4)/i.test(product.name)) {
							product.type = product.name.match(/((([13])\uB144)|\uC6D4\uBCC4)/i)[0];
							product.name = product.name.substring(0, product.name.indexOf(product.type)).trim();
							product.type = product.type.replace(/(\d)/, "$1 ");
						} else if (product.name.indexOf("3 \u5E74") != -1) {
							product.type = "3 \u5E74";
							product.name = product.name.split("3 \u5E74")[0].trim();
						} else if (product.name.indexOf("\u5E74") != -1) {
							product.type = "1 \u5E74";
							product.name = product.name.split("\u5E74")[0].trim();
						} else if (product.name.indexOf("3 y\u0131ll\u0131k Abonelik") != -1){
							product.type = "3 y\u0131ll\u0131k Abonelik";
							product.name = product.name.split("3 y\u0131ll\u0131k Abonelik")[0].trim();
						} else if (product.name.indexOf("y\u0131ll\u0131k Abonelik") != -1){
							product.type = "1 y\u0131ll\u0131k Abonelik";
							product.name = product.name.split("y\u0131ll\u0131k Abonelik")[0].trim();
						}
						product.qty = "1";
						if (cart_rows[i].getElementsByClassName("dr_qtyInput").length > 0) {
							product.qty = cart_rows[i].getElementsByClassName("dr_qtyInput")[0].value;
						} else if (cart_rows[i].getElementsByClassName("prod-Quantity").length > 0) {
							product.qty = cart_rows[i].getElementsByClassName("prod-Quantity")[0].innerHTML.replace(/[^0-9.]+/g, "")
						}
						product.price = cart_rows[i].getElementsByClassName("prod-total")[0].innerHTML;
						// remove the first div/mobile label
						product.price = product.price.substring(product.price.indexOf("</div>") + 6);
						// if there is an old price, remove it. save old price
						if (product.price.indexOf("<del>") != -1) {
							product.old_price = product.price.substring(product.price.indexOf("<del>") + 5, product.price.indexOf("</del>"));
							product.price = product.price.substring(product.price.indexOf("</span>") + 7).trim();
						}
						// keep everything before the first span close tag
						if (product.price.indexOf("</span>") != -1) {
							product.price = product.price.substring(0, product.price.indexOf("</span>") + 7).trim();
						}
						// remove the span thats around the price
						if (product.price.indexOf("<span>") != -1 && product.price.indexOf("</span>") != -1) {
							product.price = product.price.substring(product.price.indexOf("<span>") + 6, product.price.indexOf("</span>")).trim();
						}
						if (product.price == product.old_price) product.old_price = "";

						if (cart_rows[i].getElementsByClassName("dr_salesPitch").length > 0) {
							product.promo = cart_rows[i].getElementsByClassName("dr_salesPitch")[0].innerHTML.trim();
						}
						product.product_id = usi_app.pids_in_cart.split(",")[i];

						// Get PLC
						product.plc = '';
						if (window['utag'] && window['utag']['data'] && window['utag']['data']['cp.dtSa']) {
							var temp = window['utag']['data']['cp.dtSa'].split('plc=')[1];
							if (temp && temp.split('|')[0]) {
								temp = temp.split('|')[0];
								if (temp.indexOf('&') !== -1) temp = temp.split('&')[0];
								product.plc = temp;
								usi_app.plc = product.plc;
							}
						}
						if (usi_cookies.read_cookie("gc_ss_adskkr") && sessionStorage["dr_" + usi_cookies.read_cookie("gc_ss_adskkr") + "_cartData"]) {
							usi_app.plc = JSON.parse(sessionStorage["dr_" + usi_cookies.read_cookie("gc_ss_adskkr") + "_cartData"]).cart.lineItems.lineItem[0].product.parentProduct.externalReferenceId.split("-")[0];
						}
						if (product.name.indexOf('AutoCAD - ') !== -1 && product.name.indexOf('including specialized toolsets') !== -1) {
							product.plc = "ACDIST";
							usi_app.plc = product.plc;
						} else if (product.name.indexOf('AutoCAD - ') !== -1) {
							product.plc = "ACD";
							usi_app.plc = product.plc;
						} else if (product.name.indexOf('Maya') != -1) {
							product.plc = "MAYA";
							usi_app.plc = product.plc;
						} else if (product.name.indexOf('3ds Max') != -1) {
							product.plc = "3DSMAX";
							usi_app.plc = product.plc;
						} else if (product.name.indexOf('Revit') != -1) {
							product.plc = "RVT";
							usi_app.plc = product.plc;
						} else if (product.name.indexOf('Civil 3D') != -1) {
							product.plc = "CIV3D";
							usi_app.plc = product.plc;
						} else if (product.name.indexOf("AutoCAD LT") != -1) {
							product.plc = "ACDLT";
							usi_app.plc = product.plc;
						}
						found++;
						prod_array.push(product);

						// [ NEW ] Set CN PLC - Need this here because ACD does not get scraped properly
						var name_el = cart_rows[i].querySelector('.product-name.dr_prodName');
						if (name_el && name_el.textContent) {
							// ACD
							if (name_el.textContent.indexOf('AutoCAD including specialized toolsets') !== -1) {
								usi_app.plc = "ACD";
							} else if (name_el.textContent.indexOf('Media') !== -1 && name_el.textContent.indexOf('Entertainment Collection') !== -1) {
								usi_app.plc = "MECOLL";
							} else if (name_el.textContent.indexOf('Revit') !== -1) {
								usi_app.plc = "RVT";
							} else if (name_el.textContent.indexOf('Civil 3D') !== -1) {
								usi_app.plc = "CIV3D";
							} else if (name_el.textContent.indexOf('Navisworks') !== -1) {
								usi_app.plc = "NAVMAN";
							} else if (name_el.textContent.indexOf('Fusion 360') !== -1) {
								if (!usi_app.plc) usi_app.plc = "F360";
							}
						}

						// [ NEW ] Save special PLC for promo TT copy
						if (usi_app.locale === 'en-IN') {
							var special_plcs = ['ACD', 'ACDLT', 'MAYA', 'AECCOL'];
							if (special_plcs.indexOf(usi_app.plc) !== -1) {
								usi_cookies.set('usi_special_plc', usi_app.plc, usi_cookies.expire_time.day);
								usi_commons.log('[ scrape_dr_cart ] * * * usi_special_plc:', usi_app.plc);
							}
						} else if (usi_app.locale === 'zh-CN') {
							var special_plcs = ['ACD', 'MAYA', '3DSMAX'];
							if (special_plcs.indexOf(usi_app.plc) !== -1) {
								usi_cookies.set('usi_special_plc', usi_app.plc, usi_cookies.expire_time.day);
								usi_commons.log('[ scrape_dr_cart ] * * * usi_special_plc:', usi_app.plc);
							}
						}
						if (!product.plc) product.plc = usi_app.plc;
					}
				}
				return prod_array;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		/*
		usi_app.monitor_for_odm_payment_page = function () {
			try {
				if (usi_app.is_payment_page() && usi_app.products.length > 0) {
					usi_commons.log('[ monitor_for_guac_payment_page ] Payments page detected');
					setTimeout(function() {
						usi_app.perform_actions_for_guac_payment_page();
					}, 1500);
				} else {
					setTimeout(usi_app.monitor_for_odm_payment_page, 3000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		 */
		usi_app.monitor_for_guac_payment_page = function () {
			try {
				if (usi_app.is_payment_page() && usi_app.products.length > 0) {
					usi_commons.log('[ monitor_for_guac_payment_page ] Payments page detected');
					setTimeout(function() {
						usi_app.perform_actions_for_guac_payment_page();
					}, 1500);
				} else {
					setTimeout(usi_app.monitor_for_guac_payment_page, 3000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.monitor_for_dr_payment_page = function () {
			try {
				//Monitor for Page 3
				if (usi_app.is_payment_page() && usi_app.products.length > 0) {
					usi_commons.log('[ monitor_for_dr_payment_page ] Payments page detected');
					usi_app.perform_actions_for_dr_payment_page();
				} else {
					setTimeout(usi_app.monitor_for_dr_payment_page, 2000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		/*
		usi_app.perform_actions_for_odm_payment_page = function () {
			try {
				usi_commons.log('[ perform_actions_for_odm_payment_page ] Loading solutions on odm payments page - loading:', usi_app.loading);
				if (typeof (usi_app.upsell_loaded) === "undefined") {
					usi_app.upsell_loaded = true;
					usi_app.upsells_guac();
				}
				//Just upsell campaigns for now 10/12/23
				if (usi_app.loading == 0) {
					usi_app.guac_delay_load();
				} else {
					setTimeout(usi_app.monitor_for_odm_payment_page, 3000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		*/
		usi_app.perform_actions_for_guac_payment_page = function () {
			try {
				if (usi_app.suppress_delay_load || usi_cookies.value_exists("usi_suppress_modal")) return;
				usi_commons.log('[ perform_actions_for_guac_payment_page ] Loading solutions on guac payments page - loading:', usi_app.loading);
				if (typeof (usi_app.upsell_loaded) === "undefined") {
					usi_app.upsell_loaded = true;
					usi_app.upsells_guac();
				}
				if (usi_app.loading == 0) {
					usi_app.guac_delay_load();
				} else {
					setTimeout(usi_app.monitor_for_guac_payment_page, 3000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.perform_actions_for_dr_payment_page = function () {
			try {
				if (usi_app.suppressf360) return;
				// Clean up previous solutions
				if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') {
					usi_js.cleanup();
				}

				// Check if we need to do a locale redirect
				var key = usi_app.get_locale_redirect_key();
				key += '_rebrand';
				if(["pt-BR", "es-AR", "es-MX"].indexOf(usi_app.locale) != -1 && (usi_app.plc == "ACD" || usi_app.plc == "ACDIST")){
					if (usi_commons.is_mobile) usi_commons.load_view("WQQyBnFTKKbuUrne4X5tHxq", "30151", usi_app.locale + key);
					else usi_commons.load_view("yVgCFhqDcscGL3KqUnbfumi", "30141", usi_app.locale + key);
				} else if (["pt-BR", "es-AR"].indexOf(usi_app.locale) != -1) {
					if (usi_commons.is_mobile) usi_commons.load_view("WQQyBnFTKKbuUrne4X5tHxq", "30151", usi_app.locale + key);
					else usi_commons.load_view("yVgCFhqDcscGL3KqUnbfumi", "30141", usi_app.locale + key);
				} else if (["ko-KR", "en-IN", "en-MY", "zh-CN"].indexOf(usi_app.locale) != -1) {
					if (usi_app.locale === 'ko-KR' && usi_cookies.value_exists('usi_suppress_kr')) return;
					if (usi_commons.is_mobile) usi_commons.load_view("VaTh5jw8Yqu4cmDkcwerSec", "30157", usi_app.locale + key);
					else usi_commons.load_view("q6S0CfQIIS8p5t9KLFJWU6q", "30147", usi_app.locale + key);
				} else if (["en-SE"].indexOf(usi_app.locale) != -1) {
					if (usi_commons.is_mobile) usi_commons.load_view("Aa42Q40FWvn0GbnP3HpUQN9", "30153", usi_app.locale + key);
					else usi_commons.load_view("sOhme1oOrJywRQ1XZqybhGS", "30143", usi_app.locale + key);
				} else if (["en-SG"].indexOf(usi_app.locale) != -1) {
					if (usi_commons.is_mobile) usi_commons.load_view("VaTh5jw8Yqu4cmDkcwerSec", "30157", usi_app.locale + key);
					else usi_commons.load_view("q6S0CfQIIS8p5t9KLFJWU6q", "30147", usi_app.locale + key);
				} else if (["tr-TR"].indexOf(usi_app.locale) != -1) {
					if (usi_commons.is_mobile) usi_commons.load_view("D8DYr4G1qx3gqe95Igch2DF", "30159", usi_app.locale + key);
					else usi_commons.load_view("X4gGtOHjv4sbHM0CNLSpdZn", "30149", usi_app.locale + key);
				} else if (["es-MX"].indexOf(usi_app.locale) != -1) {
					if (usi_commons.is_mobile) usi_commons.load_view("WQQyBnFTKKbuUrne4X5tHxq", "30151", usi_app.locale + key);
					else usi_commons.load_view("yVgCFhqDcscGL3KqUnbfumi", "30141", usi_app.locale + key);
				} else if (["en-AU", "en-NZ"].indexOf(usi_app.locale) != -1) {
					if (usi_commons.is_mobile) usi_commons.load_view("U754YIxIignUCcGiL6waBGE", "30155", usi_app.locale + key);
					else usi_commons.load_view("6xhiBCvHYpsHSBK4ousYycP", "30145", usi_app.locale + key);
				} else {
					usi_commons.load_script(usi_commons.domain + "/launch/blank.jsp?autodesk_unknown_locale=" + usi_app.locale + key);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.upsells_odm = function () {
			try {
				var usi_options = {};
				if(usi_app.products.length == 0) return;
				usi_app.products.forEach(function (prod, i) {
					// Only fetch data for last product in cart
					if (i === usi_app.products.length - 1) {
						usi_app.get_upsell_info_dynamic(prod, function (upsell) {
							usi_options.product_id = prod.product_id;
							usi_options.node = document.querySelectorAll('ul.checkout--cart-product-list div[data-testid*="product-line-item"]')[i]
							usi_options.qty = prod.qty;
							if(upsell.upsell_pid != null && usi_app.bundle_offers[upsell.upsell_pid] != null) usi_options.bundle_key = upsell.upsell_pid;
							if(usi_app.usi_load_compat && upsell.bundle_offer && upsell.bundle_offer.copy) {
								usi_options.text = upsell.bundle_offer.copy;
								usi_options.cta = upsell.bundle_offer.cta;
							}
							usi_app.load_upsell(usi_options, prod.name_dr_full);
						});
					}
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.upsells_guac = function () {
			try {
				usi_commons.log("[USI] upsells_guac()");
				if (usi_app.is_odm_cart) {
					if (usi_app.locale != "en-AU" && usi_app.locale != "en-NZ") {
						//We don't have the upsells for any locale except en-AU or en-NZ
						return;
					}
				}
				var usi_options = usi_app.upsell_text_setter();
				if (usi_options.cta != "") {
					if(usi_app.products && usi_app.check_all_for_suppression(usi_app.products)) return;
					if (!usi_cookies.value_exists('usi_suppress_collections') && usi_app.locale == "en-US") {
						var collections_key = usi_app.check_collections_upgrade();
						if (collections_key) {
							usi_commons.load_view("QWSJdoCwfPck76cY19PokBL", "42730", collections_key);
							return;
						}
					}

					// [ Cloud Upsells ] Interject here to see if we should load single item upsell for APAC/ANZ
					if (!usi_cookies.value_exists("usi_suppress_cloud_upsell") && typeof usi_app.cloud_products_upsell_matrix[usi_app.locale] !== "undefined") {
						// Exit function here if cloud upsell available
						if (usi_app.check_cloud_upsells()) {
							usi_commons.log("[USI] Cloud Upsell Found. (Guac)");
							return;
						}
					}

					usi_app.products.forEach(function (prod, i) {
						// Only fetch data for last product in cart
						if (i === usi_app.products.length - 1) {
							usi_app.get_upsell_info_dynamic(prod, function (upsell) {
								usi_app.plc = prod.plc;
								if (upsell) {
									usi_commons.log('[ upsells_guac ] upsell:', upsell);
									if (upsell.upsell_type === 'bundle') {
										// Bundle upsell banner
										usi_commons.log('[ upsells_guac ] bundle_offer:', upsell.bundle_offer);
										usi_options.product_id = prod.product_id;
										usi_options.node = document.getElementsByClassName("checkout--product-bar")[i];
										var str_key = '"' + upsell.upsell_pid + '"';
										usi_options.func = 'usi_app.apply_bundle_guac(' + upsell.bundle_offer.url + ',' + str_key + ',' + prod.product_id + ');';
										usi_options.url = upsell.bundle_offer.url;
										usi_options.text = upsell.bundle_offer.copy;
										usi_options.cta = upsell.bundle_offer.cta;
										usi_options.bundle_key = upsell.upsell_pid;
										usi_app.load_upsell(usi_options, prod);
									} else if (upsell.upsell_type === 'yearly') {
										// 1yr -> 3yr upsell banner
										usi_options.product_id = prod.product_id;
										usi_options.node = document.getElementsByClassName("checkout--product-bar")[i];
										usi_options.func = "usi_app.switch_items_guac(" + prod.product_id + "," + upsell.upsell_pid + ");";
										usi_app.load_upsell(usi_options, prod);
									} else if (upsell.upsell_type === 'monthly') {
										// 1mo -> 1yr upsell banner
										if (["en-US", "en-CA", "fr-CA"].indexOf(usi_app.locale) != -1) {
											usi_options = usi_app.upsell_text_setter_monthly(usi_options);
											usi_options.product_id = prod.product_id;
											usi_options.node = document.getElementsByClassName("checkout--product-bar")[i];
											usi_options.func = "usi_app.switch_items_guac_monthly(" + prod.product_id + "," + upsell.upsell_pid + ");";
											usi_options.type = "monthly";
											usi_app.load_upsell(usi_options, prod, true);
										}
									}
								}
							});
						}
					});
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.upsells_dr = function () {
			try {
				var names = document.getElementsByClassName("product-name dr_prodName");
				if (names.length == 0) return;
				var usi_options = usi_app.upsell_text_setter();
				if (usi_options.cta != "") {
					if(!usi_app.products || usi_app.check_all_for_suppression(usi_app.products)) return;
					// -------------------------------------------------------------------------
					// -------------------------------------------------------------------------
					// [ Cloud Upsells ] Interject here to see if we should load single item upsell for India & Korea (special cart page)
					if (!usi_cookies.value_exists("usi_suppress_cloud_upsell") && typeof usi_app.cloud_products_upsell_matrix[usi_app.locale] !== "undefined") {
						// Exit function here if cloud upsell available
						if (usi_app.check_cloud_upsells()){
							usi_commons.log("[USI] Cloud Upsell Found. (DR)");
							return;
						}
					}
					// -------------------------------------------------------------------------
					// -------------------------------------------------------------------------

					usi_app.products.forEach(function (prod, i) {
						// Only fetch data for last product in cart
						if (i === usi_app.products.length - 1) {
							var plc = usi_app.get_plc(prod.product_id);
							if (!plc && !prod.plc) {
								usi_commons.log('[ upsells_dr ] Wait for PLC');
								setTimeout(function () {
									usi_app.upsells_dr();
								}, 1000);
							} else {
								prod.plc = plc || usi_app.plc;
								usi_app.get_upsell_info_dynamic(prod, function (upsell) {
									usi_app.delete_link = names[i].parentNode.parentNode.getElementsByClassName("dr_deleteItemLink")[0].href;
									usi_options.product_id = prod.product_id;
									usi_options.node = document.getElementsByClassName("product-row")[i];
									usi_options.qty = prod.qty;
									if(upsell.upsell_pid != null && usi_app.bundle_offers[upsell.upsell_pid] != null) usi_options.bundle_key = upsell.upsell_pid;
									if(usi_options.bundle_key) usi_options.func = "usi_app.switch_items_store_cart_domain("+ '"' + usi_options.bundle_key + '"' + ");";
									if(usi_app.usi_load_compat && upsell.bundle_offer && upsell.bundle_offer.copy) {
										usi_options.text = upsell.bundle_offer.copy;
										usi_options.cta = upsell.bundle_offer.cta;
										usi_options.url = upsell.bundle_offer.url;
									}
									else {
										usi_options.func = "usi_app.switch_items_dr(" + prod.product_id + "," + upsell.upsell_pid + "," + prod.qty + ");";
									}
									usi_app.load_upsell(usi_options,prod.name_dr_full);
								});
							}
						}
					});
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.get_upsell_info_dynamic = function (prod, cb) {
			try {
				usi_commons.log('[ get_upsell_info_dynamic ] prod:', prod);
				if (typeof usi_app.plc != "undefined") prod['plc'] = usi_app.plc;
				if (prod.product_id && prod.plc && prod.type && prod.qty && typeof cb === "function") {
					// Check for bundle upsell
					if ((["en-US", "en-CA", "fr-CA"].indexOf(usi_app.locale) != -1 && (prod.plc === 'ACDIST' || prod.plc === 'ACDLT')) ||
						(["en-NZ", "en-AU"].indexOf(usi_app.locale) != -1 && (prod.plc === 'ACDIST' || prod.plc === 'ACDLT')) ||
						(["en-MY", "en-SG", "ko-KR","zh-CN"].indexOf(usi_app.locale) != -1 && (prod.plc === 'ACDIST' || prod.plc === 'ACDLT' || prod.plc === 'ACD')) ||
						(["en-UK", "en-SE"].indexOf(usi_app.locale) != -1 && (prod.plc === 'ACDIST' || prod.plc === 'ACDLT')) ||
						(usi_app.emea.indexOf(usi_app.locale) != -1 && (prod.plc === 'ACDIST' || prod.plc === 'ACDLT'))) {
						if (prod.type.indexOf("Y") != -1 || prod.type.indexOf("M") != -1) prod.type = prod.type.toLowerCase();
						var bundle_key = prod.plc + '_' + usi_app.locale + '_' + prod.type.replace(' ', '-');
						//fix
						if(usi_app.emea.indexOf(usi_app.locale) != -1 || ["zh-CN", "ko-KR"].indexOf(usi_app.locale) != -1){
							if(bundle_key.indexOf('_1') != -1) bundle_key = bundle_key.split('_1')[0] + "_1-year";
							if(bundle_key.indexOf('_3') != -1) bundle_key = bundle_key.split('_3')[0] + "_3-year";
						}
						usi_commons.log('[USI] checking bundle_key:', bundle_key);
						if ((typeof usi_app.bundle_offers[bundle_key] !== "undefined" && usi_app.bundle_offers[bundle_key].qty.indexOf(prod.qty) !== -1)) {
							if(usi_app.apac.indexOf(usi_app.locale) != -1 || usi_app.anz.indexOf(usi_app.locale) != -1 || ["tr-TR", "en-SE"].indexOf(usi_app.locale) != -1) {
								usi_app.usi_load_compat = true;
							}
							usi_commons.log('[USI] bundle found. bundle_key:', bundle_key);
							cb({
								upsell_pid: bundle_key,
								upsell_type: 'bundle',
								plc: prod.plc,
								bundle_offer: usi_app.bundle_offers[bundle_key]
							});
							return;
						}
					}

					if(usi_app.is_odm_cart) return;

					// Check for 1yr & 3yr upsell
					usi_app.get_json_extra(prod, function (json_extra) {
						usi_commons.log('[ get_upsell_info_dynamic ] json_extra:', json_extra);
						if (json_extra) {
							var upsell_pid, upsell_type;
							for (var prop in json_extra) {
								if (Object.prototype.hasOwnProperty.call(json_extra, prop)) {
									if (prod.product_id === json_extra[prop]) {
										if (prop === '1y') {
											upsell_pid = json_extra['3y'];
											upsell_type = 'yearly';
										} else if (prop === '1m') {
											upsell_pid = json_extra['1y'];
											upsell_type = 'monthly';
										}
									}
								}
							}
							if (upsell_pid) {
								cb({
									upsell_pid: upsell_pid,
									upsell_type: upsell_type,
									plc: prod.plc
								});
							}
						} else {
							// Fall back on pid lists
							if (usi_app.upsell_pids_list[prod.product_id]) {
								cb({
									upsell_pid: usi_app.upsell_pids_list[prod.product_id],
									upsell_type: 'yearly',
									plc: prod.plc
								});
							} else if (usi_app.upsell_pids_list_monthly[prod.product_id]) {
								cb({
									upsell_pid: usi_app.upsell_pids_list_monthly[prod.product_id],
									upsell_type: 'monthly',
									plc: prod.plc
								});
							}
						}
					});
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.load_upsell = function (options, prod, monthly) {
			try {
				if (usi_app.suppressf360) return;
				if(usi_app.check_all_for_suppression(usi_app.products)) return;
				usi_commons.log('[ load_upsell ] options:', options);
				usi_commons.log('[ load_upsell ] prod:', prod);

				var usi_upsell_div = document.createElement("div");
				usi_upsell_div.setAttribute("class", "usi_upsell_div");

				usi_app.append_upsell_link = "";
				usi_app.upsell_inpage = {};
				var key = (typeof monthly !== "undefined") ? usi_app.locale + '_monthly' : usi_app.locale;

				// [11/28] Scheduled pause for EMEA, UK, US and CA
				if(usi_date.is_after('2023-12-01T00:00') && usi_app.americas.indexOf(usi_app.locale) != -1) return;
				if(usi_date.is_after('2024-01-31T15:00') && (usi_app.emea.indexOf(usi_app.locale) != -1 || usi_app.uk.indexOf(usi_app.locale) != -1)) return;

				if (typeof (usi_app.options) == "undefined" && usi_commons.device == "desktop" && usi_cookies.get("usi_upsell_displayed") == null) {
					usi_app.options = options;
					// Americas
					if (usi_app.americas.indexOf(usi_app.locale) != -1) {
						if (options.bundle_key) {
							if (usi_cookies.value_exists("usi_aff_suppress")) return;
							// Set bundle upsell config
							usi_commons.log("[USI] bundle identified. Loading 37045.");
							usi_app.upsell_inpage.hash = "I9YBxYPEPZnJsKRRcYVOVPM";
							usi_app.upsell_inpage.siteID = "37045";
							key = options.bundle_key;
						} else {
							if (usi_cookies.value_exists("usi_suppress_upsell") || usi_cookies.value_exists("usi_aff_suppress")) return;
							usi_app.upsell_inpage.hash = "NqXdwJIIhBZqFByv6V3dlLJ";
							usi_app.upsell_inpage.siteID = "31809";
						}
					}
					// EMEA
					else if (usi_app.emea.indexOf(usi_app.locale) != -1) {
						usi_app.usi_load_compat = false; // set to true once we migrate all locales to config pointer instead of autoload.jsp
						if(options.bundle_key){
							if (usi_cookies.value_exists("usi_aff_suppress")) return;
							usi_commons.log("[USI] bundle identified. Loading ");
							usi_app.upsell_inpage.hash = "Dvs5VtEsekKMC97KyAMcVSs";
							usi_app.upsell_inpage.siteID = "48415";
							key = options.bundle_key;
						} else {
							if (usi_cookies.value_exists("usi_suppress_upsell") || usi_cookies.value_exists("usi_aff_suppress")) return;
							usi_app.upsell_inpage.hash = "HLEKFiXoGtHqkNMuBUmG403";
							usi_app.upsell_inpage.siteID = "31823";
						}
					}
					// ANZ
					else if (usi_app.anz.indexOf(usi_app.locale) != -1) {
						usi_app.usi_load_compat = true;
						if (options.bundle_key) {
							if (usi_cookies.value_exists("usi_aff_suppress")) return;
							usi_commons.log("[USI] bundle identified. Loading 43739");
							usi_app.upsell_inpage.hash = "UqyN3ZSE3PaS8IbOfyaoPut";
							usi_app.upsell_inpage.siteID = "43739";
							key = options.bundle_key;
						} else{
							if (usi_cookies.value_exists("usi_suppress_upsell") || usi_cookies.value_exists("usi_aff_suppress")) return;
							usi_app.upsell_inpage.hash = "yaOTagKuyOVbjQW7XZykIar";
							usi_app.upsell_inpage.siteID = "31839";
						}
						usi_commons.log("[USI] site ID:",usi_app.upsell_inpage.siteID);
					}
					// UK
					else if (usi_app.uk.indexOf(usi_app.locale) != -1) {
						usi_app.usi_load_compat = false; // set to true once we migrate all locales to config pointer instead of autoload.jsp
						if(options.bundle_key){
							if (usi_cookies.value_exists("usi_aff_suppress")) return;
							usi_commons.log("[USI] bundle identified. Loading ");
							usi_app.upsell_inpage.hash = "TLkBWPCa1Ullhjl1OhZUpV5";
							usi_app.upsell_inpage.siteID = "48353";
							key = options.bundle_key;
						} else {
							if (usi_cookies.value_exists("usi_suppress_upsell") || usi_cookies.value_exists("usi_aff_suppress")) return;
							usi_app.upsell_inpage.hash = "lF2HyuutKt8vLMYCgyXbCTB";
							usi_app.upsell_inpage.siteID = "31843";
						}
					}
					// APAC (no overlay)
					else if (usi_app.apac.indexOf(usi_app.locale) != -1) {
						usi_app.usi_load_compat = true;
						if (options.bundle_key) {
							if (usi_cookies.value_exists("usi_suppress_upsell") || usi_cookies.value_exists("usi_aff_suppress")) return;
							usi_commons.log("[USI] bundle identified. Loading 43737");
							usi_app.upsell_inpage.hash = "rPT4lc7nzLmG3lQN3QO5DWP";
							usi_app.upsell_inpage.siteID = "43737";
							key = options.bundle_key;
						} else {
							if (usi_cookies.value_exists("usi_suppress_upsell") || usi_cookies.value_exists("usi_aff_suppress")) return;
							usi_app.upsell_inpage.hash = "Z6p6PsyC1SEVAMCjGveVMoe";
							usi_app.upsell_inpage.siteID = "31847";
							usi_commons.log("OPTIONS:",options);
						}
						usi_commons.log("[USI] site ID:",usi_app.upsell_inpage.siteID);
					}
				}

				if (usi_app.upsell_inpage && usi_app.upsell_inpage.hash && usi_app.upsell_inpage.siteID && typeof(options) !== "undefined" && typeof(options.node) !== "undefined") {
					usi_commons.log("[USI] Applying inpage campaign");
					// Load inpage banner
					if(usi_app.usi_load_compat){
						if(document.querySelector(".wd-strikethrough") == null) {
							usi_app.bundle_options = options;
							if(typeof usi_load != 'undefined') delete usi_load;
							usi_commons.log("[USI] Loading Campaign", usi_app.upsell_inpage.siteID, "// Key:", key);
							usi_commons.load(usi_app.upsell_inpage.hash, usi_app.upsell_inpage.siteID, key);
						}
					}
					else {
						usi_commons.log("[USI] Old Loader Loading");
						//legacy code. phasing out as of 9/25/22
						usi_commons.load_script(usi_commons.domain + "/autoload.jsp?hash=" + usi_app.upsell_inpage.hash + "&siteID=" + usi_app.upsell_inpage.siteID + "&keys=" + key, function () {
							if (typeof usi_autoload === "undefined" && usi_app.loading !== 63857) return;
							usi_app.place_css([
								'.usi_inpage_upsell { background: #333333 !important; width: 100%; color: #fff !important; padding: 5px 10px 4px 10px; clear: both; margin-top: 4px; }',
								'.usi_inpage_upsell span { text-decoration: underline; cursor: pointer; font-weight: bold; color: #fff !important;}',
								'.usi_inpage_upsell .usi_tos { text-decoration: underline; cursor: pointer; float: right; color: white !important; }',
								'.usi_promo_icon { enable-background: new 0 0 27.9 28; display: table-cell; height: 15px; width: 15px; vertical-align: top; float: left; fill: #fff !important; margin-right: 10px; margin-top: 1px; }',
								'.cart-widget .item .usi_upsell_div { margin: 0 20px 20px 20px; }',
								'.cart-widget .item:last-of-type .usi_upsell_div { margin: 20px 0 0 0; }'
							].join(""));
							var promo_icon = '<svg  viewBox="0 0 27.9 28" x="0px" y="0px" class="usi_promo_icon" xml:space="preserve" width="100%" height="100%"><path d="M13.6,0h-8L0,5.8v8l14.3,13.8l13.3-13.2L13.6,0z M6,8.1c-1.2,0-2.2-1-2.2-2.2s1-2.2,2.2-2.2c1.2,0,2.2,1,2.2,2.2S7.2,8.1,6,8.1z"></path></svg>';
							var style = usi_app.dr_cart ? 'display: inline-block; margin-top: 10px;' : '';
							if (options['tos'] && options['tos_link']) {
								usi_upsell_div.innerHTML = "<div style='" + style + "'  class=\"usi_inpage_upsell\">" + promo_icon + " " + options.text + " <span onclick='usi_app.remove_bar();" + options.func + "'>" + options.cta + "</span><a class='usi_tos' style='color: white !important; text-decoration-color: white !important;' target='_blank' href='" + options['tos_link'] + "'>" + options['tos'] + "</a></div>";
							} else {
								usi_upsell_div.innerHTML = "<div style='" + style + "'  class=\"usi_inpage_upsell\">" + promo_icon + " " + options.text + " <span onclick='usi_app.remove_bar();" + options.func + "'>" + options.cta + "</span></div>";
							}
							if (options.node.getElementsByClassName("usi_upsell_div").length == 0) {
								options.node.appendChild(usi_upsell_div);
							} else {
								options.node.getElementsByClassName("usi_upsell_div")[0].innerHTML = usi_upsell_div.innerHTML;
							}
						});
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.guac_delay_load = function () {
			try {
				if (usi_app.suppressf360 || usi_app.collection_dest_link) return;
				if(usi_app.check_all_for_suppression(usi_app.products)) return;
				// Clean up previous solutions
				if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') {
					usi_js.cleanup();
				}

				// Check if we need to do a locale redirect
				var key = usi_app.get_locale_redirect_key();
				key += '_rebrand';

				if(["en-US", "en-CA"].indexOf(usi_app.locale) != -1 && (usi_app.plc == "ACD" || usi_app.plc == "ACDIST")){
					key = (Math.random() > .5) ? "_splitb" : "_rebrand";
					if (usi_commons.is_mobile) usi_commons.load_view("WQQyBnFTKKbuUrne4X5tHxq", "30151", usi_app.locale + key);
					else usi_commons.load_view("yVgCFhqDcscGL3KqUnbfumi", "30141", usi_app.locale + key);
				}else if(["fr-CA"].indexOf(usi_app.locale) != -1 && (usi_app.plc == "ACD" || usi_app.plc == "ACDIST")){
					if (usi_commons.is_mobile) usi_commons.load_view("WQQyBnFTKKbuUrne4X5tHxq", "30151", usi_app.locale + key);
					else usi_commons.load_view("yVgCFhqDcscGL3KqUnbfumi", "30141", usi_app.locale + key);
				} else if (["fr-CA", "en-CA", "es-MX"].indexOf(usi_app.locale) != -1) {
					if (usi_commons.is_mobile) usi_commons.load_view("WQQyBnFTKKbuUrne4X5tHxq", "30151", usi_app.locale + key);
					else usi_commons.load_view("yVgCFhqDcscGL3KqUnbfumi", "30141", usi_app.locale + key);
				} else if (["en-UK"].indexOf(usi_app.locale) != -1) {
					if (usi_commons.is_mobile) usi_commons.load_view("Aa42Q40FWvn0GbnP3HpUQN9", "30153", usi_app.locale + key);
					else usi_commons.load_view("sOhme1oOrJywRQ1XZqybhGS", "30143", usi_app.locale + key);
				} else if (["en-AU", "en-NZ"].indexOf(usi_app.locale) != -1) {
					if (usi_commons.is_mobile) usi_commons.load_view("U754YIxIignUCcGiL6waBGE", "30155", usi_app.locale + key);
					else usi_commons.load_view("6xhiBCvHYpsHSBK4ousYycP", "30145", usi_app.locale + key);
				} else if (usi_app.emea.indexOf(usi_app.locale) != -1) {
					if (usi_commons.is_mobile) usi_commons.load_view("D8DYr4G1qx3gqe95Igch2DF", "30159", usi_app.locale + key);
					else usi_commons.load_view("X4gGtOHjv4sbHM0CNLSpdZn", "30149", usi_app.locale + key);
				} else if (usi_app.locale == "ja-JP" && (key == "_rebrand" || key == "_redirect_rebrand")) {
					if (usi_commons.is_mobile) usi_commons.load_view("VaTh5jw8Yqu4cmDkcwerSec", "30157", usi_app.locale + key);
					else usi_commons.load_view("q6S0CfQIIS8p5t9KLFJWU6q", "30147", usi_app.locale + key);
				} else if (["en-SG", "en-MY", "ja-JP"].indexOf(usi_app.locale) != -1) {
					if (usi_commons.is_mobile) usi_commons.load_view("VaTh5jw8Yqu4cmDkcwerSec", "30157", usi_app.locale + key);
					else usi_commons.load_view("q6S0CfQIIS8p5t9KLFJWU6q", "30147", usi_app.locale + key);
				} else {
					usi_commons.load_script(usi_commons.domain + "/launch/blank.jsp?autodesk_unknown_locale=" + usi_app.locale);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.is_payment_page = function () {
			try {
				if(usi_app.is_odm_cart){
					return document.querySelector('div.container-odm-accordion-cart-MuiPaper-root.Mui-expanded') != null;
				} else if (usi_app.efulfilment) {
					return document.querySelector(".billing .accordion.active, .confirm .accordion.active") != null;
				} else if (usi_app.dr_cart) {
					try {
						if (document.getElementById("tosAccepted") != null) return true;
						else if (document.getElementsByClassName('step-2 wizard-option').length > 0 && document.getElementsByClassName('step-2 wizard-option')[0].className.indexOf('active') != -1) return true;
						else if (document.querySelector(".billing .accordion.active, .confirm .accordion.active") != null) return true;
						else if (document.querySelector(".payment .accordion.active") != null) return true;
						else if ((["en-US", "pt-BR", "es-MX", "en-CA", "fr-CA", "es-AR","tr-TR"]).indexOf(usi_app.locale) != -1) return true;
					} catch (err) {
						usi_commons.report_error(err);
					}
					return false;
				} else if (usi_app.guac_cart) {
					var payment_section = document.getElementsByClassName("checkout--payment-section--toggleable")[0];
					if (payment_section != null && (["en-US", "pt-BR", "es-MX", "en-CA", "fr-CA", "es-AR"]).indexOf(usi_app.locale) == -1) {
						return payment_section.dataset['watPageSectionEnabled'] == "true";
					}
					return document.getElementsByClassName("checkout--payment-section--toggleable") != null;
				} else {
					return location.href.indexOf("payment/method") != -1 || location.href.indexOf("/cart/review") != -1;
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.scrape_product_page = function () {
			try {
				var product = {};
				product.link = location.protocol + '//' + location.host + location.pathname;
				if (window.utag_data) {
					// name
					if (utag_data.prod_name) {
						product.name = utag_data.prod_name;
						product.price = 'n/a';
						product.image = 'n/a';
					}
					// pid
					var locale = '';
					if (utag_data && utag_data.locale) {
						locale = utag_data.locale;
						if (usi_app.locale == "") usi_app.locale = locale;
					}
					var plc = '';
					if (utag_data && utag_data.prod_id) {
						plc = utag_data.prod_id;
						usi_app.plc = plc;
					}
					if (locale && plc) {
						product.pid = locale + '_' + plc;
					}
					// extra
					var extra = {};
					if (plc) {
						if (utag_data.products_analytics_values && utag_data.products_analytics_values.length && utag_data.products_analytics_values.length >= 3) {
							for (var i=0;i<utag_data.products_analytics_values.length; i++) {
								var usi_val = utag_data.products_analytics_values[i];
								if (usi_val.indexOf("1:month") != -1 &&  usi_val.split(":")[1] != "na") {
									extra['1m'] = usi_val.split(":")[1];
								}
								if (usi_val.indexOf("1:year") != -1 &&  usi_val.split(":")[1] != "na") {
									extra['1y'] = usi_val.split(":")[1];
								}
								if (usi_val.indexOf("3:year") != -1 &&  usi_val.split(":")[1] != "na") {
									extra['3y'] = usi_val.split(":")[1];
								}
							}
							extra['new'] = '1';
							if (typeof(extra['1m']) === "undefined" || typeof(extra['1y']) === "undefined" || typeof(extra['3y']) === "undefined") return null;
						} else if (utag_data.product_id && utag_data.product_id.length && utag_data.product_id.length >= 3) {
							extra['3y'] = utag_data.product_id[0];
							extra['1y'] = utag_data.product_id[1];
							extra['1m'] = utag_data.product_id[2];
							extra['old'] = '1';
						}
						product.extra = JSON.stringify(extra);
						usi_app.update_plc_map(plc, extra);
					}
				}
				return product;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.rescrape_cart = function () {
			try {
				usi_commons.log("[USI] rescrape_cart()");
				if (!usi_app.is_confirmation_page) {
					if (usi_app.is_odm_cart){
						usi_app.products = usi_app.set_rescrape(usi_app.scrape_odm_cart, true);
						//setTimeout(function() {usi_app.upsells_odm();},2000);
					} else if (usi_app.guac_cart) {
						usi_app.find_cart_reference();
						usi_app.products = usi_app.set_rescrape(usi_app.scrape_guac_cart, true);
					} else if (usi_app.dr_cart && usi_app.dr_cart_available) {
						usi_app.products = usi_app.set_rescrape(usi_app.scrape_dr_cart, true);
						usi_app.upsells_dr();
					}
					usi_app.extract_plcs();
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.extract_plcs = function () {
			try {
				if (usi_app.products && usi_app.products.length > 0) {
					var plc_map = usi_cookies.get_json('usi_plc_map') || {};
					usi_app.plcs_in_cart = [];
					usi_app.products.forEach(function (prod) {
						if (prod['plc'] && usi_app.locale == "ko-KR") delete prod['plc'];
						if (usi_cookies.value_exists("usi_last_plc") && usi_app.locale == "tr-TR") prod['plc'] = usi_cookies.get("usi_last_plc");

						// Set plc via cookie if available
						if (!prod['plc'] && prod['product_id'] && plc_map[prod['product_id']]) {
							prod['plc'] = plc_map[prod['product_id']];
						} else if(!prod['plc'] && prod['product_id']){
							try {
								//check session storage for PLC data
								function getNames(objects){return Object.keys(objects);}
								var cart_data_trait = getNames(JSON.parse(JSON.stringify(sessionStorage))).filter(function (v) {return v.indexOf("_cartData") > -1});
								if(cart_data_trait.length > 0) {
									var line_items = JSON.parse(sessionStorage[cart_data_trait]).cart.lineItems.lineItem;
									var current_item = line_items.filter(function (v) {return v.product.id == prod.product_id});
									if(current_item.length > 0 && current_item[0].product && current_item[0].product.parentProduct && current_item[0].product.parentProduct.externalReferenceId) {
										prod['plc'] = current_item[0].product.parentProduct.externalReferenceId.split("-")[0];
									}
								}
							} catch (err) {
								usi_commons.report_error(err);
							}
						}
						if (prod['plc']) {
							usi_app.plcs_in_cart.push(prod['plc']);
							if (!usi_app.plc) {
								usi_app.plc = prod['plc'];
								usi_cookies.set('usi_last_plc', usi_app.plc, usi_cookies.expire_time.week);
							}
						}
					});
				}
				usi_commons.log('[ extract_plcs ] products:', usi_app.products);
				usi_commons.log('[ extract_plcs ] plcs_in_cart:', usi_app.plcs_in_cart);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.update_plc_map = function (plc, ids) {
			try {
				usi_commons.log('[ update_plc_map ] plc:', plc);
				usi_commons.log('[ update_plc_map ] ids:', ids);
				var plc_map = usi_cookies.get_json('usi_plc_map') || {};
				for (var prop in ids) {
					if (Object.prototype.hasOwnProperty.call(ids, prop)) plc_map[ids[prop]] = plc;
				}
				usi_commons.log('[ update_plc_map ] map:', plc_map);
				usi_cookies.set_json('usi_plc_map', plc_map, usi_cookies.expire_time.week);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.apply_event_listener_recheck_cart = function (target, action) {
			try {
				usi_app.events_bound = true;
				var target_elements = document.querySelectorAll(target);
				if (target_elements && target_elements.length > 0) {
					for (var i = 0; i < target_elements.length; i++) {
						target_elements[i].addEventListener(action, function () {
							var plc = this.getAttribute('data-wat-val');
							if (plc && plc.indexOf(':') !== -1) {
								usi_cookies.set('usi_last_plc', plc.split(':')[0], usi_cookies.expire_time.week);
							}
						});
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.look_for_locale_modal = function () {
			try {
				var modal_cta = document.querySelector('a[data-wat-linkname="view on local site"]');
				if (modal_cta && modal_cta.href) {
					var url = modal_cta.href;
					var copy = modal_cta.textContent.trim();
					usi_commons.log('[ look_for_locale_modal ] Locale redirect modal found!');
					usi_cookies.set("usi_locale_redirect_url", encodeURIComponent(url), usi_cookies.expire_time.hour);
					usi_cookies.set("usi_locale_redirect_copy", usi_app.encode_unicode(copy), usi_cookies.expire_time.hour);
					usi_commons.log('[ look_for_locale_modal ] copy (original):', copy);
					usi_commons.log('[ look_for_locale_modal ] copy (encoded):', usi_app.encode_unicode(copy));
					usi_commons.log('[ look_for_locale_modal ] url:', encodeURIComponent(url));
				} else {
					setTimeout(function () {
						usi_app.look_for_locale_modal();
					}, 1000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.close_on_idle_modal = function () {
			try {
				var idle_modal = document.getElementById("checkout--liveagent--modal");
				if (idle_modal != null) {
					var observer = new MutationObserver(function () {
						// sessionStorage.getItem("nonsensitiveHasProactiveChatLaunched") == "true"
						if (typeof usi_js != "undefined" && idle_modal.className.indexOf("wd-modal-hidden") == -1) {
							usi_js.close();
							observer.disconnect();
						}
					});
					observer.observe(idle_modal, {attributes: true});
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.check_all_for_suppression = function(prod_array){
			if (!prod_array) return false;
			var suppressed_found = false;
			prod_array.forEach(function(v){
				if(!usi_app.is_forced && (v.name == "Flex")){
					usi_commons.log("[USI] USI Suppressed Product Found:",v.name);
					suppressed_found = true;
				}
			})
			return suppressed_found;
		}
		usi_app.get_json_extra = function (prod, cb) {
			try {
				if (prod.plc && typeof cb === "function" && usi_app.locale && usi_app.upsell_plcs.indexOf(prod.plc) !== -1) {
					var new_prod = Object.assign({}, prod);

					var json_extra = {};
					// Use ids scraped from page
					if (new_prod.terms && new_prod.terms['1 YEAR']) {
						json_extra['1y'] = new_prod.terms['1 YEAR'];
						json_extra['3y'] = new_prod.terms['3 YEAR'];
						json_extra['1m'] = new_prod.terms['1 MONTH'];
						cb(json_extra);
						return;
					}
					// Pull pids from recs
					var locale = usi_app.locale;
					var rec_id = locale + '_' + prod.plc;
					usi_commons.log('[ get_json_extra ] Fetching recs for rec_id:', rec_id);
					usi_app.load_product_data({
						siteID: usi_app.recommendation_site_product,
						pid: rec_id,
						force_exact: true,
						callback: function () {
							if (usi_app.product_rec.product0 && usi_app.product_rec.product0.extra) {
								var extra = usi_app.product_rec.product0.extra.replaceAll("&quot;", '"');
								json_extra = JSON.parse(extra);
								if (json_extra) cb(json_extra);
							} else {
								cb();
							}
						}
					});
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.load_product_data = function (options) {
			try {
				var queryStr = "";
				var params = ['siteID', 'association_siteID', 'pid', 'less_expensive', 'rows', 'days_back', 'match', 'nomatch', 'force_exact'];
				params.forEach(function (name, index) {
					if (options[name]) {
						queryStr += (index == 0 ? "?" : "&") + name + '=' + options[name];
					}
				});
				usi_commons.load_script(usi_commons.cdn + '/utility/product_recommendations.jsp' + queryStr, function () {
					if (typeof options.callback === 'function' && typeof usi_app.product_rec !== 'undefined') {
						options.callback(usi_app.product_rec);
					}
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.campaign_persist_callback = function (element, load_function, sid) {
			//used in 43739
			if (document.querySelector(element) == null) {
				usi_commons.log("[USI] Campaign Lost. Reloading Campaign.");
				clearInterval(usi_app.campaign_persist_interval);
				usi_js = undefined;
				usi_app.upsell_loaded = undefined;
				delete window["usi_" + sid];
				usi_app.main();
			}
		}
		usi_app.campaign_persist = function(element, load_function, sid) {
			try {
				usi_app.campaign_persist_interval = setInterval(function(){
					usi_app.campaign_persist_callback(element, load_function, sid);
				}, 1000);
			} catch(err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.remove_bar = function () {
			// Remove existing bar if found
			var bar = document.querySelector('.usi_upsell_div');
			if (bar) bar.parentNode.removeChild(bar);
		};
		usi_app.add_loading_graphic = function (message) {
			try {
				usi_app.remove_loading_graphic();
				var txt = '';
				var usi_loading_container = document.createElement('div');
				var wrapper_dynamic_styles = 'top: 0%; left: 0%; width: 100%; height: 100%;';
				var circle_bg = '<svg style="width: 100px;position: absolute;top: 50%;left: 50%;margin-top: -50px;margin-left: -50px;" class="css-13o7eu2" viewBox="22 22 44 44"><circle style="stroke: #d1d1d1;" class="css-1pw0iqb" cx="44" cy="44" r="20.2" fill="none" stroke-width="1.6" style="stroke-dasharray: 126.92; stroke-dashoffset: 0px;"></circle></svg>';
				var circle_p1 = '<svg style="width: 100px;position: absolute;top: 50%;left: 50%;margin-top: -50px;margin-left: -50px;" class="css-13o7eu2" viewBox="22 22 44 44"><circle style="stroke: #333; stroke-dasharray: 80px, 200px; stroke-dashoffset: 0; animation: 1500ms ease-in-out 0s infinite normal none running MuiCircularProgress-keyframes-circular-dash;" class="css-cuwlx0" cx="44" cy="44" r="20.2" fill="none" stroke-width="1.6"></circle></svg>';
				var gif = [circle_bg, circle_p1].join('');
				usi_loading_container.innerHTML =
					[
						'<div id="usi_loading_graphic" style="position: fixed; ' + wrapper_dynamic_styles + ' background: rgba(228,228,228,0.5); z-index: 100000;">',
						txt,
						gif,
						'</div>'
					].join('');
				var css = document.createElement("style");
				css.textContent = "@keyframes MuiCircularProgress-keyframes-circular-dash{"+
					"0% { stroke-dasharray: 1px,200px;  stroke-dashoffset: 0px; }"+
					"50% { stroke-dasharray: 100px,200px;  stroke-dashoffset: -15px; }"+
					"100% { stroke-dasharray: 100px,200px;  stroke-dashoffset: -125px; }"+
					"}";
				document.body.appendChild(css);
				document.body.appendChild(usi_loading_container);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.remove_loading_graphic = function () {
			try {
				var loading_el = document.getElementById('usi_loading_graphic');
				if (loading_el != null) loading_el.parentNode.removeChild(loading_el);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.link = function (options) {
			try {
				if (typeof(usi_autoload) !== "undefined") {
					usi_cookies.set("usi_click_id", usi_autoload.id, 30*24*60*60, true);
				}
				usi_commons.log("[USI] usi_app.link")
				var internal = usi_commons.domain + "/autolink.jsp?hash=" + usi_app.upsell_inpage.hash + "&siteID=" + usi_app.upsell_inpage.siteID + "&keys=" + usi_app.locale;
				var aff = options.aff + (options.destination ? encodeURIComponent(options.destination) : "");
				window.location = internal + "&uselink=" + encodeURIComponent(aff);
			} catch (err) {
				usi_commons.report_error(err);
			}
		}
		usi_app.place_css = function (css) {
			var usi_css = document.createElement("style");
			usi_css.type = "text/css";
			if (usi_css.styleSheet) usi_css.styleSheet.cssText = css;
			else usi_css.innerHTML = css;
			document.getElementsByTagName('head')[0].appendChild(usi_css);
		};
		usi_app.check_collections_upgrade = function () {
			if (usi_app.locale === 'en-US' && usi_app.plcs_in_cart.length > 0) {
				usi_commons.log('[ check_collections_upgrade ] Check collections eligibility for:', usi_app.plcs_in_cart);

				// Check collection eligibility
				var check_arr = [
					{
						collection: 'AECCOL',
						products: ['CIV3D', 'ACDIST', 'RVT', 'IW360P', 'NAVMAN', 'BM36DP'],
						pids: {
							'1Y': '36109',
							'3Y': '36115',
							'1M': '36101'
						}
					},
					{
						collection: 'MECOLL',
						products: ['3DSMAX', 'MAYA', 'ARNOL', 'MOBPRO', 'MBXPRO'],
						pids: {
							'1Y': '36039',
							'3Y': '36034',
							'1M': '36006'
						}
					}
				];

				var count = 0, collection;
				for (var i = 0; i < check_arr.length; i++) {
					var check_obj = check_arr[i];
					count = 0;
					usi_app.plcs_in_cart.forEach(function (plc) {
						var idx = check_obj.products.indexOf(plc);
						if (idx !== -1) {
							check_obj.products.splice(idx, 1);
							count++;
						}
					});
					if (count >= 2) {
						collection = check_obj;
						break;
					}
				}
				usi_commons.log('[ check_collections_upgrade ] count:', count);
				usi_commons.log('[ check_collections_upgrade ] collection:', collection);

				// Process collection
				if (collection) {

					// Get visitor id
					var visitor_id;
					if (utag_data) visitor_id = utag_data['qp.visitorid'] || utag_data['event_id'];

					// Set dynamic term based on cart item
					var term = '1Y';
					if (usi_app.products && usi_app.products.length > 0 && usi_app.products[0].type) {
						var encoded = encodeURIComponent(usi_app.products[0].type.trim());
						if (encoded === '3%20year') {
							term = '3Y';
						} else if (encoded === '1%20month') {
							term = '1M';
						}
					}

					// Build destination link
					var dest_link = 'https://checkout.autodesk.com/' + usi_app.locale + '?priceIds=' + collection.pids[term] + '&plc=' + collection.collection + '&visitorId=' + visitor_id;
					usi_commons.log('[ check_collections_upgrade ] dest_link:', dest_link);
					usi_app.collection_dest_link = usi_app.aff_links[usi_app.locale] + "?url=" + encodeURIComponent(dest_link);
					usi_commons.log('[ check_collections_upgrade ] collection_dest_link:', usi_app.collection_dest_link);

					// Return config key
					return usi_app.locale + '_' + collection.collection + '_' + term + '_' + usi_commons.device;
				}
			}
		};
		usi_app.remove_odm_cart_item = function (pid, cb){
			//
			try{
				// 'pid' is item to be removed (Ex: OD-000249)
				var old_cart = localStorage.getItem('cart');
				var new_cart = JSON.parse(old_cart);
				var offers = JSON.parse(old_cart)['en-AU']['offers'];
				var locale = usi_app.get_locale();

				if(offers.filter(function(o){ return o['offeringId'] == pid; }).length == 0){
					usi_commons.log('PID Not found!');
					cb();
				}

				usi_app.offer_qty = offers.filter(function(o){ return o['offeringId'] == pid; })[0]['quantity'];
				usi_app.offer_term = offers.filter(function(o){ return o['offeringId'] == pid; })[0]['termCode'];

				offers = offers.filter(function(o){ return o['offeringId'] != pid; });
				new_cart[locale]['offers'] = offers;
				console.log("New Cart: ", new_cart);
				new_cart = JSON.stringify(new_cart);
				localStorage.setItem('cart', new_cart);
				cb();
			} catch(err){
				usi_commons.report_error(err);
			}
		};
		usi_app.remove_item = function (pid, hide_loading) {
			try {
				if (pid) {
					var selector = document.querySelector('[data-line-item="' + pid + '"] button[data-testid="close-button"]');
					if (!selector) selector = document.querySelector('[data-line-item="' + pid + '"] button[data-testid="modal-close-button"]');
					if (selector) {
						selector.disabled = false;
						selector.click();
						if (!hide_loading) usi_app.add_loading_graphic("");
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.link_switch_item = function (options) {
			try {
				// Set cookies
				usi_cookies.set("usi_suppress_upsell", "1");
				// Remove item
				usi_app.remove_item(options.pid);
				// Add promo item
				usi_app.check_for_empty_cart(function (){
					setTimeout(function () {
						// Add promo item to cart
						if (typeof(usi_autoload) !== "undefined") {
							usi_cookies.set("usi_click_id", usi_autoload.id, 30*24*60*60, true);
						}
						usi_commons.log("[USI] link_switch_item")
						var internal = usi_commons.domain + "/autolink.jsp?hash=" + usi_app.upsell_inpage.hash + "&siteID=" + usi_app.upsell_inpage.siteID + "&keys=" + usi_app.locale + usi_app.upsell_key;
						var aff = options.aff + (options.destination ? encodeURIComponent(options.destination) : "");
						window.location = internal + "&uselink=" + encodeURIComponent(aff);
					}, 1000);
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.check_for_empty_cart = function (cb) {
			try {
				var empty_cart_el = document.querySelector('#checkout .checkout--empty-cart--text');
				if (empty_cart_el && empty_cart_el.textContent) {
					cb();
				} else {
					setTimeout(function () {
						usi_app.check_for_empty_cart(cb);
					}, 1000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.switch_items_guac = function (pid_from, pid_to) {
			try {
				var selector = document.querySelector('[data-line-item="' + pid_from + '"] select');
				var option_3;
				selector.querySelectorAll("option").forEach(function (opt) {
					if (opt.textContent.indexOf("3") != -1) option_3 = opt;
				});
				if (selector && option_3) {
					selector.value = option_3.value;
					var event = new Event("change", {bubbles: true});
					selector.dispatchEvent(event);
				}
				usi_app.switch_to = pid_to;
				usi_app.switch_from = pid_from;
				usi_cookies.set("usi_suppress_upsell", '1');
				usi_app.upsell_key = "";
				usi_app.add_prod_guac();
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.switch_items_guac_monthly = function (pid_from, pid_to) {
			try {
				var selector = document.querySelector('div[data-line-item="' + pid_from + '"] #product-term');
				var yearly_option;
				selector.querySelectorAll("option").forEach(function (opt) {
					if (opt.value == pid_to) yearly_option = opt;
				});
				if (selector && yearly_option) {
					selector.value = yearly_option.value;
					var event = new Event("change", {bubbles: true});
					selector.dispatchEvent(event);
				}
				usi_app.switch_to = pid_to;
				usi_app.switch_from = pid_from;
				usi_cookies.set("usi_suppress_upsell", '1');
				usi_app.upsell_key = "_monthly";
				usi_app.add_prod_guac();
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.add_prod_guac = function () {
			try {
				if (usi_app.upsell_inpage.hash && usi_app.upsell_inpage.siteID) {
					var aff = usi_app.aff_links[usi_app.locale];
					var locale = (usi_app.locale == "en-UK") ? "en-GB" : usi_app.locale;
					var mvar = usi_app.get_mvar(usi_app.switch_from) || ("afc_" + usi_app.locale + "_" + usi_app.plc.toLowerCase() + "_usi_my3");
					var usi_pid_link = location.protocol + '//' + location.host + "/" + locale + "?mktvar004=" + mvar + usi_app.append_upsell_link;
					if (typeof (usi_js) != "undefined" && usi_cookies.get("usi_banner_click") != null) {
						usi_js.deep_link(usi_pid_link.replace("_my3", "_3yearbanner"));
					} else {
						if (typeof(usi_autoload) !== "undefined") {
							usi_cookies.set("usi_click_id", usi_autoload.id, 30*24*60*60, true);
						}
						usi_commons.log("[USI] add_prod_guac")
						var link = usi_commons.domain + "/autolink.jsp?hash=" + usi_app.upsell_inpage.hash + "&siteID=" + usi_app.upsell_inpage.siteID + "&keys=" + usi_app.locale + usi_app.upsell_key + "&uselink=" + encodeURIComponent(aff + "?url=" + encodeURIComponent(usi_pid_link));
						usi_cookies.set('usi_force_redirect', link);
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.check_cloud_upsells = function () {
			try {
				// We are in one of the targeted locales, check for target products
				usi_app.usi_cloud_upsell_options = null;
				var list = usi_app.cloud_products_upsell_matrix[usi_app.locale];
				for (var i = 0; i < list.length; i++) {
					if (list[i].targets.indexOf(usi_app.plc) !== -1) {
						// Target item found in cart
						usi_commons.log('[ check_cloud_upsells ] Target PLC found in cart:', usi_app.plc);
						usi_app.usi_cloud_upsell_options = {
							text: list[i].text,
							cta: list[i].cta,
							upsell: list[i].upsell,
							region: list[i].region,
							func: 'usi_app.add_cloud_upsell_item();'
						}
						break;
					}
				}
				if (usi_app.usi_cloud_upsell_options) {
					usi_app.process_cloud_upsells();
					return true;
				} else {
					return false;
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.process_cloud_upsells = function () {
			try {
				if (usi_app.usi_cloud_upsell_options) {
					usi_commons.log('[ process_cloud_upsells ] ---------------------');
					usi_commons.log('[ process_cloud_upsells ] ---------------------');
					// Set term and node based on products in cart
					usi_app.products.forEach(function (prod, i) {
						//Set node where upsell banner will be placed
						if (document.getElementsByClassName("checkout--product-bar").length > 0) {
							usi_app.usi_cloud_upsell_options.node = document.getElementsByClassName("checkout--product-bar")[i];
						} else if (document.querySelectorAll('div[data-testid*="product-line-item"]').length > 0) {
							usi_app.usi_cloud_upsell_options.node = document.querySelectorAll('div[data-testid*="product-line-item"]')[i];
						} else if (document.querySelectorAll('div.mobile-container div.product-row').length > 0){
							usi_app.usi_cloud_upsell_options.node = document.querySelectorAll('div.mobile-container div.product-row')[i];
						}

						if (prod.type) {
							var encoded = encodeURIComponent(prod.type);
							usi_app.usi_cloud_upsell_options.term = encoded.toUpperCase().replace('%20', '-');
							usi_commons.log('[ upsells_guac ] type: ' + prod.type + ' encoded: ' + encoded);
							if (encoded === '1%20%E5%B9%B4' || encoded === '1%20%EB%85%84') {
								usi_app.usi_cloud_upsell_options.term = "1-YEAR";
							} else if (encoded === '1%20%E3%83%B5%E6%9C%88' || encoded === '%EC%9B%94%EB%B3%84') {
								usi_app.usi_cloud_upsell_options.term = "1-MONTH";
							} else if (encoded === '3%20%E5%B9%B4' || encoded === '3%20%EB%85%84') {
								usi_app.usi_cloud_upsell_options.term = "3-YEAR";
							}
						}
					});

					// Special node location for India & Korea carts
					if (usi_app.locale === "en-IN" || usi_app.locale === "en-SE" || usi_app.locale == "en-SG") {
						usi_app.usi_cloud_upsell_options.node = document.querySelector('.summary .mobile-container');
					} else if (usi_app.locale === "ko-KR") {
						usi_app.usi_cloud_upsell_options.node = document.querySelector('#dr_QuickBuyCart .responsive-cart-container .product-row');
					} else if (usi_app.locale === "en-MY") {
						usi_app.usi_cloud_upsell_options.node = document.querySelector('#dr_QuickBuyCart .responsive-cart-container .product-row');
					}

					// Set key, hash, & site
					usi_app.usi_cloud_upsell_options.key = usi_app.locale + "_" + usi_app.usi_cloud_upsell_options.upsell;
					if (usi_app.usi_cloud_upsell_options.region === 'APAC' && !usi_cookies.value_exists("usi_aff_suppress")) {
						usi_app.usi_cloud_upsell_options.hash = "kFDO5dFehbzXRKfpQ6htniL";
						usi_app.usi_cloud_upsell_options.siteID = "42318";
					} else if (usi_app.usi_cloud_upsell_options.region === 'ANZ' && !usi_cookies.value_exists("usi_aff_suppress")) {
						usi_app.usi_cloud_upsell_options.hash = "XNypi88ekzudVKvrDXUv3bU";
						usi_app.usi_cloud_upsell_options.siteID = "42334";
					} else if (usi_app.usi_cloud_upsell_options.region === 'AMERICAS' && !usi_cookies.value_exists("usi_aff_suppress")) {
						usi_app.usi_cloud_upsell_options.hash = "jqmv097zIE07e5woq22KKq6";
						usi_app.usi_cloud_upsell_options.siteID = "42630";
					} else if (usi_app.usi_cloud_upsell_options.region === 'EMEA' && !usi_cookies.value_exists("usi_aff_suppress")) {
						usi_app.usi_cloud_upsell_options.hash = "JmMrUwld4jBNlrKqS3kzmAZ";
						usi_app.usi_cloud_upsell_options.siteID = "42632";
					} else if (usi_app.usi_cloud_upsell_options.region === 'UK' && !usi_cookies.value_exists("usi_aff_suppress")) {
						usi_app.usi_cloud_upsell_options.hash = "TDsp2c0Ytmn6JbFBeAZOuTn";
						usi_app.usi_cloud_upsell_options.siteID = "42634";
					}

					// Load upsell banner
					usi_commons.log('[ upsells_guac ] Cloud upsell options:');
					usi_commons.log(usi_app.usi_cloud_upsell_options);

					// Unable to add 1yr to 3yr for en-SE
					if (usi_app.locale === 'en-SE' && usi_app.usi_cloud_upsell_options.term === "3-YEAR") {
						return;
					}

					if (usi_app.usi_cloud_upsell_options.node) {
						usi_app.load_cloud_upsell();
					} else {
						usi_commons.log_error('[ process_cloud_upsells ] ERROR: node is undefined');
					}

				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.load_cloud_upsell = function () {
			try {
				if (usi_app.usi_cloud_upsell_options.hash && usi_app.usi_cloud_upsell_options.siteID) {
					var usi_upsell_div = document.createElement("div");
					usi_upsell_div.setAttribute("class", "usi_upsell_div");

					// Remove existing bar if found
					var bar = usi_app.usi_cloud_upsell_options.node.querySelector('.usi_upsell_div');
					if (bar) bar.parentNode.removeChild(bar);

					// Load inpage banner
					if (usi_app.usi_load_compat) {
						usi_commons.load(usi_app.usi_cloud_upsell_options.hash, usi_app.usi_cloud_upsell_options.siteID, usi_app.usi_cloud_upsell_options.key);
					} else {
						//legacy loading. phasing out as of 9/25/22
						// Special styles for KR
						if (usi_app.locale === "ko-KR" && document.querySelector('.prod-img img.dr_productThumbnail')) {
							document.querySelector('.prod-img img.dr_productThumbnail').style.marginBottom = '5px';
						}
						usi_commons.load_script(usi_commons.domain + "/autoload.jsp?hash=" + usi_app.usi_cloud_upsell_options.hash + "&siteID=" + usi_app.usi_cloud_upsell_options.siteID + "&keys=" + usi_app.usi_cloud_upsell_options.key, function () {
							if (typeof usi_autoload === "undefined" && usi_app.loading !== 63857) return;
							usi_app.place_css([
								'.usi_inpage_upsell { position: relative; background: #333333 !important; width: 100%; color: #fff !important; padding: 5px 10px 4px 10px; clear: both; margin-top: 4px; padding-left: 2em; }',
								'.usi_inpage_upsell span { text-decoration: underline; cursor: pointer; font-weight: bold; color: #fff !important;}',
								'.usi_inpage_upsell .usi_tos { text-decoration: underline; cursor: pointer; float: right; color: white !important; }',
								'.usi_promo_icon { enable-background: new 0 0 27.9 28; display: table-cell; height: 15px; width: 15px; vertical-align: top; float: left; fill: #fff !important; position: absolute; left: 0.5em; top: 0; bottom: 0; margin: auto; }',
								'.cart-widget .item .usi_upsell_div { margin: 0 20px 20px 20px; }',
								'.cart-widget .item:last-of-type .usi_upsell_div { margin: 20px 0 0 0; }'
							].join(""));
							var promo_icon = '<svg  viewBox="0 0 27.9 28" x="0px" y="0px" class="usi_promo_icon" xml:space="preserve" width="100%" height="100%"><path d="M13.6,0h-8L0,5.8v8l14.3,13.8l13.3-13.2L13.6,0z M6,8.1c-1.2,0-2.2-1-2.2-2.2s1-2.2,2.2-2.2c1.2,0,2.2,1,2.2,2.2S7.2,8.1,6,8.1z"></path></svg>';
							usi_upsell_div.innerHTML = "<div class=\"usi_inpage_upsell\">" + promo_icon + " " + usi_app.usi_cloud_upsell_options.text + " <br /><span onclick='" + usi_app.usi_cloud_upsell_options.func + "'>" + usi_app.usi_cloud_upsell_options.cta + "</span></div>";
							if (usi_app.usi_cloud_upsell_options.node.getElementsByClassName("usi_upsell_div").length == 0) {
								usi_app.usi_cloud_upsell_options.node.appendChild(usi_upsell_div);
							}
						});
					}
				} else {
					usi_commons.log('[ load_cloud_upsell ] ERROR: Missing hash or key!');
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.add_cloud_upsell_item = function () {
			try {
				var hash = usi_app.usi_cloud_upsell_options.hash;
				var site = usi_app.usi_cloud_upsell_options.siteID;
				var key = usi_app.usi_cloud_upsell_options.key;
				var plc = usi_app.usi_cloud_upsell_options.upsell;
				var term = usi_app.usi_cloud_upsell_options.term;
				var visitor_id;
				if (utag_data) visitor_id = utag_data['qp.visitorid'] || utag_data['event_id'];
				if (visitor_id && usi_app.aff_links[usi_app.locale] && hash && site && key && term) {
					// Build add url
					var add_url = 'https://commerce.autodesk.com/' + usi_app.locale + '?plc=' + plc + '&quantity=1&term=' + term + '&visitorId=' + visitor_id;
					// -----------------------
					// -------- en-AU --------
					// -----------------------
					if (usi_app.locale === 'en-AU') {
						var offeringId, frequency, termCode, offeringName;
						if (term === '1-MONTH') {
							frequency = 'B03';
							termCode = "A02";
						} else if (term === '1-YEAR') {
							frequency = 'B05';
							termCode = "A01";
						} else if (term === '3-YEAR') {
							frequency = 'B05';
							termCode = "A06";
						}
						if (plc === 'SGSUB') {
							offeringId = "OD-000291";
							offeringName = "ShotGrid - Subscription";
						} else if (plc === 'COLLRP') {
							offeringId = "OD-000125";
							offeringName = "BIM Collaborate Pro";
						}

						if (!offeringId) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: priceIds is undefined!');
							return;
						}
						add_url = "https://checkout.autodesk.com/en-AU/cart?offers=" +
								"[country:AU;currency:AUD;offeringCode:"+plc+";offeringId:"+offeringId+";offeringName:"+offeringName+";priceRegionCode:AH;" +
								"quantity:1;intendedUsageCode:COM;accessModelCode:S;termCode:"+termCode+";connectivityCode:C100;connectivityIntervalCode:C04;servicePlanIdCode:STND;" +
								"billingBehaviorCode:A200;billingTypeCode:B100;billingFrequencyCode:"+frequency+"]";
					}
					// -----------------------
					// -------- ja-JP --------
					// -----------------------
					else if (usi_app.locale === "ja-JP") {
						var priceIds;
						if (plc === 'COLLRP') {
							if (term === '1-YEAR') {
								priceIds = '37002';
							} else if (term === '3-YEAR') {
								priceIds = '37003';
							} else if (term === '1-MONTH') {
								priceIds = '37001';
							}
						} else if (plc === 'SGSUB') {
							if (term === '1-YEAR') {
								priceIds = '37010';
							} else if (term === '3-YEAR') {
								priceIds = '37333';
							} else if (term === '1-MONTH') {
								priceIds = '37008';
							}
						}
						if (!priceIds) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: priceIds is undefined!');
							return;
						}
						add_url = 'https://checkout.autodesk.com/' + usi_app.locale + '?priceIds=' + priceIds;
					}
					// -----------------------
					// -------- en-IN --------
					// -----------------------
					else if (usi_app.locale === 'en-IN') {
						var productID;
						if (plc === 'SGSUB') {
							if (term === '1-YEAR') {
								productID = '5518873800';
							} else if (term === '3-YEAR') {
								productID = '5518873900';
							} else if (term === 'MONTH') {
								productID = '5518872800';
							}
						} else if (plc === 'COLLRP') {
							if (term === '1-YEAR') {
								productID = '5322807000';
							} else if (term === '3-YEAR') {
								productID = '5322807100';
							} else if (term === 'MONTH') {
								productID = '5114914600';
							}
						}
						if (!productID) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: productID is undefined!');
							return;
						}
						if (term === 'MONTH') {
							add_url = 'https://store.autodesk.com/store/adsk/en_IN/buy/productID.' + productID + '/quantity.1/Currency.INR&visitorId=' + visitor_id;
						} else {
							add_url = 'https://store.autodesk.com/store/adskin/en_IN/buy/productID.' + productID + '/quantity.1/Currency.INR&visitorId=' + visitor_id;
						}
					}
					// -----------------------
					// -------- ko_KR --------
					// -----------------------
					else if (usi_app.locale === 'ko-KR') {
						var productID;
						if (plc === 'SGSUB') {
							if (term === '1-YEAR') {
								productID = '5518792600';
							} else if (term === '3-YEAR') {
								productID = '5518792800';
							} else if (term === '1-MONTH') {
								productID = '5518792900';
							}
						} else if (plc === 'COLLRP') {
							if (term === '1-YEAR') {
								productID = '332902900';
							} else if (term === '3-YEAR') {
								productID = '332903100';
							} else if (term === '1-MONTH') {
								productID = '332903300';
							}
						}
						if (!productID) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: productID is undefined!');
							return;
						}
						add_url = 'https://store.autodesk.co.kr/store/adskkr/ko_KR/buy/productID.' + productID + '/quantity.1/Currency.KRW&visitorId=' + visitor_id;
					}
					// -----------------------
					// ------- en-MY ---------
					// -----------------------
					else if (usi_app.locale === 'en-MY') {
						var productID;
						if (plc === 'SGSUB') {
							if (term === '1-YEAR') {
								productID = '5766924300';
							} else if (term === '3-YEAR') {
								productID = '5766924400';
							} else if (term === '1-MONTH') {
								productID = '5766924200';
							}
						} else if (plc === 'COLLRP') {
							if (term === '1-YEAR') {
								productID = '5763030300';
							} else if (term === '3-YEAR') {
								productID = '5763030400';
							} else if (term === '1-MONTH') {
								productID = '5763030200';
							}
						}
						if (!productID) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: productID is undefined!');
							return;
						}
						add_url = 'https://store.autodesk.com/store/adskjp/en_MY/buy/productID.' + productID + '/quantity.1/Currency.MYR&visitorId=' + visitor_id;

						// [1/3] Built for MY test (Remove when we go live)
						if(usi_app.url.indexOf('gc.digitalriver.com') != -1){
							add_url = 'https://gc.digitalriver.com/store/adskjp/en_MY/buy/productID.' + productID + '/quantity.1/Currency.MYR&visitorId=' + visitor_id;
							if(typeof window['ADSK_A'] != 'undefined' && typeof window['ADSK_A']['Currency'] != 'undefined'){
								add_url = add_url.replace('Currency.MYR', 'Currency.' + window['ADSK_A']['Currency']);
							}
						}
					}
					// -----------------------
					// ------- en-SG ---------
					// -----------------------
					else if (usi_app.locale === 'en-SG') {
						var productID;
						if (plc === 'SGSUB') {
							if (term === '1-YEAR') {
								productID = "5776051000";
							} else if (term === '3-YEAR') {
								productID = "5776051100";
							} else if (term === '1-MONTH') {
								productID = "5776050900";
							}
						} else if (plc === 'COLLRP') {
							if (term === '1-YEAR') {
								productID = "332592400";
							} else if (term === '3-YEAR') {
								productID = "332592600";
							} else if (term === '1-MONTH') {
								productID = "332592700";
							}
						}
						if (!productID) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: productID is undefined!');
							return;
						}
						add_url = 'https://store.autodesk.com/store/adsk/en_SG/buy/productID.' + productID + '/quantity.1/Currency.SGD&visitorId=' + visitor_id;
					}
					// -----------------------
					// -------- en-US --------
					// -----------------------
					else if (usi_app.locale === 'en-US') {
						var productID;
						if (plc === 'F36MEIA') {
							if (term === '1-YEAR' || term === '3-YEAR') {
								productID = '27203';
							} else if (term === '1-MONTH') {
								productID = '32485';
							}
						}
						if (!productID) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: productID is undefined!');
							return;
						}
						add_url = 'https://checkout.autodesk.com/en-US?priceIds=' + productID + '&plc=' + plc + '&visitorId=' + visitor_id;
						// https://checkout.autodesk.com/en-US?priceIds=32485&plc=F36MEIA&visitorId=e4ae96bb-0a20-4e8b-89b2-c741ca10f286
					}
					// ------------------------------
					// -------- en-CA, fr-CA --------
					// ------------------------------
					else if (usi_app.locale === 'en-CA' || usi_app.locale === 'fr-CA') {
						var productID;
						if (plc === 'F36MEIA') {
							if (term === '1-YEAR' || term === '3-YEAR' || term === '1-AN' || term === '3-ANS') {
								productID = '28488';
							} else if (term === '1-MONTH' || term === '1-MOIS') {
								productID = '28486';
							}
						}
						if (!productID) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: productID is undefined!');
							return;
						}
						add_url = 'https://checkout.autodesk.com/' + usi_app.locale + '/fusion-360-extension-cart?priceIds=' + productID + '&plc=' + plc + '&visitorId=' + visitor_id;
						// https://checkout.autodesk.com/en-CA/fusion-360-extension-cart?priceIds=26016&plc=F36MEIA
					}
					// -----------------------
					// -------- de-DE --------
					// -----------------------
					else if (usi_app.locale === 'de-DE') {
						var productID;
						if (plc === 'F36MEIA') {
							if (term === '1-JAHR' || term === '3-JAHRE') {
								productID = '27882';
							} else if (term === '1-MONAT') {
								productID = '27867';
							}
						}
						if (!productID) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: productID is undefined!');
							return;
						}
						add_url = 'https://checkout.autodesk.com/' + usi_app.locale + '/fusion-360-extension-cart?priceIds=' + productID + '&plc=' + plc + '&visitorId=' + visitor_id;
						// https://checkout.autodesk.com/de-DE/fusion-360-extension-cart?priceIds=27882&plc=F36MEIA
					}
					// -----------------------
					// -------- en-EU --------
					// -----------------------
					else if (usi_app.locale === 'en-EU') {
						var productID;
						if (plc === 'F36MEIA') {
							if (term === '1-YEAR' || term === '3-YEAR') {
								productID = '27879';
							} else if (term === '1-MONTH') {
								productID = '27824';
							}
						}
						if (!productID) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: productID is undefined!');
							return;
						}
						add_url = 'https://checkout.autodesk.com/' + usi_app.locale + '/fusion-360-extension-cart?priceIds=' + productID + '&plc=' + plc + '&visitorId=' + visitor_id;
						// https://checkout.autodesk.com/en-NL/fusion-360-extension-cart?priceIds=27879&plc=F36MEIA
					}
					// -----------------------
					// -------- it-IT --------
					// -----------------------
					else if (usi_app.locale === 'it-IT') {
						var productID;
						if (plc === 'F36MEIA') {
							if (term === '1-ANNO' || term === '3-ANNI') {
								productID = '27881';
							} else if (term === '1-MESE') {
								productID = '27866';
							}
						}
						if (!productID) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: productID is undefined!');
							return;
						}
						add_url = 'https://checkout.autodesk.com/' + usi_app.locale + '/fusion-360-extension-cart?priceIds=' + productID + '&plc=' + plc + '&visitorId=' + visitor_id;
						// https://checkout.autodesk.com/de-DE/fusion-360-extension-cart?priceIds=27882&plc=F36MEIA
					}
					// -----------------------
					// -------- fr-FR --------
					// -----------------------
					else if (usi_app.locale === 'fr-FR') {
						var productID;
						if (plc === 'F36MEIA') {
							if (term === '1%C2%A0AN' || term === '3%C2%A0ANS') {
								productID = '27880';
							} else if (term === '1%C2%A0MOIS') {
								productID = '27865';
							}
						}
						if (!productID) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: productID is undefined!');
							return;
						}
						add_url = 'https://checkout.autodesk.com/' + usi_app.locale + '/fusion-360-extension-cart?priceIds=' + productID + '&plc=' + plc + '&visitorId=' + visitor_id;
						// https://checkout.autodesk.com/fr-FR/fusion-360-extension-cart?priceIds=27880&plc=F36MEIA
					}
					// -----------------------
					// -------- en-UK --------
					// -----------------------
					else if (usi_app.locale === 'en-UK') {
						var productID;
						if (plc === 'F36MEIA') {
							if (term === '1-YEAR' || term === '3-YEAR') {
								productID = '27391';
							} else if (term === '1-MONTH') {
								productID = '27388';
							}
						}
						if (!productID) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: productID is undefined!');
							return;
						}
						add_url = 'https://checkout.autodesk.com/en-GB/fusion-360-extension-cart?priceIds=' + productID + '&plc=' + plc + '&visitorId=' + visitor_id;
						// https://checkout.autodesk.com/en-GB/fusion-360-extension-cart?priceIds=27391&plc=F36MEIA
					}
					// -----------------------
					// -------- en-SE --------
					// -----------------------
					else if (usi_app.locale === 'en-SE') {
						var productID;
						if (plc === 'F36MEIA') {
							if (term === '1-YEAR' || term === '3-YEAR') {
								productID = '5519802400';
							} else if (term === 'MONTH') {
								productID = '5519802300';
							}
						}
						if (!productID) {
							usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: productID is undefined!');
							return;
						}
						add_url = 'https://store.autodesk.com/store/adsk/en_SE/buy/productID.' + productID + '/quantity.1/Currency.USD&visitorId=' + visitor_id;
					}

					// Build aff link url
					var aff_url = usi_app.aff_links[usi_app.locale] + "?url=" + encodeURIComponent(add_url);
					usi_commons.log('[ add_cloud_upsell_item ] aff_url:', aff_url);

					// Set suppression cookies
					usi_cookies.set("usi_suppress_cloud_upsell", "1");
					usi_cookies.set("usi_suppress_upsell", "1");

					// Remove existing bar
					var bar = usi_app.usi_cloud_upsell_options.node.querySelector('.usi_upsell_div');
					if (bar) bar.parentNode.removeChild(bar);

					// Show loading graphic
					usi_app.add_loading_graphic("");

					// Go to final link
					if (typeof(usi_autoload) !== "undefined") {
						usi_cookies.set("usi_click_id", usi_autoload.id, 30*24*60*60, true);
					}
					var dest = usi_commons.domain + "/autolink.jsp?hash=" + hash + "&siteID=" + site + "&keys=" + key + "&uselink=" + encodeURIComponent(aff_url);
					usi_commons.log('[ add_cloud_upsell_item ] dest:', dest);
					window.location = dest;

				} else {
					usi_commons.log_error('[ add_cloud_upsell_item ] ERROR: Missing required params!');
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.apply_bundle_guac = function (url, key, pid, sid) {
			try {
				if(usi_app.usi_load_compat){
					usi_commons.log("[USI] Testing New Guac Bundle")
					usi_app.remove_item(pid);
					if(!usi_app.el_searching) {
						usi_app.el_searching = setInterval(search_el, 500);
						function search_el() {
							usi_commons.log("[USI] Looking For Element");
							if (document.querySelector("#checkout .checkout--empty-cart--text") != null) {
								clearInterval(usi_app.el_searching);
								usi_app["link_" + sid](url);
							}
						}
					}
				}
				else {
					var aff = usi_app.aff_links[usi_app.locale];
					if (usi_app.upsell_inpage.hash && usi_app.upsell_inpage.siteID && aff && url && key && pid) {
						usi_app.remove_item(pid);
						// Add promo item
						usi_app.check_for_empty_cart(function () {
							setTimeout(function () {
								usi_cookies.set("usi_suppress_upsell", '1');
								if (typeof (usi_autoload) !== "undefined") {
									usi_cookies.set("usi_click_id", usi_autoload.id, 30 * 24 * 60 * 60, true);
								}
								usi_commons.log("[USI] apply bundle guac");
								usi_commons.log("[USI] URL:", url)
								usi_commons.log("[USI] KEY:", key)
								usi_commons.log("[USI] AFF:", aff)
								usi_app.load_js('https://prod.upsellit.com/link.jsp?id=0&cid=3614&sid=' + usi_app.upsell_inpage.siteID + '&duration=2592000&ajax=1');
								window.location = aff + "?url=" + encodeURIComponent(url);
								//window.location = usi_commons.domain + "/autolink.jsp?hash=" + usi_app.upsell_inpage.hash + "&siteID=" + usi_app.upsell_inpage.siteID + "&keys=" + key + "&uselink=" + encodeURIComponent(aff + "?url=" + encodeURIComponent(url));
							}, 1000);
						});
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.load_js = function(js_url) {
			try {
				var USI_headID = document.getElementsByTagName("head")[0];
				var USI_dynScript = document.createElement("script");
				USI_dynScript.setAttribute("id","usi_AJAXScript");
				USI_dynScript.setAttribute("type","text/javascript");
				USI_dynScript.setAttribute("src",js_url);
				USI_headID.appendChild(USI_dynScript);
			} catch(err) {
				if (typeof(usi_commons) !== "undefined") usi_commons.report_error(err);
			}
		}
		usi_app.switch_items_store_cart_domain = function (pid){
			//Only used for tr-TR and en-SE upsells (Completely different cart than others)
			console.log(usi_app.aff_links[usi_app.locale] + "?url=" + encodeURIComponent(usi_app.bundle_offers[pid].url));
			var usi_http_request = new XMLHttpRequest();
			usi_http_request.onreadystatechange = function () {
				if (usi_http_request.readyState == 4 && usi_http_request.status == 200) {
					location.href = usi_app.aff_links[usi_app.locale] + "?url=" + encodeURIComponent(usi_app.bundle_offers[pid].url);
				}
			};
			usi_http_request.open('GET', usi_app.delete_link, true);
			usi_http_request.setRequestHeader('Content-Type', 'application/json');
			usi_http_request.send();
		};
		usi_app.switch_items_dr = function (pid_from, pid_to, pid_qty, lightning, callback) {
			try {
				usi_app.set_rescrape = function(){}
				usi_app.campaign_persist_callback = function(){}
				if (lightning) {
					usi_cookies.set("usi_suppress_lightning", "1");
				} else {
					usi_cookies.set("usi_suppress_upsell", "1");
				}
				usi_app.add_loading_graphic("");
				var upsell_div = document.querySelector('.usi_inpage_upsell');
				if (upsell_div) upsell_div.parentNode.removeChild(upsell_div);
				var usi_http_request = new XMLHttpRequest();
				usi_http_request.onreadystatechange = function () {
					if (usi_http_request.readyState == 4 && usi_http_request.status == 200) {
						usi_app.switch_to = pid_to;
						usi_app.switch_from = pid_from;
						usi_app.switch_qty = pid_qty || "1";
						setTimeout(function(){
							usi_app.add_prod_dr(callback);
						}, 1000);
					}
				};
				try {
					window['analytics']['callback']['setInternalCampaign'](usi_app.get_mvar(pid_from));
				} catch (err) {
					usi_commons.log_error(err);
				}
				usi_http_request.open('GET', usi_app.delete_link, true);
				usi_http_request.setRequestHeader('Content-Type', 'application/json');
				usi_http_request.send();
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.add_prod_dr = function (callback) {
			try {
				//if (usi_app.upsell_inpage.hash && usi_app.upsell_inpage.siteID) {
				var aff = usi_app.aff_links[usi_app.locale] + "?url=";
					var usi_pid_link = "https://" + document.domain + "/store/" + usi_commons.gup("SiteID") + "/" + usi_app.locale + "/buy/productID." + usi_app.switch_to + "/quantity." + usi_app.switch_qty + usi_app.append_upsell_link;
					if (usi_app.locale == "en-MY") usi_pid_link = "https://store.autodesk.com/store/adskjp/en_MY/buy/productID." + usi_app.switch_to + "/quantity." + usi_app.switch_qty + "/Currency.MYR" + usi_app.append_upsell_link;
					else if (usi_app.locale == "en-SG") usi_pid_link = "https://store.autodesk.com/store/adsk/en_SG/buy/productID." + usi_app.switch_to + "/quantity." + usi_app.switch_qty + "/Currency.SGD" + usi_app.append_upsell_link;
					else if (usi_app.locale == "en-IN") usi_pid_link = "https://store.autodesk.com/store/adskin/en_IN/buy/productID." + usi_app.switch_to + "/quantity." + usi_app.switch_qty + "/Currency.MRP" + usi_app.append_upsell_link;
					else if (usi_app.locale == "ko-KR") usi_pid_link = "https://store.autodesk.co.kr/store/adskkr/ko_KR/buy/productID." + usi_app.switch_to + "/quantity." + usi_app.switch_qty + "/Currency.KRW" + usi_app.append_upsell_link;
					else if (usi_app.locale == "zh-CN") usi_pid_link = "https://store.autodesk.com.cn/store/adskcn/zh_CN/buy/productID." + usi_app.switch_to + "/quantity." + usi_app.switch_qty + "/Currency.CNY" + usi_app.append_upsell_link;
					else if (usi_app.locale == "en-NZ") usi_pid_link = "https://store.autodesk.com.cn/store/adsk/en_NZ/buy/productID." + usi_app.switch_to + "/quantity." + usi_app.switch_qty + "/Currency.NZD" + usi_app.append_upsell_link;

				// [1/3] Built for MY test (Remove when we go live)
				if(usi_app.locale == "en-MY" && usi_app.url.indexOf('gc.digitalriver.com') != -1){
					usi_pid_link = "https://gc.digitalriver.com/store/adskjp/en_MY/buy/productID." + usi_app.switch_to + "/quantity." + usi_app.switch_qty + "/Currency.MYR" + usi_app.append_upsell_link;
					if(typeof window['ADSK_A'] != 'undefined' && typeof window['ADSK_A']['Currency'] != 'undefined'){
						usi_pid_link = usi_pid_link.replace('Currency.MYR', 'Currency.' + window['ADSK_A']['Currency']); //MY works in multiple currencies now
					}
				}

				if (usi_app['lightning_deal'] && usi_app['lightning_deal'].link) usi_pid_link = usi_app['lightning_deal'].link;
				var plc = usi_app.get_plc(usi_app.switch_from) || usi_app.plc;
				if (plc) usi_pid_link += "&plc=" + plc;
				if (typeof callback == "function") {
					callback(usi_pid_link);
				} else if (typeof (usi_js) != "undefined" && usi_cookies.get("usi_banner_click") != null) {
					usi_js.deep_link(usi_pid_link.replace("_my3", "_3yearbanner"));
				} else {
					if (typeof(usi_autoload) !== "undefined") {
						usi_cookies.set("usi_click_id", usi_autoload.id, 30*24*60*60, true);
					}
					usi_commons.log(usi_pid_link);
					if (typeof callback != "undefined" && typeof callback != "function" && callback.indexOf("url=") != -1) window.location = usi_pid_link;
					else window.location = aff + encodeURIComponent(usi_pid_link);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.upsell_text_setter_monthly = function (options) {
			try {
				var english = usi_app.locale == "EU" || usi_app.locale == "GB" || usi_app.locale.indexOf("en_") == 0 || usi_app.locale.indexOf("en-") == 0;
				if (english) {
					options.text = "Upgrade to an annual subscription and save up to 33% - ";
					options.cta = "UPGRADE NOW";
				} else if (usi_app.locale.indexOf("fr") != -1) {
					options.text = "Passez \u00E0 un abonnement annuel et \u00E9conomisez jusqu\u2019\u00E0 33% - ";
					options.cta = "ACTUALISEZ VOTRE ABONNEMENT";
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return options;
		};
		usi_app.upsell_text_setter = function () {
			var options = {
				text: "",
				cta: ""
			};
			try {
				var english = usi_app.locale == "EU" || usi_app.locale == "GB" || usi_app.locale.indexOf("en_") == 0 || usi_app.locale.indexOf("en-") == 0;
				//copy for campaign 31847
				if (["en-NZ", "en-AU"].indexOf(usi_app.locale) != -1) {
					options.text = "Lock in your price for 3 years.";
					options.cta = "Upgrade now";
				} else if (english) {
					options.text = "Lock in your price for 3 years.";
					options.cta = "Upgrade now";
				} else if (usi_app.locale.indexOf("de") != -1) {
					options.text = "Sofort 5% sparen \u2013 verl\u00E4ngern Sie Ihr Abonnement auf 3 Jahre.";
					options.cta = "Jetzt upgraden";
				} else if (usi_app.locale.indexOf("it") != -1) {
					options.text = "Risparmia subito il 5% - prolunga l'abbonamento a 3 anni.";
					options.cta = "Fai l\u2019upgrade ora";
				} else if (usi_app.locale.indexOf("es") != -1) {
					options.text = "Ahorra un 5% inmediatamente: extiende tu suscripci\u00F3n durante 3 a\u00F1os.";
					options.cta = "Ampl\u00EDala ahora mismo";
				} else if (usi_app.locale.indexOf("fr") != -1) {
					options.text = "Economisez 5% tout de suite : prolongez votre abonnement sur 3 ans.";
					options.cta = "Mettre \u00E0 jour maintenant";
				} else if (usi_app.locale == "cs-CZ") {
					options.text = "Okam\u017Eit\u011B u\u0161et\u0159ete 5 % - prodlu\u017Ete sv\u00E9 p\u0159edplatn\u00E9 na 3 roky.";
					options.cta = "Prove\u010Fte ihned";
				} else if (usi_app.locale == "da-DK") {
					options.text = "Spar 5% med det samme - forl\u00E6ng dit abonnement til 3 \u00E5r.";
					options.cta = "Opgrader nu";
				} else if (usi_app.locale == "FI") {
					options.text = "S\u00E4\u00E4st\u00E4 5 % v\u00E4litt\u00F6m\u00E4sti \u2013 pidenn\u00E4 tilauksesi 3-vuotiseksi.";
					options.cta = "P\u00E4ivit\u00E4 nyt";
				} else if (usi_app.locale == "HU") {
					options.text = "5% azonnali megtakar\u00EDt\u00E1s \u2013 hosszabb\u00EDtsa meg el\u0151fizet\u00E9s\u00E9t 3 \u00E9vre.";
					options.cta = "Friss\u00EDt\u00E9s most";
				} else if (usi_app.locale == "NL" || usi_app.locale == "nl-NL" || usi_app.locale.indexOf("nl-") == 0) {
					options.text = "Bespaar direct 5%: verleng je abonnement tot 3 jaar.";
					options.cta = "Waardeer nu op";
				} else if (usi_app.locale == "no-NO") {
					options.text = "Spar 5 % med en gang - utvid abonnementet ditt til 3 \u00E5r.";
					options.cta = "Oppgrader n\u00E5";
				} else if (usi_app.locale == "pl-PL") {
					options.text = "Zaoszcz\u0119d\u017A b\u0142yskawicznie 5% \u2014 przed\u0142u\u017C subskrypcj\u0119 do 3 lat ju\u017C teraz.";
					options.cta = "Rozszerz us\u0142ug\u0119 teraz";
				} else if (usi_app.locale == "pt-BR" || usi_app.locale == "pt-BR") {
					options.text = "Economize instantaneamente 5% - Prolongue sua assinatura para 3 anos.";
					options.cta = "D\u00EA Upgrade agora";
				} else if (usi_app.locale == "pt-SP") {
					options.text = "Poupe 5% automaticamente \u2014 prolongue a sua subscri\u00E7\u00E3o para 3 anos.";
					options.cta = "Atualize agora";
				} else if (usi_app.locale == "PT" || usi_app.locale == "pt-PT") {
					options.text = "Poupe 5% de imediato e prolongue a sua subscri\u00E7\u00E3o para 3 anos.";
					options.cta = "Atualizar j\u00E1";
				} else if (usi_app.locale == "ru-RU") {
					options.text = "\u041F\u043E\u0441\u0442\u043E\u044F\u043D\u043D\u0430\u044F \u0441\u043A\u0438\u0434\u043A\u0430 10\u00A0%. \u0423\u0432\u0435\u043B\u0438\u0447\u044C\u0442\u0435 \u0441\u0440\u043E\u043A \u0434\u0435\u0439\u0441\u0442\u0432\u0438\u044F \u043F\u043E\u0434\u043F\u0438\u0441\u043A\u0438 \u0434\u043E \u0442\u0440\u0435\u0445 \u043B\u0435\u0442.";
					options.cta = "\u041E\u0431\u043D\u043E\u0432\u0438\u0442\u044C \u0441\u0435\u0439\u0447\u0430\u0441";
				} else if (usi_app.locale == "sv-SE") {
					options.text = "Spara 5% direkt - f\u00F6rl\u00E4ng din prenumeration till 3 \u00E5r.";
					options.cta = "Uppgradera nu";
				} else if (usi_app.locale == "tr-TR") {
					options.text = "Aboneli\u011Fini 3 y\u0131la uzatmak isteyenlere an\u0131nda %5 indirim.";
					options.cta = "\u015Eimdi y\u00FCkseltin";
				} else if (usi_app.locale == "ja-JP") {
					options.text = "3 \u5E74\u9593\u30B5\u30D6\u30B9\u30AF\u30EA\u30D7\u30B7\u30E7\u30F3\u306A\u3089\u3001\u8CFC\u5165\u6642\u306E\u4FA1\u683C\u3092\u3088\u308A\u9577\u304F\u7DAD\u6301\u3067\u304D\u307E\u3059";
					options.cta = "\u4ECA\u3059\u3050\u8CFC\u5165";
				} else if (usi_app.locale == "hu-HU") {
					options.text = "5% azonnali megtakar\u00EDt\u00E1s - fizessen el\u0151 m\u00E9g 3 \u00E9vre.";
					options.cta = "V\u00E1ltson most";
				} else if (usi_app.locale == "fi-FI") {
					options.text = "S\u00E4\u00E4st\u00E4 v\u00E4litt\u00F6m\u00E4sti 5 % \u2013 pidenn\u00E4 tilaustasi 3 vuoteen.";
					options.cta = "P\u00E4ivit\u00E4 nyt";
				} else if (usi_app.locale == "ko-KR") {
					options.text = "3\uB144 \uC11C\uBE0C\uC2A4\uD06C\uB9BD\uC158\uC73C\uB85C \uBCC0\uACBD\uD558\uC2DC\uACE0, 3\uB144\uAC04 \uD604\uC7AC \uAC00\uACA9\uC73C\uB85C \uACE0\uC815\uD558\uC138\uC694.";
					options.cta = "\uC9C0\uAE08 \uBCC0\uACBD\uD558\uAE30";
				} else if (usi_app.locale == "zh-CN") {
					options.text = "\u8BA2\u8D2D\u4E09\u5E74\u671F\u8BB8\u53EF\uFF0C\u4E09\u5E74\u5185\u6301\u7EED\u4EAB\u53D7\u5F53\u524D\u9501\u5B9A\u4EF7\u683C*";
					options.cta = "\u70B9\u51FB\u66F4\u65B0\u8D2D\u7269\u8F66\uFF01";
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return options;
		};
		usi_app.get_mvar = function (id) {
			try {
				var plc;
				for (plc in usi_app.upsell_list) {
					if (usi_app.upsell_list.hasOwnProperty(plc) && id in usi_app.upsell_list[plc]) {
						var locale = usi_app.locale.replace(/-/g, "_").toLowerCase();
						return "afc_" + locale + "_" + plc.toLowerCase() + "_usi_my3";
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.get_plc = function (id) {
			try {
				var plc;
				for (plc in usi_app.upsell_list) {
					if (usi_app.upsell_list.hasOwnProperty(plc) && id in usi_app.upsell_list[plc]) {
						return plc;
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.has_monthly = function () {
			try {
				if (usi_app.products && usi_app.products.length > 0) {
					for (var i = 0; i < usi_app.products.length; i++) {
						var type = usi_app.products[i].type;
						usi_commons.log('[ has_monthly ] type:', type);
						if (type && usi_app.has_monthly_keyword(type)) {
							return true;
						}
					}
				}
				return false;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.has_monthly_keyword = function (type) {
			var encoded = encodeURIComponent(type);
			try {
				return type.indexOf('month') !== -1 ||             // en-US, en-CA
					type.indexOf('mois') !== -1 ||                 // fr-CA
					type.indexOf('mes') !== -1 ||                  // es-MX
					type.indexOf('mensual') !== -1 ||                  // es-AR
					type.indexOf('mensal') !== -1 ||               // pt-BR
					type.indexOf('monat') !== -1 ||                // de-DE
					type.indexOf('maand') !== -1 ||                // nl-NL
					type.indexOf('miesi') !== -1 ||                // pl-PL
					encoded.indexOf('1%20m%C4%9Bs%C3%ADc') !== -1 ||                // cs-CZ
					type.indexOf('miesi') !== -1 ||                // pl-PL
					encoded.indexOf('1%20h%C3%B3nap') !== -1 ||                // hu-HU
					type.indexOf('kuukausi') !== -1;               // fi-FI
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.load_email = function () {
			try {
				if (usi_cookies.value_exists("usi_suppress_pc")) return;
				if(usi_app.products.filter(function(v){return v.name == "Flex"}).length > 0) return;
				var monthly = usi_app.has_monthly();
				usi_commons.log('[ load_email ] monthly:', monthly);

				// GUAC
				if (usi_app.locale == "en-US") {
					if (monthly) {
						usi_commons.load_precapture("w5BJKn3z1WAjYMYgD37VxZ3", "39318");
					} else {
						usi_commons.load_precapture("I4TiwTxZ4ksFu6rBhJFhWus", "38524");
					}
				} else if (usi_app.locale == "en-CA") {
					if (monthly) {
						usi_commons.load_precapture("QmXJ9XyYQwXHXyU94ddjA62", "39320");
					} else {
						usi_commons.load_precapture("GDPAK9DgSAis76ZbbzoIqJ6", "38526");
					}
				} else if (usi_app.locale == "fr-CA") {
					if (monthly) {
						usi_commons.load_precapture("JAbZBmcypLZ8gd6VF3Zl0up", "39322");
					} else {
						usi_commons.load_precapture("78qQ7iKExSByA4OHUR5Z5Pp", "38528");
					}
				} else if (usi_app.locale == "en-EU") {
					usi_commons.load_precapture("E8bGUH1VkPoAc7TFhMNE5N9", "38590");
				} else if (usi_app.locale == "en-UK") {
					usi_commons.load_precapture("rlEHcpBCoglucZnPcGngjlt", "38482");
				} else if (usi_app.locale == "fr-FR") {
					usi_commons.load_precapture("3ghEu26zH6mthi935Wdi4iu", "38588");
				} else if (usi_app.locale == "de-DE") {
					usi_commons.load_precapture("G7C7Np8JTwqrOJqB3u6vMdI", "38586");
				} else if (usi_app.locale == "it-IT") {
					usi_commons.load_precapture("NGP4vhqQbinMNWPWRpSY4pt", "38550");
				} else if (usi_app.locale == "es-ES") {
					usi_commons.load_precapture("VQZjzBCKzDoujyMWQWkBGpY", "38580");
				} else if (usi_app.locale == "nl-NL") {
					usi_commons.load_precapture("jhpcoRkCasRMzEvAAVwpomP", "38572");
				} else if (usi_app.locale == "pt-PT") {
					usi_commons.load_precapture("MFsFYGUcGPtJgof85lyyLAw", "38568");
				} else if (usi_app.locale == "fi-FI") {
					usi_commons.load_precapture("YrxTN5FIsNSgchu8PVPXjtt", "38574");
				} else if (usi_app.locale == "hu-HU") {
					usi_commons.load_precapture("6US3hR66j0efmcg2ZZGhUGx", "38570");
				} else if (usi_app.locale == "fr-BE") {
					usi_commons.load_precapture("7IbMBiaKbFzTEcRf9cOVqVD", "38556");
				} else if (usi_app.locale == "nl-BE") {
					usi_commons.load_precapture("h8ykCZ9XXox2HsHzgAVFjfH", "38554");
				} else if (usi_app.locale == "en-NZ") {
					usi_commons.load_precapture("xPvEHH139qNyARgocRfHFzH", "38522");
				} else if (usi_app.locale == "de-CH") {
					usi_commons.load_precapture("i5UtZoMZKocY9h1RxtBrhgt", "38552");
				} else if (usi_app.locale == "it-CH") {
					usi_commons.load_precapture("OT1a0eifYz6ze3qrC9TL1jZ", "38584");
				} else if (usi_app.locale == "fr-CH") {
					usi_commons.load_precapture("6Mpf78iyv2CJKzslySC7MFQ", "38548");
				} else if (usi_app.locale == "pl-PL") {
					usi_commons.load_precapture("TUmmg9dJVCY0SwS3ICxwecL", "38564");
				} else if (usi_app.locale == "no-NO") {
					usi_commons.load_precapture("BpGjjCDRWLa4QGYO3W4F5X3", "38558");
				} else if (usi_app.locale == "ru-RU") {
					usi_commons.load_precapture("nqGNEvnQQvqYqyWAa2brElY", "38578");
				} else if (usi_app.locale == "tr-TR") {
					usi_commons.load_precapture("oJanosyxvzBtqz0yJw7NHkr", "38576");
				} else if (usi_app.locale == "sv-SE") {
					usi_commons.load_precapture("j2NFPwe6nLX4mHwOE1Q5m0O", "38566");
				} else if (usi_app.locale == "cs-CZ") {
					usi_commons.load_precapture("iwnexxOIiyl0c4wPiG1Fr7t", "38560");
				} else if (usi_app.locale == "da-DK") {
					usi_commons.load_precapture("db6nc8pRzzmUR30bNHos658", "38562");
				} else if (usi_app.locale == "en-AU") {
					usi_commons.load_precapture("dLwDplwhWR2X6pb9k1sKsAI", "38520");
				} else if (usi_app.locale == "ja-JP") {
					var payment_select = document.querySelector("#paymentOptionSelect");
					if (payment_select != null) {
						usi_commons.load_precapture("WMM0bXqSf4pBMsc9YW0gP5S", "38542", function(){
							if (typeof usi_js_monitor != "undefined") {
								usi_dom.attach_event("change", function(e) {
									if (e.target.value === "SEVEN_ELEVEN") usi_commons.load_script("//www.upsellit.com/hound/pixel.jsp?companyID=" + usi_app.company_id);
								}, payment_select);
							}
						});
					}
				} else if (usi_app.locale == "es-MX") {
					if (monthly) {
						usi_commons.load_precapture("9NdDObTJlVXeVq2j6aDzYvI", "39324");
					} else {
						usi_commons.load_precapture("u1fiev1Gxper6YDsNGmwNrs", "38530");
					}
				} else if (usi_app.locale == "en-MY") {
					usi_commons.load_precapture("KGyo2AS5IlePToEUsYnMTvy", "38538");
				} else if (usi_app.locale == "en-SG") {
					usi_commons.load_precapture("HkBJlsPa3TdpMg2VMpI6MbN", "38540");
				}
				// DR
				 else if (usi_app.locale == "en-IN") {
					usi_commons.load_precapture("u1fiev1Gxper6YDsNGmwNrs", "38536");
				} else if (usi_app.locale == "ko-KR") {
					if (!usi_cookies.value_exists('usi_suppress_kr')) usi_commons.load_precapture("igQ8Ek3Ky7bByFKWH8I9HaC", "38544");
				} else if (usi_app.locale == "pt-BR") {
					if (monthly) {
						usi_commons.load_precapture("KvB3lUrhyHORkR9yImW63Vw", "39326");
					} else {
						usi_commons.load_precapture("II7jbtjsGoRpgsVwTUJlOq9", "38532");
					}
				} else if (usi_app.locale == "zh-CN") {
					usi_commons.load_precapture("3b6ZU2VJ1aTgy8ja4pBwcdv", "38546");
				} else if (usi_app.locale == "es-AR") {
					if (monthly) {
						usi_commons.load_precapture("FqVtg7vTCDFpLEPk9k0zlP2", "39328");
					} else {
						usi_commons.load_precapture("Vm1ZH21W8EvgYR531jbS7Qo", "38534");
					}
				} else if (usi_app.locale == "en-SE") {
					usi_commons.load_precapture("md2BNUG8WSbvaiC6BvGyfmD", "38484");
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.get_locale_redirect_key = function () {
			var key = '';
			try {
				var redirect_url = usi_cookies.get("usi_locale_redirect_url");
				var redirect_copy = usi_cookies.get("usi_locale_redirect_copy");
				if (redirect_url && redirect_copy && usi_app.locale.toLowerCase().indexOf(usi_app.country) === -1) {
					key = '_redirect';
					// Build direct cart redirect url if possible
					var term = usi_cookies.get('usi_last_term');
					if (!term) {
						// Try to get term from window
						if (utag_data && utag_data['products_term'] && utag_data['products_term'].length > 0) {
							term = utag_data['products_term'][0].toUpperCase().replace(' ', '-');
						}
					}
					if (term && usi_app.plc && redirect_url.indexOf('?term=') !== -1) {
						var cart_url = redirect_url.split('?term=')[0] + "?term=" + term;
						usi_cookies.set("usi_locale_redirect_url", encodeURIComponent(cart_url), usi_cookies.expire_time.hour);
						usi_commons.log('[ get_locale_redirect_key ] cart_url:', cart_url);
					}
				} else {
					usi_cookies.del("usi_locale_redirect_url");
					usi_cookies.del("usi_locale_redirect_copy");
				}
				usi_commons.log('[ get_locale_redirect_key ] key:', key);
			} catch (err) {
				usi_commons.report_error(err);
			}
			return key;
		};
		usi_app.get_promo_text = function () {
			//used in campaign 32829
			try {
				if (typeof usi_app.products == "undefined") return false;
				return usi_app.products.filter(function (item) {
					return !!item.promo;
				})[0].promo;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.cart_has_promo = function () {
			//used in campaign 30141 & 32829
			try {
				if (typeof usi_app.products == "undefined") return false;
				return usi_app.products.filter(function (item) {
					return !!item.promo;
				}).length > 0;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.set_mk_vars = function () {
			if (usi_commons.gup("usi_var002") != "") {
				try {
					window['analytics']['callback']['setExternalCampaign'](usi_commons.gup("usi_var002"));
				} catch (err) {
					usi_commons.report_error(err);
				}
			}
		};
		usi_app.rebuild_dr_cart = function () {
			try {
				usi_app.add_loading_graphic("");
				usi_cookies.set("usi_redirect_happened", "1", 5 * 60);
				var usi_currency = "";
				try {
					usi_currency = ADSK_A.Currency
					if(usi_commons.gup('usi_currency') != ''){
						usi_currency = usi_commons.gup('usi_currency'); //Some locales will soon support more than one currency (Ex: en-MY). See extra JS in 42496 for scraping
					}
				} catch (err) {
					usi_commons.report_error(err);
				}
				var usi_pids = decodeURIComponent(usi_commons.gup("usi_pids"));
				var usi_pids_str = "";
				for (var i = 0; i < usi_pids.split(",").length; i++) {
					usi_pids_str += "productID." + usi_pids.split(",")[i] + "/quantity.1/";
				}
				window.location = "https://" + document.domain + "/store/" + usi_commons.gup("SiteID") + "/" + usi_commons.gup("Locale") + "/buy/" + usi_pids_str + "Currency." + usi_currency;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.rebuild_guac_cart = function () {
			try {
				usi_cookies.set("usi_redirect_happened", "1", 5 * 60);
				var locale = (usi_app.locale == "en-UK") ? "en-GB" : usi_app.locale;
				window.location = "https://" + document.domain + "/" + locale + "?priceIds=" + usi_commons.gup("usi_pids");
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.get_locale = function () {
			try {
				var temp_locale = "";
				if (document.getElementById("cartLink") != null) {
					var locale = document.getElementById("cartLink").href;
					if (locale.indexOf("commerce") != -1 || locale.indexOf("checkout") != -1) {
						locale = locale.substring(locale.lastIndexOf("/") + 1, locale.indexOf("?"));
					} else {
						locale = locale.substring(0, locale.indexOf("/buy"));
						locale = locale.substring(locale.lastIndexOf("/") + 1);
					}
					temp_locale = locale;
				} else if (usi_app.guac_cart) {
					temp_locale = utag_data.locale;
				} else if (sessionStorage.getItem("locale") != null) {
					var usi_locale = sessionStorage.getItem("locale");
					var usi_language = sessionStorage.getItem("language");
					if (usi_locale == "en-CA" || (usi_locale == "undefined" && sessionStorage.getItem("currency") == "CAD")) {
						usi_locale = "en-CA";
					} else if (usi_locale == "EU" && ["pt-PT", "hu-HU", "nl-NL", "fi-FI"].indexOf(usi_language) != -1) {
						usi_locale = usi_language.split("-")[1];
					}
					if (usi_locale == "NAMER") usi_locale = "en-US";
					else if (["IT", "ES", "FR", "DE"].indexOf(usi_locale) != -1) usi_locale = usi_locale.toLowerCase() + "-" + usi_locale;
					temp_locale = usi_locale;
				} else if (window['utag_data'] && window['utag_data']['locale']) {
					temp_locale = window['utag_data']['locale'];
				} else if (usi_commons.gup("Locale") != "") {
					temp_locale = usi_commons.gup("Locale");
				} else if (window['locale']) {
					temp_locale = window['locale'];
				} else if (location.href.indexOf('https://www.autodesk.ae/') !== -1) {
					temp_locale = "en-SE";
				} else if (location.href.indexOf('https://www.autodesk.co.kr/') !== -1) {
					temp_locale = "ko-KR";
				} else if (location.href.indexOf('https://www.autodesk.co.jp/') !== -1) {
					temp_locale = "ja-JP";
				} else if (location.href.indexOf('https://www.autodesk.com.sg/') !== -1) {
					temp_locale = "en-SG";
				}
				if (temp_locale == "es-LATAM") {
					temp_locale = "es-AR";
				} else if (temp_locale == "en-MENA" || temp_locale == "en_MENA" || temp_locale == "en-AE") {
					temp_locale = "en-SE";
				}
				return temp_locale.replace("_", "-");
			} catch (err) {
				usi_commons.report_error(err);
			}
			return "";
		};
		usi_app.find_cart_reference = function () {
			try {
				usi_app.cart_reference = usi_cookies.get("cartReference");
				if (usi_app.cart_reference != null) usi_app.cart_reference = decodeURIComponent(usi_app.cart_reference);
				if (usi_app.cart_reference != null && (usi_app.cart_reference.indexOf(";") != -1 || usi_app.cart_reference.indexOf("|") != usi_app.cart_reference.lastIndexOf("|"))) {
					// Found
				} else {
					setTimeout(usi_app.find_cart_reference, 1000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.set_rescrape = function (func, first) {
			try {
				if (usi_app.clear_cart_in_progress) return;
				var products = func();
				if (!first && ((usi_app.guac_cart && JSON.stringify(products) !== JSON.stringify(usi_app.products)) || ((usi_app.dr_cart || usi_app.is_odm_cart) && products.length !== usi_app.products.length))) {
					usi_commons.log("[ set_rescrape ] Products changed", products);
					usi_app.products = products;
					usi_app.extract_plcs();
					usi_app.upsell_loaded = undefined;
					usi_app.options = undefined;
					
					if (usi_cookies.value_exists('usi_force_redirect')) {
						var url = usi_cookies.get('usi_force_redirect');
						usi_cookies.del('usi_force_redirect');
						window.location = url;
					} else if (usi_app.is_odm_cart) {
						// Just loading upsells for now 10/12/23
						usi_app.upsells_odm();
					} else {
						usi_app.load();
					}
				}
				setTimeout(function () {
					usi_app.set_rescrape(func);
				}, 3000);
				return products;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.report_locale = function() {
			try {
				if (usi_app.emea_uk.indexOf(usi_app.locale) != -1) {
					usi_commons.load_script("https://www.upsellit.com/active/autodeskemeauk.jsp");
				} else if (usi_app.anz.indexOf(usi_app.locale) != -1 || usi_app.apac.indexOf(usi_app.locale) != -1) {
					usi_commons.load_script("https://www.upsellit.com/active/autodeskapacanz.jsp");
				} else if (usi_app.americas.indexOf(usi_app.locale) != -1) {
					usi_commons.load_script("https://www.upsellit.com/active/autodeskamericas.jsp");
				} else {
					usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?audoesk_non_recognized_locale=" + usi_app.locale);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.save_sale_notes = function () {
			try {
				if (usi_app.products == undefined) return;
				var usi_sale_notes = usi_app.products.map(function (p) {
					return p.name + "|" + p.type;
				}).join(",");
				if (usi_sale_notes == "") return;
				usi_cookies.set("usi_sale_notes", usi_sale_notes, usi_cookies.expire_time.month, true);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.suppress = function () {
			usi_cookies.set("usi_suppress", "1", usi_cookies.expire_time.day);
		};
		usi_app.check_url_suppressions = function () {
			try {
				var pidNumbers = [
					'8893445', '8890613', '8880927', '8842542', '8886404', '8860130', '8880856', '8861616',
					'8861693', '8882190', '8863947', '8882999', '8749940', '8863381', '8866677', '8866630',
					'8860033', '8860104', '8846724', '8442273', '8475898', '8817986', '8846242', '8848999',
					'8855374', '8858119', '8858221', '8859430', '8859541', '7803497', '8142680', '8341671',
					'8343167', '8343485', '8350241', '8351753', '8354768', '8355758', '8358074', '8365102',
					'8376097', '8378891', '8753226', '8753338', '8755861', '8769452', '8810802', '8842002', '8843095'
				];
				var idNumbers = [
					'49507', '50107', '50183', '50185', '50181', '49421'
				];
				var aid_suppress = idNumbers.filter(function (id) {
					return location.href.toLowerCase().indexOf('aid=' + id) !== -1;
				}).length > 0;
				var pid_suppress = pidNumbers.filter(function (id) {
					return location.href.toLowerCase().indexOf('pid=' + id) !== -1;
				}).length > 0;
				if (aid_suppress || pid_suppress) {
					usi_app.suppress();
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.init_renewal_cart = function () {
			try {
				usi_app.locale = "";
				if (window['utag_data'] && window['utag_data']['locale']) {
					usi_app.locale = window['utag_data']['locale'];
				}
				if (usi_app.locale === "en-US") {
					// Load TT on US renewal page
					usi_app.scrape_renewal_cart_items();
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.scrape_renewal_cart_items = function () {
			try {
				usi_app.products = [];
				var prod = {};

				// Check cookie
				var usi_renewal_prod = usi_cookies.get_json('usi_renewal_prod');
				if (usi_renewal_prod) {
					usi_commons.log('[ scrape_renewal_cart_item ] Setting data from cookie:', usi_renewal_prod);
					usi_app.products.push(usi_renewal_prod);
				} else if (usi_app.products.length == 0 && window['utag_data'] && window['utag_data']['product_id'] && window['utag_data']['product_id'].length > 0) {
					for (var i = 0; i < window['utag_data']['product_id'].length; i++) {
						prod = {};
						prod['pic'] = "https://www.upsellit.com/chatskins/3614/autodesk_icon.png"
						prod['type'] = window['utag_data']['products_type'][i];
						prod['name'] = document.querySelector('.responsive-cart-container .product-name').textContent.trim().split(/\r?\n/)[0];
						prod['product_id'] = window['utag_data']['product_id'][i];
						prod['qty'] = window['utag_data']['product_quantity'][i];
						prod['old_price'] = "$" + window['utag_data']['product_unit_price'][i];
						prod['price'] = "$" + (Number(window['utag_data']['product_unit_price'][i]) - Number(window['utag_data']['product_discount'][i])).toFixed(2);
						usi_cookies.set_json("usi_renewal_prod", prod, usi_cookies.expire_time.day);
						usi_app.products.push(prod);
					}
					usi_commons.log(usi_app.products);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		
		// noinspection JSUnusedGlobalSymbols
		var usi_custom_monitor = {
			get_locale: function () {
				return usi_app.locale;
			},
			send_data: function (value, name) {
				usi_js_monitor.USI_LoadDynamics(value, name, usi_js_monitor.USI_getASession());
			},
			send_utf8: function (value, name) {
				usi_js_monitor.USI_LoadDynamics(encodeURIComponent(encodeURIComponent(encodeURIComponent(value))), "utf8_" + name, usi_js_monitor.USI_getASession());
			},
			send_cart_type: function () {
				if (typeof usi_app.dr_cart == "undefined") return;
				if (usi_app.dr_cart && !usi_app.efulfilment) {
					usi_custom_monitor.send_data('1', 'usi_drcart');
					usi_custom_monitor.send_data('null', 'usi_bicestore');
				} else {
					usi_custom_monitor.send_data('1', 'usi_bicestore');
					usi_custom_monitor.send_data('null', 'usi_drcart');
				}
			},
			send_products: function () {
				try {
					if (typeof usi_app.products == "undefined") return;
					var item_num, usi_product, prop;
					var products = usi_app.products;
					for (item_num = 0; products[item_num] != undefined && item_num < 3; item_num++) {
						usi_product = products[item_num];

						// Assign priceline
						var priceline_sent = '';
						var price = '';
						try {
							var priceline = usi_product.price;
							if (usi_product.old_price != undefined && usi_product.old_price != "") {
								priceline = '<span style="text-decoration:line-through;">' + usi_product.old_price + '</span> <span style="color:#d02f35;">' + usi_product.price + '</span>';
							}
							var clean_price = usi_product.price.split(" ")[0];
							if (clean_price) {
								clean_price = clean_price.replace(/[^0-9.]+/g, "");
							} else {
								clean_price = usi_product.price.replace(/[^0-9.]+/g, "");
								if (clean_price.split(".").length > 2) {
									clean_price = clean_price.split(".")[0];
								}
							}
							if (Number(clean_price) > 0) {
								priceline_sent = priceline;
								usi_custom_monitor.send_utf8(priceline, "priceline" + (item_num + 1));
							}
						} catch (e) {
							usi_commons.log_error(e);
						}

						for (prop in usi_product) {
							if (usi_product.hasOwnProperty(prop) && usi_product[prop] != null) {
								var value = usi_product[prop];
								if (typeof(value) === "string") {
									if (prop.indexOf("price") != -1 && Number(decodeURIComponent(value).replace(/[^0-9.]+/g, "")) === 0) {
										
										value = "<b></b>";
									}
									if (prop.indexOf("pic") == 0) {
										if (value.indexOf("https://emsfs.autodesk.com") == 0) {
											usi_custom_monitor.send_data("https://www2.upsellit.com/admin/custom/proxy.jsp?url=" + value, prop + (item_num + 1));
										} else {
											usi_custom_monitor.send_data(value, prop + (item_num + 1));
										}
									} else if (prop.indexOf("qty") != -1) {
										// Check that qty is no more than 3 digits
										usi_commons.log('[ send_products ] qty:', value);
										if (value && value.length > 3) {
											// Suppress this pc (this is likely a renewal product and scraping is broken)
											usi_commons.log('[ send_products ] Suppressing PC!');
										} else {
											usi_custom_monitor.send_utf8(value, prop + (item_num + 1));
										}
									} else {
										if (prop === "price") price = value;
										usi_custom_monitor.send_utf8(value, prop + (item_num + 1));
									}

									// Display separate copy for monthly subscribers
									if (prop === "type") {
										usi_app.has_monthly_keyword(usi_product[prop]) ? usi_custom_monitor.send_data('1', 'usi_monthly') : usi_custom_monitor.send_data('null', 'usi_monthly');
									}
								}
							}
						}

						// Priceline fallback
						if (!priceline_sent) {
							usi_custom_monitor.send_utf8(price, "priceline" + (item_num + 1));
						}

					}
					if (typeof (usi_app.pids_in_cart) !== "undefined" && usi_app.pids_in_cart != "") {
						usi_custom_monitor.send_data(usi_app.pids_in_cart, "usi_pids");
					}
				} catch (err) {
					usi_commons.report_error(err);
				}
			},
			send_locale_data: function (info) {
				try {
					for (var i in info) {
						if (info.hasOwnProperty(i) && i.indexOf("optin_") == -1) {
							if (i.indexOf('link') !== -1) usi_custom_monitor.send_data(info[i], i);
							else usi_custom_monitor.send_utf8(info[i], i);
						}
					}
				} catch (err) {
					usi_commons.report_error(err);
				}
			},
			show_opt_in: function (info) {
				try {
					var place_css = function (css) {
						var css_element = document.createElement("style");
						css_element.type = "text/css";
						if (css_element.styleSheet) {
							css_element.styleSheet.cssText = css;
						} else {
							css_element.innerHTML = css;
						}
						document.getElementsByTagName('head')[0].appendChild(css_element);
					};
					var place_html = function (html, place_where) {
						var html_element = document.createElement('div');
						html_element.setAttribute('id', 'usi_optin_div');
						html_element.innerHTML = html;
						place_where.appendChild(html_element);
					};
					this.remove_optin = function () {
						var optin = document.getElementById('usi_optin_div');
						if (optin != null) {
							optin.style.display = "none";
						}
					};
					this.opt_in = function () {
						usi_custom_monitor.remove_optin();
						var optin = document.getElementById('usi_optin');
						if (optin == null || optin.checked == false) return;
						usi_js_monitor.USI_LoadDynamics("1", 'optedin', usi_js_monitor.USI_getASession());
						if (typeof usi_js_monitor['send_all_info'] === "function") {
							usi_js_monitor['send_all_info']();
						}
					};
					var html = [
						'<div id="usi_optin_contain">',
						'<span id="usi_closebutton">&', 'times;</span>',
						'<div id="usi_text">', info.optin_head, '</div>',
						'<div id="usi_input"><input type="checkbox" id="usi_optin" checked><label for="usi_optin">', info.optin_desc, '</label></div>',
						'<div id="usi_ok">', info.optin_ok, '</div>',
						'</div>'
					].join('');

					var usi_position = 'position:absolute;left:200px;top:50px;';
					var usi_arrow_things = ['#usi_optin_contain:after,#usi_optin_contain:before {right: 100%;top: 90%;border: solid transparent;content: " ";height: 0;width: 0;position: absolute;pointer-events: none;}',
						'#usi_optin_contain:after {border-color: rgba(255, 255, 255, 0);border-right-color: #f5f5f5;border-width: 20px;margin-top: -74px;}',
						'#usi_optin_contain:before {border-color: rgba(21, 136, 179, 0);border-right-color: #ccc;border-width: 22px;margin-top: -76px;}'].join('');

					if (document.getElementById("dr_emailInfo") != null) {
						html = "<div style='position:relative;top:25px;left:0;width:1px;height:1px'>" + html + "</div>";
						place_html(html, document.getElementById("dr_emailInfo"));
						if (usi_app.locale == "pt-BR" || usi_app.locale == "en-IN" || usi_app.locale == "es-AR") {
							usi_position = 'position:absolute;left:530px;top:-332px;';
						} else if (usi_app.locale == "ko-KR") {
							usi_position = 'position:absolute;left:620px;top:-346px;';
						} else if (usi_app.locale == "ko-KR") {
							usi_position = 'position:absolute;left:620px;top:-276px;';
						} else if (usi_app.locale == "tr-TR") {
							usi_position = 'position:absolute;left: 529px;top: -394px;';
						} else if (usi_app.locale == "es-MX") {
							usi_position = 'position:absolute;left: 529px;top: -394px;';
						} else {
							usi_position = 'position:absolute;left:300px;top:-137px;';
						}
					} else if (document.getElementsByClassName("signin-actions").length > 0) {
						// signin-actions
						if (window.usi_which_iframe == "login-iframe") {
							if (usi_app.locale == "NL") {
								usi_position = 'position:absolute;left:380px;top:115px;';
							} else {
								usi_position = 'position:absolute;left:380px;top:95px;';
							}
						} else {
							if (usi_app.locale == "NL") {
								usi_position = 'position:absolute;left:90px;top:200px;';
							} else {
								usi_position = 'position:absolute;left:110px;top:182px;';
							}
							usi_arrow_things = ['#usi_optin_contain:after,#usi_optin_contain:before {left: 100%;top: 80%;border: solid transparent;content: " ";height: 0;width: 0;position: absolute;pointer-events: none;}',
								'#usi_optin_contain:after {border-color: rgba(255, 255, 255, 0);border-left-color: #f5f5f5;border-width: 20px;margin-top: -74px;}',
								'#usi_optin_contain:before {border-color: rgba(21, 136, 179, 0);border-left-color: #ccc;border-width: 22px;margin-top: -76px;}'].join('');
						}
						place_html(html, document.getElementsByClassName("signin-actions")[0]);
					} else if (document.getElementById("O2-iframe-container") != null) {
						usi_position = 'position:absolute;left:450px;top:266px;';
						place_html(html, document.getElementById("O2-iframe-container"));
					}

					var optin_svg = "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='9' height='6.15' id='small-checkmark'><path fill='%23ffffff' d='M3.52 6.15a.65.65 0 01-.43-.17L0 3.11l.86-.93L3.5 4.64 8.1 0l.9.89-5.03 5.07c-.12.13-.28.19-.45.19z'></path></svg>";
					var usi_input_styles = '#usi_input {font-size:14px;color:#000000; padding: 5px 0 5px 24px; position: relative;}';
					var usi_dr_styles = '';
					if (document.querySelector('#dr_QuickBuyCart #dr_accountInformation')) {
						usi_input_styles = '#usi_input {font-size:14px;color:#000000; padding: 0 0 45px 0; position: relative;}';
						usi_dr_styles = '#usi_input label {padding-left: 25px;}';
					}
					var css = [
						'#usi_optin_contain {background:#f5f5f5; border:1px solid #ccc; width:280px; padding:15px;', usi_position, 'box-shadow: 1px 1px 10px rgba(0, 0, 0, 0.25);z-index:9999999; box-sizing: border-box;}',
						'#usi_optin {opacity: 0; position: absolute; margin: 0; filter: unset !important; height: 18px; width: 18px;}',
						'#usi_optin:focus + label::before {outline: 0;}',
						'#usi_optin + label::before {border: 1px solid #000; box-sizing: border-box; content: ""; height: 18px; width: 18px; left: 0; position: absolute; top: 7px; background: #fff; border-radius: 2px;}',
						'#usi_optin + label::after {background-image: url("' + optin_svg + '"); content: ""; height: 18px; width: 18px; border: 2px solid transparent; position: absolute; box-sizing: content-box; top: 4px; left: -2px; opacity: 1 !important; display: block; border-radius: 2px; background-repeat: no-repeat; background-size: 12px 11px; background-position: center;}',
						'#usi_optin:checked + label::before {background: #000;}',
						usi_arrow_things,
						'#usi_closebutton {text-align: center; position: absolute; top: 5px; right: 4px; font-size: 30px; cursor: pointer; height: 20px; width: 20px; line-height: 20px;color:#666;}',
						'#usi_text {font-size:18px;color:#222;margin-bottom:6px;}',
						usi_input_styles,
						usi_dr_styles,
						'#usi_input input {position: absolute;left: 0;}',
						'#usi_ok {font-size:14px;color:#fff;background:#000000;padding:10px; display:block; cursor:pointer;margin-top:10px; line-height: 1;border-radius: 2px;}',
						'#usi_ok:after { content: "\\203a"; float: right; font-size:30px; margin-top:-9px;}'
					].join('');

					if (usi_app.dr_cart == false) {
						css += [
							'@media screen and (max-width: 768px) {',
							'#usi_optin_contain {width:100%;top:inherit;top: 19px !important;position:fixed;left:0;}',
							'#usi_optin_contain:after, #usi_optin_contain:before { left: 50%; top: 32px; transform: translateX(-50%); }',
							'#usi_optin_contain:before { border-bottom-color: #ccc; border-right-color:transparent;border-width: 24px; margin-top: -80px; }',
							'#usi_optin_contain:after { border-bottom-color: #f5f5f5;border-right-color:transparent; border-width: 24px; margin-top: -77px; }',
							'#usi_closebutton {top:8%;right:3%;font-size:40px;height:20px;width:20px;}',
							'#usi_text{display:block;}',
							'}'
						].join('');
					} else {
						css += [
							'@media screen and (max-width: 1200px) {',
							'#usi_optin_contain { margin-top: -40px; }',
							'}'
						].join('');
					}

					css += [
						'@media screen and (max-width: 768px) {',
						'#usi_optin_contain {background: #f5f5f5;border: 1px solid #ccc;width: 280px;padding: 15px;position: absolute;left: 75px;top: -467px;box-shadow: 1px 1px 10px rgb(0 0 0 / 25%);z-index: 9999999;box-sizing: border-box;}',
						'#usi_optin_contain:after,#usi_optin_contain:before {bottom: 0;right: 82%;border: solid transparent;content: " ";height: 0;width: 0;position: absolute;pointer-events: none;margin-bottom: -8%;margin-top: 0;top: 100%;}',
						'#usi_optin_contain:after {border-left: 20px solid transparent;border-right: 20px solid transparent;border-top: 20px solid #f5f5f5;}',
						'#usi_optin_contain:before {border-left: 20px solid transparent;border-right: 20px solid transparent;border-top: 20px solid #ccc;}',
						'}'
					].join('');

					// JP specific styles
					if (usi_app.locale === 'ja-JP') {
						css += [
							'#usi_optin_contain {width: 335px;}',
							'#usi_input label {line-height: 21px;}'
						].join('');
					}

					place_css(css);

					var usi_closebutton = document.getElementById('usi_closebutton');
					var ok = document.getElementById('usi_ok');
					if (usi_closebutton) usi_closebutton.addEventListener('click', usi_custom_monitor.remove_optin, false);
					if (ok) ok.addEventListener('click', usi_custom_monitor.opt_in, false);
				} catch (err) {
					usi_commons.report_error(err);
				}
			},
			init: function () {
				// Special stuff for bic iframes
				try {
					if (!usi_app.dr_cart) {
						var usi_all_items_reported = 0;
						var usi_last_email_post = "";
						window.usi_which_iframe = "login-iframe";

						usi_custom_monitor.find_register = function () {
							var usi_found_email = "";
							if (document.getElementsByClassName(window.usi_which_iframe).length > 0) {
								document.getElementsByClassName(window.usi_which_iframe)[0].contentWindow.postMessage(JSON.stringify({
									action: 'get_email'
								}), "*");
								if (window.usi_which_iframe == "login-iframe") window.usi_which_iframe = "create-account-iframe";
								else window.usi_which_iframe = "login-iframe";
							} else if (document.getElementById("O2-iframe-container") != null && document.getElementById("O2-iframe-container").getElementsByTagName("iframe").length > 0) {
								document.getElementById("O2-iframe-container").getElementsByTagName("iframe")[0].contentWindow.postMessage(JSON.stringify({
									action: 'get_email'
								}), "*");
							}
							if (typeof (window.obj) != "undefined" && typeof (window.obj.email) != "undefined" && window.obj.email.indexOf("@") != -1) {
								usi_found_email = window.obj.email;
								if (typeof (window.obj.firstName) != "undefined") usi_js_monitor.USI_LoadDynamics(window.obj.firstName, 'firstName', usi_js_monitor.USI_getASession());
							} else if (typeof (window['usi_email_from_iframe']) != "undefined" && window['usi_email_from_iframe'].indexOf("@") != -1 && usi_last_email_post != window['usi_email_from_iframe']) {
								usi_found_email = window['usi_email_from_iframe'];
							}
							if (usi_found_email != "") {
								usi_app.email = usi_found_email;
								if (usi_all_items_reported == 0) {
									usi_all_items_reported = 1;
									usi_js_monitor.USI_reportAllItems();
								}
							}
						}
						var usi_find_registerID = setInterval(usi_custom_monitor.find_register, 1500);
						if (usi_find_registerID) {
							usi_commons.log('[ usi_custom_monitor.init ] usi_find_registerID interval set');
						}
						usi_js_monitor.USI_checkAllForChange = function () {
							for (var i = 0; i < usi_js_monitor.USI_onlyRecordFields.length; i++) {
								var usi_fieldName = usi_js_monitor.USI_onlyRecordFields[i];
								var usi_field = null;
								if (document.getElementsByName(usi_js_monitor.USI_onlyRecordFields[i]) != null && document.getElementsByName(usi_js_monitor.USI_onlyRecordFields[i]).length > 0) {
									usi_field = document.getElementsByName(usi_js_monitor.USI_onlyRecordFields[i])[1];
								} else if (document.getElementById(usi_js_monitor.USI_onlyRecordFields[i]) != null) {
									usi_field = document.getElementById(usi_js_monitor.USI_onlyRecordFields[i]);
								}
								if (usi_field != null) {
									var usi_fieldValue = usi_field.value;
									if (usi_fieldValue != null && usi_fieldValue != "" && usi_fieldValue != usi_js_monitor.USI_PreviousFieldValues[usi_fieldName]) {
										usi_js_monitor.USI_PreviousFieldValues[usi_fieldName] = usi_fieldValue;
										usi_js_monitor.USI_LoadDynamics(usi_fieldValue, usi_fieldName, USI_getASession());
									}
								}
							}
						}
					}
				} catch (err) {
					usi_commons.report_error(err);
				}
			}
		};
		usi_app.encode_unicode = function (str) {
			try {
				function dec2hex4(textString) {
					var hexequiv = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];
					return hexequiv[(textString >> 12) & 0xF] + hexequiv[(textString >> 8) & 0xF] +
						hexequiv[(textString >> 4) & 0xF] + hexequiv[textString & 0xF];
				}

				function convertCharStr2jEsc(str) {
					// Converts a string of characters to JavaScript escapes
					// str: sequence of Unicode characters
					var highsurrogate = 0;
					var suppCP;
					var pad;
					var outputString = '';
					for (var i = 0; i < str.length; i++) {
						var cc = str.charCodeAt(i);
						if (cc < 0 || cc > 0xFFFF) {
							outputString += '!Error in convertCharStr2UTF16: unexpected charCodeAt result, cc=' + cc + '!';
						}
						if (highsurrogate != 0) { // this is a supp char, and cc contains the low surrogate
							if (0xDC00 <= cc && cc <= 0xDFFF) {
								suppCP = 0x10000 + ((highsurrogate - 0xD800) << 10) + (cc - 0xDC00);
								suppCP -= 0x10000;
								outputString += '\\u' + dec2hex4(0xD800 | (suppCP >> 10)) + '\\u' + dec2hex4(0xDC00 | (suppCP & 0x3FF));
								highsurrogate = 0;
								continue;
							} else {
								outputString += 'Error in convertCharStr2UTF16: low surrogate expected, cc=' + cc + '!';
								highsurrogate = 0;
							}
						}
						if (0xD800 <= cc && cc <= 0xDBFF) { // start of supplementary character
							highsurrogate = cc;
						} else { // this is a BMP character
							//outputString += dec2hex(cc) + ' ';
							switch (cc) {
								case 0:
									outputString += '\\0';
									break;
								case 8:
									outputString += '\\b';
									break;
								case 9:
									outputString += '\t';
									break;
								case 10:
									outputString += '\n';
									break;
								case 13:
									outputString += '\\r';
									break;
								case 11:
									outputString += '\\v';
									break;
								case 12:
									outputString += '\\f';
									break;
								case 34:
									outputString += '"';
									break;
								case 39:
									outputString += '\'';
									break;
								case 92:
									outputString += '\\\\';
									break;
								default:
									if (cc > 0x1f && cc < 0x7F) {
										outputString += String.fromCharCode(cc)
									} else {
										pad = cc.toString(16).toUpperCase();
										while (pad.length < 4) {
											pad = '0' + pad;
										}
										outputString += '\\u' + pad
									}
							}
						}
					}
					return outputString;
				}

				return convertCharStr2jEsc(str);
			} catch (err) {
				usi_commons.log_error(err);
			}
		};
		usi_app.clear_cart = function (cb) {
			try {
				var delete_btn = document.querySelector('.checkout--cart-section .checkout--product-bar button');
				if (delete_btn && typeof delete_btn.click === "function") {
					if (!usi_app.clear_cart_in_progress) {
						usi_app.clear_cart_in_progress = true;
						usi_app.add_loading_graphic("One moment while we update your cart...");
					}
					delete_btn.click();
					setTimeout(function () {
						usi_app.clear_cart(cb);
					}, 3000);
				} else if (typeof cb === "function") {
					usi_app.remove_loading_graphic();
					cb();
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.monitor_for_aff_pixels = function () {
			try {
				var cj1 = "";
				try {
					var usi_imgs = document.getElementsByTagName("img");
					for (var i = 0; i < usi_imgs.length; i++) {
						if (usi_imgs[i].src.indexOf("emjcd.com") != -1) {
							cj1 = usi_imgs[i].src;
						}
					}
				} catch (err) {
					usi_commons.report_error(err);
				}
				var cfjump = "";
				try {
					var usi_scripts = document.getElementsByTagName("script");
					for (var i = 0; i < usi_scripts.length; i++) {
						if (usi_scripts[i].src.indexOf("https://cfjump.autodesk.com/track") == 0) {
							cfjump = usi_scripts[i].src;
						}
					}
				} catch (err) {
					usi_commons.report_error(err);
				}
				if (cj1 != "" || cfjump != "") {
					if (cj1 != "") {
						usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?autodesk_cj=" + encodeURIComponent(cj1) + "&url=" + encodeURIComponent(location.href));
					} else {
						usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?cfjump=" + encodeURIComponent(cfjump) + "&url=" + encodeURIComponent(location.href));
					}
					usi_commons.load_script("https://www.upsellit.com/active/autodesk_new_pixel.jsp");
				} else {
					setTimeout(usi_app.monitor_for_aff_pixels, 2000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.monitor_for_analytics = function() {
			try {
				if (typeof(usi_app.last_url) === "undefined" || usi_app.last_url != location.href) {
					usi_app.last_url = location.href;
					//usi_analytics.send_page_hit("VIEW", "3614");
				}
				setTimeout(usi_app.monitor_for_analytics, 2000);
			} catch(err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.session_data_callback = function () {
			usi_app.country = usi_app.session_data.country;
			usi_app.main();
		};
		usi_app.monitor_for_aff_pixels();
		usi_app.monitor_for_analytics();
		usi_dom.ready(function () {
			try {
				setTimeout(usi_commons.load_session_data, 2000);
			} catch (err) {
				usi_commons.report_error(err);
			}
		});
	} catch (err) {
		usi_commons.report_error(err);
	}
}
