$ ->
  # Common scope variables
  windowWidth   = 0
  windowHeight  = 0
  planeWidth    = 0
  planeHeight   = 0 
  camera        = null
  scene         = null
  plane         = null
  renderer      = null
  # http://en.wikipedia.org/wiki/Spherical_coordinates
  sphericalCoordinates =
    radius: 400
    tetha:    0 # latitude  (zenith)
    gamma:   45 # longitude (azimuth)
  # Return an object with the cartesian coordinates
  sphericalToCartesian = (coordinates)->
    x: coordinates.radius * Math.cos(degToRad(coordinates.gamma)) * Math.sin(degToRad(coordinates.tetha))
    y: coordinates.radius * Math.sin(degToRad(coordinates.gamma))
    z: coordinates.radius * Math.cos(degToRad(coordinates.gamma)) * Math.cos(degToRad(coordinates.tetha))
  # Convert degrees to radians
  degToRad = (degrees)->
    degrees * Math.PI / 180
  # Get the angle between two points
  getAngle = (x, y)->
    Math.atan(y / x)
  # On resize re-calculate everything
  $(window).resize (e)->
    # Window properties
    windowWidth   = $(window).width()
    windowHeight  = $(window).height()
    # Plane properties
    planeWidth    = windowWidth / 3
    planeHeight   = 200
    # Camera
    camera = new THREE.PerspectiveCamera(45, windowWidth / windowHeight, 1, 1000)
    camera.position.x = sphericalToCartesian(sphericalCoordinates).x
    camera.position.y = sphericalToCartesian(sphericalCoordinates).y
    camera.position.z = sphericalToCartesian(sphericalCoordinates).z
    # Scene
    scene = new THREE.Scene()
    scene.add(camera)
    # Plane
    plane = new THREE.Mesh(new THREE.PlaneGeometry(planeWidth, planeHeight), new THREE.MeshBasicMaterial(color: 0x000000, opacity: 0.2))
    plane.rotation.x  = degToRad(-90)
    plane.doubleSided = true
    plane.overdraw    = true
    scene.add(plane)
    # Renderer
    renderer = new THREE.CanvasRenderer()
    renderer.setSize(windowWidth, windowHeight)
    renderer.render(scene, camera)
    # Continue the event chain
    true
  # Execute in the first time
  $(window).trigger('resize')
  # Add the renderer to dom
  $container = $("#container")
  $container.append(renderer.domElement)
  # Motion
  render = ->
    coordinates = sphericalToCartesian(sphericalCoordinates)
    # Animate the camera
    camera.position.x += (camera.position.x - coordinates.x) / 12
    camera.position.y += (camera.position.y - coordinates.y) / 12
    camera.position.z += (camera.position.z - coordinates.z) / 12
    # Focus on the plane
    camera.lookAt(plane)
    # Apply the changes
    renderer.render(scene, camera)
  # Request animation frame
  # http://paulirish.com/2011/requestanimationframe-for-smart-animating/
  animate = ->
    requestAnimationFrame(animate)
    render()
  # Execute
  animate()
  # WebSocket
  ws = $.gracefulWebSocket("ws://127.0.0.0:8888")
  ws.onmessage = (event)->
    # Continue the event chain
    true
  # Browser events
  $(document).mousemove (event)->
    percentageWidth  = event.pageX / windowWidth
    percentageHeight = event.pageY / windowHeight
    coord.tetha =  0 + (-15 + 30 * pW)
    coord.gamma = 45 + (-15 + 30 * pH)
    # Continue the event chain
    true