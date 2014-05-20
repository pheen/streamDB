# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  setup = ->
    $('#cube').css
      '-webkit-transform': "translateZ(  "+ $(window).height() / 2 +"px )"
    $('#f1').css
      '-webkit-transform': "translateZ( -"+ $(window).height() / 2 +"px )"
    $('#f2').css
      '-webkit-transform': "rotateX( -90deg ) translateZ( "+ $(window).height() / 2 +"px ) rotate( 180deg ) matrix(-1, 0, 0, 1, 0, 0)",
      display: 'none'
    $('#f3').css
      '-webkit-transform': "rotateX(  90deg ) translateZ( "+ $(window).height() / 2 +"px ) rotate( 180deg ) matrix(-1, 0, 0, 1, 0, 0)",
      display: 'none'
  setup()

  $(window).on 'resize', ->
    setup()

  $('#p1').on 'click', ->
    $('#cube').css
      '-webkit-transform': "translateZ( "+ $(window).height() / 2 +"px )"
    #$('#f2')  .fadeOut()
    #$('#f3')  .fadeOut()

  $('#p2').on 'click', ->
    $('#f2')  .fadeIn()
    $('#f3')  .fadeOut()
    $('#cube').css
      '-webkit-transform': "translateZ( "+ $(window).height() / 2 +"px ) rotateX( -90deg )"

  $('#p3').on 'click', ->
    $('#f3')  .fadeIn()
    $('#f2')  .fadeOut()
    $('#cube').css
      '-webkit-transform': "translateZ( "+ $(window).height() / 2 +"px ) rotateX( 90deg )"
