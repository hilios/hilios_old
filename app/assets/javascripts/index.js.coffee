# On doc ready
$ ->
  degToRad = (degrees)->
    degrees * Math.PI / 180
  getAngle = (x, y)->
    Math.tan(y / x)
  # User variables
  x  = 0
  y  = 0
  w  = 0
  h  = 0
  pW = 0
  pH = 0
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
  # Axis
  buildAxis = (scene, length = 50)->
    build = (coordinate)->
      colorMap =
        x: 0x00ffff # cyan
        y: 0xff00ff # magenta
        z: 0xffff00 # yellow
      material = new THREE.LineBasicMaterial(color: colorMap[coordinate])
      geometry = new THREE.Geometry()
      switch(coord)
        when 'x'
          geometry.vertices.push(
            new THREE.Vertex(new THREE.Vector3(-length, 0, 0)),
            new THREE.Vertex(new THREE.Vector3( length, 0, 0))
          )
        when 'y'
          geometry.vertices.push(
            new THREE.Vertex(new THREE.Vector3(0, -length, 0)),
            new THREE.Vertex(new THREE.Vector3(0,  length, 0))
          )
        when 'z'
          geometry.vertices.push(
            new THREE.Vertex(new THREE.Vector3(0, 0, -length)),
            new THREE.Vertex(new THREE.Vector3(0, 0,  length))
          )
      line = new THREE.Line(geometry, material)
      scene.add(line)
    build coord for coord in ['x', 'y', 'z']
    null
  buildAxis(scene)
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
    a = 5
    x = sphericalCoord.radius * Math.cos(degToRad(sphericalCoord.gamma)) * Math.sin(degToRad(sphericalCoord.tetha))
    y = sphericalCoord.radius * Math.sin(degToRad(sphericalCoord.gamma))
    z = sphericalCoord.radius * Math.cos(degToRad(sphericalCoord.gamma)) * Math.cos(degToRad(sphericalCoord.tetha))
    
    camera.position.x = (camera.position.x - x) / a
    camera.position.y = (camera.position.y - y) / a
    camera.position.z = (camera.position.z - z) / a
    camera.lookAt(focus) if focus
    
    console.log(camera.position.x, camera.position.y, camera.position.z)
  # GUI
  gui = new dat.GUI()
  gui.add(coord, 'radius',  200, 600)
  gui.add(coord, 'tetha',  -180, 180)
  gui.add(coord, 'gamma',   -90, 90)
  # Camera properties
  cameraPosition  = gui.addFolder('Camera position')
  cameraPositionX = cameraPosition.add(camera.position, 'x')
  cameraPositionY = cameraPosition.add(camera.position, 'y')
  cameraPositionZ = cameraPosition.add(camera.position, 'z')
  cameraRotation  = gui.addFolder('Camera rotation')
  cameraRotationX = cameraRotation.add(camera.rotation, 'x')
  cameraRotationY = cameraRotation.add(camera.rotation, 'y')
  cameraRotationZ = cameraRotation.add(camera.rotation, 'z')
  # Motion
  render = ->
    applyCoordToCamera(coord, camera, plane.position)
    renderer.render(scene, camera)
    # Update display
    cameraPositionX.updateDisplay()
    cameraPositionY.updateDisplay()
    cameraPositionZ.updateDisplay()
    cameraRotationX.updateDisplay()
    cameraRotationY.updateDisplay()
    cameraRotationZ.updateDisplay()
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
    coord.tetha =  0 + (-10 + 20 * pW)
    coord.gamma = 45 + (-10 + 20 * pH)