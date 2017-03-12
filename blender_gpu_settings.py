import bpy, _cycles

print(_cycles.available_devices())

bpy.context.scene.render.engine = 'CYCLES'
bpy.context.scene.cycles.device = 'GPU'
bpy.context.user_preferences.addons['cycles'].preferences.compute_device_type = 'CUDA'

# Larger tile sizes optimal for GPU processing
bpy.context.scene.render.tile_x = 256
bpy.context.scene.render.tile_y = 256
