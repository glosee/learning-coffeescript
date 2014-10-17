require "jquery"

class Modal extends PolarModule

  events = [
    'modal.beforeShowIn'
    'modal.showInComplete'
    'modal.beforeShowOut'
    'modal.showOutComplete'
    'modal.contentLodaded'
  ]


  constructor: (selector) ->
    $element = $ 'selector'
    @init()

  init: ->
    @initVariables()
    @initEvents()

  initVariables: ->

  initEvents: ->
    @bindEvent($element, "click", ".button-close")


