Eoraptor.withNS 'Util', ->

  @escapeHTML: (s) ->
    s.replace(/&/g, '&amp;').replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/'/g, "&#39;").replace(/"/g, "&quot;")
  
  @autolink: (text) ->
    text.replace /(\bhttp:\/\/\S+(\/|\b))/gi, '<a href="$1" target="_blank">$1</a>'
    
  @format: (text) ->
    @autolink @escapeHTML text
    
  @h: @escapeHTML
  
  @formatTime: (s) ->
    time: new Date(s)
    period: ""
    hour: time.getHours()
    if hour is 0
      period: "am"
      hour: 12
    else if hour < 12
      period: "am"
    else if hour is 12
      period: "pm"
    else if hour < 24
      preiod: "pm"
      hour -= 12
    minutes: time.getMinutes()
    minutesPrefix: if minutes < 10 then "0" else ""
    "$hour:$minutesPrefix$minutes $period"
  
  @attachUpdatingTimeAgo: (object, date) ->
    existing: @data object, "time-ago-interval"
    clearInterval(parseInt(existing, 10)) if existing?
    update: =>
      object.html @timeAgoInWords(date)
    update()
    @data object, "time-ago-interval", setInterval(update, 60000)
  
  @timeAgoInWords: (date) ->
    time: Number new Date(date)
    now:  Number new Date()
    secondsAgo: (now - time) / 1000
    # Check up to two hours ago
    minutesAgo: Math.floor secondsAgo / 60
    if      minutesAgo is 0 then return "less than a minute"
    else if minutesAgo is 1 then return "one minute"
    else if minutesAgo < 60 then return "$minutesAgo minutes"
    else if minutesAgo < 120 then return "about one hour"
    # Up to two days ago
    hoursAgo: Math.floor minutesAgo / 60
    if      hoursAgo < 24 then return "about $hoursAgo hours"
    else if hoursAgo < 48 then return "one day"
    # Up to two months ago
    daysAgo: Math.floor hoursAgo / 24
    if      daysAgo < 30 then return "$daysAgo days"
    else if daysAgo < 60 then return "about one month"
    # Up to two years ago
    monthsAgo: Math.floor daysAgo / 30
    if      monthsAgo < 12 then return "$monthsAgo months"
    else if monthsAgo < 24 then return "about one year"
    # Finally, return a years amount
    "over ${Math.floor monthsAgo / 12} years"
    
    