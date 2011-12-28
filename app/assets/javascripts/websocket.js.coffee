
ws = $.gracefulWebSocket("ws://127.0.0.0:8888");

ws.onmessage = (event)->
  null

$(document).mousemove (event)->
  x = event.pageX
  y = event.pageY