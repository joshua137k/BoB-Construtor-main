extends MeshInstance3D

var type:Mesh=BoxMesh.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_name("mesh")
	
	
	mesh=type
	var newTexture=StandardMaterial3D.new()
	material_override=newTexture
	create_convex_collision()
	
