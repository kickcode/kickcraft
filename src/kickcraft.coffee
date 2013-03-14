class KickCraft
  constructor: (@container, @data, @materials = [], @colors = {})->
    createGame = require('voxel-engine')
    texturePath = require('painterly-textures')(__dirname)
    @materials.unshift(['grass', 'dirt', 'grass_dirt'])

    height = Object.keys(@data).length
    if height > 0
      width = Object.keys(@data[0]).length
    else
      width = 0

    game = createGame
      texturePath: texturePath,
      generate: (x, y, z)=>
        return 1 if y == 1
        local_x = parseInt(x + (width / 2))
        local_y = parseInt((height - y) - (height / 5))
        row = @data[local_y]
        if row
          column = @data[local_y][local_x]
          if column && column.a && column.a > 0
            if z == -50
              return @colors[[column.r, column.g, column.b].join(",")] || 1
        return 0
      ,
      startingPosition: [0, 100, 0],
      materials: @materials

    game.controls.pitchObject.rotation.x = 0.4

    game.appendTo(@container)
    game.setupPointerLock(@container)

window.KickCraft = KickCraft