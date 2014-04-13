# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # Cache the Window object
  $window = $(window)
                
  $('section[data-type="background"]').each ->
    $bgobj = $(this) # assigning the object
                    
    $(window).scroll ->
      # Scroll the background at var speed
      # the yPos is a negative value because we're scrolling it UP!                
      yPos = -($window.scrollTop() / $bgobj.data('speed')) 
      
      # Put together our final background position
      coords = '50% '+ yPos + 'px'

      # Move the background
      $bgobj.css({ backgroundPosition: coords })


  $('a.show_form').on 'click', ->
    $('#login_form').toggle()

  $('#update').on 'click', ->
    $.get 'streams/update', (json) ->
      alert(json.queued)

  $(document).keydown (e) ->
    if e.keyCode == 37
      debugger
      e.keyCode