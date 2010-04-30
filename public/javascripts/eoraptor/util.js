var __slice = Array.prototype.slice, __bind = function(func, obj, args) {
    return function() {
      return func.apply(obj || {}, args ? args.concat(__slice.call(arguments, 0)) : arguments);
    };
  };
Eoraptor.withNS('Util', function() {
  this.escapeHTML = function escapeHTML(s) {
    return s.replace(/&/g, '&amp;').replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/'/g, "&#39;").replace(/"/g, "&quot;");
  };
  this.autolink = function autolink(text) {
    return text.replace(/(\bhttp:\/\/\S+(\/|\b))/gi, '<a href="$1" target="_blank">$1</a>');
  };
  this.format = function format(text) {
    return this.autolink(this.escapeHTML(text));
  };
  this.h = this.escapeHTML;
  this.formatTime = function formatTime(s) {
    var hour, minutes, minutesPrefix, period, preiod, time;
    time = new Date(s);
    period = "";
    hour = time.getHours();
    if (hour === 0) {
      period = "am";
      hour = 12;
    } else if (hour < 12) {
      period = "am";
    } else if (hour === 12) {
      period = "pm";
    } else if (hour < 24) {
      preiod = "pm";
      hour -= 12;
    }
    minutes = time.getMinutes();
    minutesPrefix = minutes < 10 ? "0" : "";
    return "" + hour + ":" + minutesPrefix + minutes + " " + period;
  };
  this.attachUpdatingTimeAgo = function attachUpdatingTimeAgo(object, date) {
    var existing, update;
    existing = this.data(object, "time-ago-interval");
    if ((typeof existing !== "undefined" && existing !== null)) {
      clearInterval(parseInt(existing, 10));
    }
    update = __bind(function() {
        return object.html(this.timeAgoInWords(date));
      }, this);
    update();
    return this.data(object, "time-ago-interval", setInterval(update, 60000));
  };
  this.timeAgoInWords = function timeAgoInWords(date) {
    var daysAgo, hoursAgo, minutesAgo, monthsAgo, now, secondsAgo, time;
    time = Number(new Date(date));
    now = Number(new Date());
    secondsAgo = (now - time) / 1000;
    // Check up to two hours ago
    minutesAgo = Math.floor(secondsAgo / 60);
    if (minutesAgo === 0) {
      return "less than a minute";
    } else if (minutesAgo === 1) {
      return "one minute";
    } else if (minutesAgo < 60) {
      return ("" + minutesAgo + " minutes");
    } else if (minutesAgo < 120) {
      return "about one hour";
    }
    // Up to two days ago
    hoursAgo = Math.floor(minutesAgo / 60);
    if (hoursAgo < 24) {
      return ("about " + hoursAgo + " hours");
    } else if (hoursAgo < 48) {
      return "one day";
    }
    // Up to two months ago
    daysAgo = Math.floor(hoursAgo / 24);
    if (daysAgo < 30) {
      return ("" + daysAgo + " days");
    } else if (daysAgo < 60) {
      return "about one month";
    }
    // Up to two years ago
    monthsAgo = Math.floor(daysAgo / 30);
    if (monthsAgo < 12) {
      return ("" + monthsAgo + " months");
    } else if (monthsAgo < 24) {
      return "about one year";
    }
    // Finally, return a years amount
    return "over " + (Math.floor(monthsAgo / 12)) + " years";
  };
  return this.timeAgoInWords;
});