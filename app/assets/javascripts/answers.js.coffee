# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(".vote-ans").live "click", (e) ->
  $.post $(this).attr("href"), $(this).serialize(), (->
    $(".alert").delay(5000).slideUp "slow"
  ), "script"
  e.preventDefault()

$(".new_answer").live "submit", (e) ->
  $.post $(this).attr("action"), $(this).serialize(), null, "script"
  e.preventDefault()
