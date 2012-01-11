# On doc ready
$ ->
  degToRad = (degrees)->
    degrees * Math.PI / 180
  getAngle = (x, y)->
    Math.tan(y / x)
  # User variables
  x = 0
  y = 0
  w = $(window).width()
  h = $(window).height()
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
  buildAxis = (scene, length = 50, radius = 0.5)->
    # center = new THREE.Mesh(new THREE.SphereGeometry(1, 10, 10), new THREE.MeshBasicMaterial(color: 0x000000))
    # scene.add(center)
    build = (coordinate)->
      colorMap =
        x: 0x00ffff # cyan
        y: 0xff00ff # magenta
        z: 0xffff00 # yellow
      material  = new THREE.MeshBasicMaterial(color: colorMap[coordinate])
      line      = new THREE.Mesh(new THREE.CylinderGeometry(.5, .5, length, 6, 1, false), material)
      arrow     = new THREE.Mesh(new THREE.CylinderGeometry(2, 0, 4, 20, 10, false), material)
      switch(coord)
        when 'x'
          line.position.x = length / 2
          line.rotation.z = degToRad(90)
          arrow.position.x = length
          arrow.rotation.z = line.rotation.z
        when 'y'
          line.position.y = length / 2
          line.rotation.z = degToRad(180)
          arrow.position.y = length
          arrow.rotation.z = line.rotation.z
        when 'z'
          line.position.z = length / 2
          line.rotation.z = degToRad(90)
          line.rotation.y = degToRad(90)
          arrow.position.z = length
          arrow.rotation.z = line.rotation.z
          arrow.rotation.y = line.rotation.y * -1
      scene.add(line)
      scene.add(arrow)
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
    camera.position.x = sphericalCoord.radius * Math.cos(degToRad(sphericalCoord.gamma)) * Math.sin(degToRad(sphericalCoord.tetha))
    camera.position.y = sphericalCoord.radius * Math.sin(degToRad(sphericalCoord.gamma))
    camera.position.z = sphericalCoord.radius * Math.cos(degToRad(sphericalCoord.gamma)) * Math.cos(degToRad(sphericalCoord.tetha))
    camera.lookAt(focus) if focus
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
  # Update
  setInterval(-> 
    cameraPositionX.updateDisplay()
    cameraPositionY.updateDisplay()
    cameraPositionZ.updateDisplay()
    cameraRotationX.updateDisplay()
    cameraRotationY.updateDisplay()
    cameraRotationZ.updateDisplay()
    applyCoordToCamera(coord, camera, plane.position)
    renderer.render(scene, camera)
  , 1000 / 60)
  # WebSocket
  ws = $.gracefulWebSocket("ws://127.0.0.0:8888")
  ws.onmessage = (event)->
    null

  $(document).mousemove (event)->
    x = event.pageX
    y = event.pageY
