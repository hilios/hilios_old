# On doc ready
$ ->
  degToRad = (degrees)->
    degrees * Math.PI / 180
  getAngle = (x, y)->
    Math.atan(y / x)
  # User variables
  w = $(window).width()
  h = $(window).height()
  x  = 0
  y  = 0
  # Camera settings
  settings = 
    viewAngle:  45
    aspect:     w / h
    near:       1
    far:        1000
  # Camera
  camera = new THREE.PerspectiveCamera(settings.viewAngle, settings.aspect, settings.near, settings.far)
  # Scene
  scene = new THREE.Scene()
  scene.add(camera)
  #
  # Plane
  plane = new THREE.Mesh(new THREE.PlaneGeometry(w / 3, 200), new THREE.MeshBasicMaterial(color: 0x000000, opacity: 0.2))
  plane.rotation.x = degToRad(-90)
  plane.doubleSided = true
  plane.overdraw = true
  scene.add(plane)
  # Renderer
  renderer = new THREE.CanvasRenderer()
  renderer.setSize(w, h)
  renderer.render(scene, camera)
  # Add the renderer to dom
  $container = $("#container")
  $container.append(renderer.domElement)
  # http://en.wikipedia.org/wiki/Spherical_coordinates
  coord =
    radius: 400
    tetha:  0 # latitude  (zenith)
    gamma: 45 # longitude (azimuth)
  applyCoordToCamera = (sphericalCoord, camera, focus)->
    acceleration = 12
    x = sphericalCoord.radius * Math.cos(degToRad(sphericalCoord.gamma)) * Math.sin(degToRad(sphericalCoord.tetha))
    y = sphericalCoord.radius * Math.sin(degToRad(sphericalCoord.gamma))
    z = sphericalCoord.radius * Math.cos(degToRad(sphericalCoord.gamma)) * Math.cos(degToRad(sphericalCoord.tetha))
    camera.position.x += (x - camera.position.x) / acceleration
    camera.position.y += (y - camera.position.y) / acceleration
    camera.position.z += (z - camera.position.z) / acceleration
    camera.lookAt(focus) if focus
    null
  # Motion
  render = ->
    applyCoordToCamera(coord, camera, plane.position)
    renderer.render(scene, camera)
  animate = ->
    requestAnimationFrame(animate)
    render()
  animate()
  # WebSocket
  ws = $.gracefulWebSocket("ws://127.0.0.0:8888")
  ws.onmessage = (event)->
    null
  # Browser events
  $(document).mousemove (event)->
    w  = $(window).width()
    h  = $(window).height()
    x  = event.pageX
    y  = event.pageY
    pW = x / w
    pH = y / h
    coord.tetha =  0 + (-15 + 30 * pW)
    coord.gamma = 45 + (-15 + 30 * pH)
    camera.aspect = w / h