// Tabs modules for MOJ
// Dependencies: moj, jQuery

(function () {
  'use strict';

  /*
    Cookie methods
    ==============
    Usage:
      Setting a cookie:
      moj.Modules.Cookie.set('foo', 'bar', { days: 30 });

      Reading a cookie:
      moj.Modules.Cookie.get('foo');

      Removing a cookie:
      moj.Modules.Cookie.remove('foo');
  */
  var Cookie = function () {};

  Cookie.prototype = {
    set: function (name, value, options){
      if (typeof options === 'undefined') {
        options = {};
      }
      var cookieString = name + '=' + value + '; path=/',
          date;
      if (options.days) {
        date = new Date();
        date.setTime(date.getTime() + (options.days * 24 * 60 * 60 * 1000));
        cookieString = cookieString + '; expires=' + date.toGMTString();
      }
      if (document.location.protocol === 'https:') {
        cookieString = cookieString + '; Secure';
      }
      document.cookie = cookieString;
    },

    get: function (name){
      var nameEQ = name + '=',
          cookies = document.cookie.split(';'),
          i, len, cookie;
      // moj.log(cookies);
      for (i = 0, len = cookies.length; i < len;) {
        cookie = cookies[i];
        while (cookie.charAt(0) === ' ') {
          cookie = cookie.substring(1, cookie.length);
        }
        if (cookie.indexOf(nameEQ) === 0) {
          return decodeURIComponent(cookie.substring(nameEQ.length));
        }
        i += 1;
      }
      return null;
    },

    remove: function (name){
      if (moj.Modules.Cookie.get(name) === undefined) {
        return false;
      }

      // Must not alter options, thus extending a fresh object...
      moj.Modules.Cookie.set(name, '', { days: -1 });
      return !moj.Modules.Cookie.get(name);
    }
  };

  moj.Modules.Cookie = new Cookie();

  moj.Modules.CookieMessage = {
    init: function () {
      var message = document.getElementById('global-cookie-message'),
          needsCookieMessage = (message && moj.Modules.Cookie.get('seen_cookie_message') === null);

      if (needsCookieMessage) {
        message.style.display = 'block';
        moj.Modules.Cookie.set('seen_cookie_message', 'yes', { days: 28 });
      }
    }
  };
}());