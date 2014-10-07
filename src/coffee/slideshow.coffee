# This code is %99 the examples from Smashing Coffeescript
# and %1 my own. It is for educational purposes only.

# @param slideshow An HTML <ul> element with <li> nodes as children
rotator = (slideshow) ->
  $panels = $(slideshow).find('li')
  return if $panels.length < 2 # can't rotate with fewer than 2 panels

  # initialization properties
  $slideshow = $(slideshow)
  active = $slideshow.data('start') ? 0
  direction = $slideshow.data('direction') ? 1 # 0 = right 1 = left
  duration = $slideshow.data('duration') ? 4000
  speed = $slideshow.data('speed') ? 1000

  # returns an object that the jQuery css method can digest based on the
  # direction and the value you pass in
  css_setting = (value) ->
    # FIXME: For some reason when using 'right' it does not work very well
    style = {}
    style[if direction == 1 then 'left' else 'right'] = value
    return style

  # move panels into initial position
  $(panel).css(css_setting '100%') for panel in $panels
  $($panels[active]).css(css_setting '0px')

  doRotation = ->

    # console.log 'tick'

    # which panel to show next
    next = (active + direction + $panels.length) % $panels.length

    # move the current active panel offscreen
    # remember that css_setting is a function, and this is how
    # you call a function with arguments: no parentheses and no
    # comma between args.
    $($panels[active]).animate(css_setting '-100%')

    # put the next panel in position, and animate onscreen
    $($panels[next])
      .css(css_setting '100%')
      # note that `css_setting` is a method call with an argument of '0px'
      # the two arguments to the `animate` method are the result of
      # `css_setting` and `speed`. The comma separates args within
      # the parentheses of the surrounding method call, but not of the
      # internal call to `css_setting`
      .animate(css_setting '0px', speed)

    # the 'next' panel is now active
    active = next

  #window.setInterval(doRotation, duration)

  # create a button to control the slideshow and add it to the stage
  control = $('<button></button>').insertAfter(slideshow)
  timer = null

  # call this to start the slideshow
  doStart = ->
    timer = window.setInterval(doRotation, duration)
    control.text('pause')

  # call this to stop the slideshow
  doStop = ->
    window.clearInterval timer
    timer = null
    control.text('play')

  # listen to clicks on the control button and play or pause the slideshow
  $(control).on 'click', ->
    if timer then doStop()
    else doStart()

  # listen for custom events on the body for starting and stopping multiple
  # slideshows with multiple triggers
  $('body').on 'slideshow.stop', ->
    doStop()

  $('body').on 'slideshow.start', ->
    doStart()

  doStart() # let's start the show

# jQuery ready
$ -> rotator(slideshow) for slideshow in $.find('.slideshow')




