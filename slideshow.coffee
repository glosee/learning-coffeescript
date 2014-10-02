# jQuery ready
$ ->
  panels = $('.slideshow').find('li')
  active = 0 # current active panel index

  print = (message) ->
    console.log( message )

  print panels

  # initial panel positioning
  panels.css({left: '-400px'})
  $(panels[0]).css({left: '0px'})

  doRotation = ->

    # which panel to show next
    next = if active == (panels.length - 1) then 0
    else active + 1

    # move the current active panel offscreen
    $(panels[active]).animate({left: '-400px'})

    # put the next panel in position, and animate onscreen
    $(panels[next]).css({left: '400px'})
    $(panels[next]).animate({left: '0px'}, 1000)

    # next panel is now active panel
    active = next

    print 'rotate'

  window.setInterval(doRotation, 4000)

