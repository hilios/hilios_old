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
  camera.rotation.x = degToRad(-45)
  camera.position.y = 300
  camera.position.z = 300
  # Scene
  scene = new THREE.Scene()
  scene.add(camera)
  # Axis
  buildAxis = (scene, length = 50, radius)->
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
  plane.overdraw = true
  scene.add(plane)
  # Renderer
  renderer = new THREE.CanvasRenderer()
  renderer.setSize(w, h)
  renderer.render(scene, camera)
  # Add the renderer to dom
  $container = $("#container")
  $container.append(renderer.domElement)
  # 
  position =
    x: 0
    y: 45
    r: 500
  applyPosition = (position, camera, focus)->
    # camera.position.x = position.r * Math.sin degToRad(position.x)
    # camera.position.z = position.r * Math.sin degToRad(position.y)

    camera.position.y = position.r * Math.sin degToRad(position.y)
    camera.position.z = position.r * Math.cos degToRad(position.y)

    camera.lookAt(focus.position) if focus
  # GUI
  gui = new dat.GUI()
  gui.add(position, 'r', 100, 500).name('radius')
  gui.add(position, 'x', -180, 180)
  gui.add(position, 'y', 20, 90)
  # Update
  setInterval(-> 
    applyPosition(position, camera, plane)
    renderer.render(scene, camera)
  , 1000 / 60)
  # WebSocket
  ws = $.gracefulWebSocket("ws://127.0.0.0:8888")
  ws.onmessage = (event)->
    null

  $(document).mousemove (event)->
    x = event.pageX
    y = event.pageY
