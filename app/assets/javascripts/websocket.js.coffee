# On doc ready
$ ->
  $container = $("#container")

  x = 0
  y = 0
  w = $(window).width()
  h = $(window).height()
  ws = $.gracefulWebSocket("ws://127.0.0.0:8888")

  ws.onmessage = (event)->
  null

  $(document).mousemove (event)->
    x = event.pageX
    y = event.pageY

  settings = 
    viewAngle: 45
    aspect: w / h
    near: 0.01
    far: 100

  camera    = new THREE.PerspectiveCamera(settings.viewAngle, settings.aspect, settings.near, settings.far)
  camera.position.y = 150;
  camera.position.z = 500;

  scene = new THREE.Scene()
  scene.add(camera)

  plane = new THREE.Mesh(new THREE.PlaneGeometry(200, 200), new THREE.MeshBasicMaterial(color: 0xe0e0e0))
  plane.rotation.x = - 90 * ( Math.PI / 180 )
  plane.overdraw = true
  scene.add(plane)
  
  renderer = new THREE.CanvasRenderer()
  renderer.setSize(w, h)
  renderer.render(scene, camera)

  $container.append(renderer.domElement)

  console.log w, h

  null