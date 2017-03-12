import bpy, _cycles

print(_cycles.available_devices())

bpy.context.scene.render.engine = 'CYCLES'
bpy.context.scene.cycles.device = 'CPU'

# Smaller tile sizes optimal for CPU processing
bpy.context.scene.render.tile_x = 16
bpy.context.scene.render.tile_y = 16
