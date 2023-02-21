extends PanelContainer


func _process(_delta: float) -> void:
	
	$vbox/Panel/Vbox/Translate.visible = is_instance_valid(Index.select)
	$vbox/Panel/Vbox/Rotation.visible = is_instance_valid(Index.select)
	
	Index.StepMoviment=$vbox/Panel/Vbox/Translate/Vbox/Step.value
	
	$vbox/Panel/Vbox/Translate/Vbox/X.step=$vbox/Panel/Vbox/Translate/Vbox/Step.value
	$vbox/Panel/Vbox/Translate/Vbox/Y.step=$vbox/Panel/Vbox/Translate/Vbox/Step.value
	$vbox/Panel/Vbox/Translate/Vbox/Z.step=$vbox/Panel/Vbox/Translate/Vbox/Step.value
	
	$vbox/Panel/Vbox/Rotation/Vbox/X.step=$vbox/Panel/Vbox/Rotation/Vbox/Step.value
	$vbox/Panel/Vbox/Rotation/Vbox/Y.step=$vbox/Panel/Vbox/Rotation/Vbox/Step.value
	$vbox/Panel/Vbox/Rotation/Vbox/Z.step=$vbox/Panel/Vbox/Rotation/Vbox/Step.value
	
	
	if is_instance_valid(Index.select) and !Index.MouseEntered:
		
		$vbox/Nome.text = Index.select.name
		
		$vbox/Panel/Vbox/Translate/Vbox/X.value = Index.select.transform.origin.x
		$vbox/Panel/Vbox/Translate/Vbox/Y.value = Index.select.transform.origin.y
		$vbox/Panel/Vbox/Translate/Vbox/Z.value = Index.select.transform.origin.z
		#Rot
		$vbox/Panel/Vbox/Rotation/Vbox/X.value = Index.select.rotation.x
		$vbox/Panel/Vbox/Rotation/Vbox/Y.value = Index.select.rotation.y
		$vbox/Panel/Vbox/Rotation/Vbox/Z.value = Index.select.rotation.z
		
	
	elif is_instance_valid(Index.select) and Index.MouseEntered:
		Index.select.transform.origin.x=$vbox/Panel/Vbox/Translate/Vbox/X.value
		Index.select.transform.origin.y=$vbox/Panel/Vbox/Translate/Vbox/Y.value
		Index.select.transform.origin.z=$vbox/Panel/Vbox/Translate/Vbox/Z.value
		
		#Rot
		Index.select.rotation.x = $vbox/Panel/Vbox/Rotation/Vbox/X.value
		Index.select.rotation.y = $vbox/Panel/Vbox/Rotation/Vbox/Y.value
		Index.select.rotation.z = $vbox/Panel/Vbox/Rotation/Vbox/Z.value
	
	
	
	elif !is_instance_valid(Index.select):
		$vbox/Nome.text = "NENHUM NODE SELECIONADO"
		




func _on_mouse_entered_mouse_entered():
	Index.MouseEntered=true


func _on_mouse_entered_mouse_exited():
	Index.MouseEntered=false


