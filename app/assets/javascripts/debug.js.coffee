# # GUI
# gui = new dat.GUI()
# gui.add(coord, 'radius',  200, 600)
# gui.add(coord, 'tetha',  -180, 180)
# gui.add(coord, 'gamma',   -90, 90)
# # Camera properties
# cameraPosition  = gui.addFolder('Camera position')
# cameraPositionX = cameraPosition.add(camera.position, 'x')
# cameraPositionY = cameraPosition.add(camera.position, 'y')
# cameraPositionZ = cameraPosition.add(camera.position, 'z')
# cameraRotation  = gui.addFolder('Camera rotation')
# cameraRotationX = cameraRotation.add(camera.rotation, 'x')
# cameraRotationY = cameraRotation.add(camera.rotation, 'y')
# cameraRotationZ = cameraRotation.add(camera.rotation, 'z')
# # Axis
# buildAxis = (scene, length = 50)->
#   build = (coordinate)->
#     colorMap =
#       x: 0x00ffff # cyan
#       y: 0xff00ff # magenta
#       z: 0xffff00 # yellow
#     material = new THREE.LineBasicMaterial(color: colorMap[coordinate])
#     geometry = new THREE.Geometry()
#     switch(coord)
#       when 'x'
#         geometry.vertices.push(
#           new THREE.Vertex(new THREE.Vector3(-length, 0, 0)),
#           new THREE.Vertex(new THREE.Vector3( length, 0, 0))
#         )
#       when 'y'
#         geometry.vertices.push(
#           new THREE.Vertex(new THREE.Vector3(0, -length, 0)),
#           new THREE.Vertex(new THREE.Vector3(0,  length, 0))
#         )
#       when 'z'
#         geometry.vertices.push(
#           new THREE.Vertex(new THREE.Vector3(0, 0, -length)),
#           new THREE.Vertex(new THREE.Vector3(0, 0,  length))
#         )
#     line = new THREE.Line(geometry, material)
#     scene.add(line)
#   build coord for coord in ['x', 'y', 'z']
#   null
# buildAxis(scene)
# 
# updateDisplay = ->
#   # Update display
#   cameraPositionX.updateDisplay()
#   cameraPositionY.updateDisplay()
#   cameraPositionZ.updateDisplay()
#   cameraRotationX.updateDisplay()
#   cameraRotationY.updateDisplay()
#   cameraRotationZ.updateDisplay()
# - content_for :javascripts do
#   / GUI
#   %script{:src => '/assets/vendor/dat-gui/dat.gui.min.js'}
#   %script{:src => '/assets/vendor/stats.js'}
#   :coffeescript
#     $ ->
#       # Stats
#       stats = new Stats()
#       stats.domElement.style.position = 'absolute'
#       stats.domElement.style.marginRight = '-40px'
#       stats.domElement.style.bottom = '0px'
#       stats.domElement.style.right = '50%'
#       update = 0
#       
#       $('a[data-debug]').click ->
#         debug = Boolean $(this).data('debug')
#         $(this).data('debug', !debug)
#         if debug
#           $(document.body).append(stats.domElement).addClass('debug')
#           update = setInterval ->
#             stats.update()
#           , 1000 / 60
#         else
#           $(document.body).removeClass('debug')
#           $(stats.domElement).remove()