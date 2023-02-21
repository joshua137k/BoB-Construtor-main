
extends Node3D

@onready var Soft=$SoftBody3D2
@onready var meshP=preload("res://Scenes/Models/mesh.tres")
@onready var NewManipulate = preload("res://Scenes/vertice_manipulate.tscn")

var manicount
var vert = PackedInt32Array()
var vertices=4




# Called when the node enters the scene tree for the first time.
func _ready():
	
	var mesh = ArrayMesh.new()
	meshP.subdivide_depth=vertices
	meshP.subdivide_height=vertices
	meshP.subdivide_width=vertices
	var mdt = MeshDataTool.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, meshP.get_mesh_arrays())
	mdt.create_from_surface(mesh, 0)
	for i in range(mdt.get_vertex_count()):
		var vertex = mdt.get_vertex(i)
		vertex -= mdt.get_vertex_normal(i)
		mdt.set_vertex(i, vertex)
		vert.append(i)
		
	mdt.commit_to_surface(mesh)
	
	Soft.mesh = mesh
	Soft.pinned_points=vert
	for i in range(mdt.get_vertex_count()):
		var new=NewManipulate.instantiate()
		new.position=Soft.get_point_transform(i)
		
		add_child(new)

		Soft.set("attachments/"+str(i)+"/spatial_attachment_path",new.get_path())
		
	#for i in range(mdt.get_vertex_count()):
		#Soft.set_point_pinned(i,true)

