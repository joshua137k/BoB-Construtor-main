extends Node3D


var select_view
var mouse3D

@onready var Model_Button  = preload("res://Scenes/HUD/Model.tscn")
@onready var  posLoad = preload("res://Scenes/Models/Pos.tscn")
@onready var create_model = preload("res://Scenes/HUD/Models_Create.tscn")
@onready var Model : Node3D = $Model  #Aonde ficam os modelos
@onready var Select : Node3D = $Select #Seleção
@onready var Player :Node3D = $Player 
@onready var Cam :Camera3D = $Player/Camera
@onready var Ray:RayCast3D=$Player/Camera/RayCast3D
@onready var Gui=$"GUI/2D/Panel/vbox/Panel/Vbox/"


func _ready()->void:
	Index.world=$"."

func _input(event)->void:
	if event is InputEventMouseMotion:
		MouseMotion(event)
	elif event is InputEventMouseButton:
		MouseClick()



		
func MouseMotion(event)->void:
	var position2D=get_viewport().get_mouse_position()
	var dropPlane=Plane(Cam.global_transform.origin,1)
	mouse3D= dropPlane.intersects_ray(Cam.project_ray_origin(position2D),Cam.project_ray_normal(position2D))
	
	if mouse3D != null:
		Ray.look_at(mouse3D,Vector3.UP)
		if Ray.get_collider():
			Select.global_transform.origin = Ray.get_collision_point()
			Index.MousePos=Select.global_transform.origin
		else:
			Select.global_transform.origin = mouse3D
			Index.MousePos=Select.global_transform.origin
	
	if Input.is_action_pressed("click"):
		if mouse3D == null:
			Index.select=null
		else:
			if is_instance_valid(Index.select):
				Index.select.global_transform.origin = mouse3D.snapped(Vector3(Index.StepMoviment,Index.StepMoviment,Index.StepMoviment))
			if Input.is_action_pressed("right_click"):
					if is_instance_valid(Index.select):
						if Ray.get_collider():
							Index.select.get_child(0).collision_layer = 2
							Index.select.global_transform.origin = Ray.get_collision_point() + Vector3.UP/2
	else:
		if is_instance_valid(Index.select):
			Index.select.get_child(0).collision_layer=1


func MouseClick()->void:
	if Input.is_action_pressed("click") and is_instance_valid(select_view):
		select_propriety()
	elif (Input.is_action_pressed("click")) and !is_instance_valid(select_view) and !Index.MouseEntered:
		Index.select = null
		for i in($Pos.get_children()):
			i.queue_free()
	else:
		for i in($Pos.get_children()):
			i.queue_free()
	if Input.is_action_pressed("right_click") and is_instance_valid(Index.select)==false:
		for i in($"GUI/2D/Nod".get_children()):
			i.queue_free()
		var NewModel=create_model.instantiate()
		
		$"GUI/2D/Nod".add_child(NewModel)
		NewModel.global_position=NewModel.get_global_mouse_position()



func _on_timer_timeout():
	for x in($"GUI/2D/Tree/Vbox/Panel/Mesh".get_children()):
		x.queue_free()
	for i in(Model.get_children()):
		var mode = Model_Button.instantiate()
		mode.model = i
		$"GUI/2D/Tree/Vbox/Panel/Mesh".add_child(mode)


func select_propriety():
	Index.select = select_view
	var pos = posLoad.instantiate()
	$Pos.add_child(pos)
	$"GUI/2D/Panel/vbox/Panel/Vbox/Name".text = str(Index.select.name)
	Gui.get_node("Translate/Vbox/X").value = Index.select.transform.origin.x
	Gui.get_node("Translate/Vbox/Y").value = Index.select.transform.origin.y
	Gui.get_node("Translate/Vbox/Z").value = Index.select.transform.origin.z
	
	

	Gui.get_node("Rotation/Vbox/X").value = Index.select.rotation_degrees.x
	Gui.get_node("Rotation/Vbox/Y").value = Index.select.rotation_degrees.y
	Gui.get_node("Rotation/Vbox/Z").value = Index.select.rotation_degrees.z


func _on_area_body_entered(body):
	if body.name!= "not":
		body.get_parent().material_override.albedo_color = Color(0,1,1)
		select_view = body.get_parent()
	else:
		body.get_parent().material_override.albedo_color = Color(1, 0, 0.351563)


func _on_area_body_exited(body):
	if body.name!= "not":
		select_view=""
		body.get_parent().material_override.albedo_color = Color(0,0,0)


