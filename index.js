const config = {
  title: "African Cabinets",
  repository: "https://github.com/nichtich/african-cabinets"
}
const menu = {
  "states": { sparql: null },
  "positions": { sparql: null },
  "state-positions": { sparql: null },
  "generic-positions": { sparql: null },
  "about": { html: null }
}

$(function(){

  // initialize page
  $('title').text(config.title)
  $('.navbar-brand').text(config.title)
  $('#repository-url').attr("href", config.repository)

  const queryBase = "//query.wikidata.org/"
  const githubBase = config.repository + "/blob/master/"

  var selectedMenuItem = window.location.hash.substr(1)
  if (!(selectedMenuItem in menu)) {
    selectedMenuItem = "about" // default
  }

  function selectMenu(name) {
    const item = menu[name]
    selectedMenuItem = name

    $("#menu li").removeClass("active")
    $("#"+name).addClass("active")

    $("#iframes iframe").hide()
    $("#sparql").hide()
    if (item.sparql) { 
      if (!item.html) {
          const comment = item.sparql.match(/(^# .+\n)+/m)
          if (comment) {
              item.html = comment[0].split("# ").join(" ")
          }
      }
      // TODO: show loading indicator and remove on load of iframe
      const query = encodeURIComponent(item.sparql)
      var iframe = $("#iframe-"+name).show()
      if (!iframe.attr("src")) {
        iframe.attr("src", queryBase + "embed.html#" + query)
      }
      $("#sparql").attr("href", queryBase + "#" + query).show()
    }

    if (item.html) {
      $("#description").show().html(item.html)
      $("#html").attr("href", githubBase + name + ".html").show()
    } else {
      $("#description").hide()
      $("#html").hide()
    }

    window.location.hash = name
  }

  Object.keys(menu).forEach(function(name) {
    const item = menu[name]

    var a = $('<a>').addClass("nav-link disabled")
    a.text(name.charAt(0).toUpperCase() + name.slice(1))
    $('<li class="nav-item">').attr('id', name).append(a).appendTo('#menu')
    a.click(function(){ selectMenu(name) })

    if ('sparql' in item) {
      $.get(name +".rq", function(sparql) {
        item.sparql = sparql

        var iframe = $("<iframe>").hide()
        iframe.attr("id","iframe-"+name)
        iframe.appendTo($("#iframes"))
        a.removeClass("disabled")

        if (name == selectedMenuItem) {
          selectMenu(name)
        }
      }, "text")
    }
    if ('html' in item) {
      $.get(name + ".html").done(function(html) {
        item.html = html
        if (name == selectedMenuItem) {
          selectMenu(name)
        }
        a.removeClass("disabled")
      })
    }
  })

})
