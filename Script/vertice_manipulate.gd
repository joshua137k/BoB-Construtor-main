extends Area3D

var MouseEnter:bool
var MouseClicked:bool
enum{top,bottom,left,right,forward,backward}
var state
var diagonalState

func _ready():
	$MeshInstance3D.material_override=StandardMaterial3D.new()
	if position.y==0.5:
		state=top
	elif position.y==-0.5:
		state=bottom


	if position.x==0.5:
		state=right
	elif position.x==-0.5:
		state=left

	if position.z==0.5:# or position.x==-0.5 and position.z>0.4:
		state=forward
	elif  position.z==-0.5:# 
		state=backward
	
	SetStates()




func _input(event):
	if Input.is_action_pressed("click") and MouseEnter and state==top: #and lado==top:
		position.y-=0.01
		move()


func move():
	for i in get_tree().get_nodes_in_group("mani"):
		if i.state==backward or i.diagonalState==backward:
			i.position.z-=0.0001
		elif i.state==forward or i.diagonalState==forward:
			i.position.z+=0.0001


func _on_area_entered(area):
	if area.get_parent().name == "Select":
		MouseEnter=true





func _on_area_exited(area):
	if area.get_parent().name == "Select" and !MouseClicked:
		MouseEnter=false


func SetStates():
		#TOP
	if (position.y>0.4 and position.x==0.5):
		diagonalState=top
	elif (position.y>0.4 and position.x==-0.5):
		diagonalState=top
	elif (position.y>0.4 and position.z==-0.5):
		diagonalState=top
	elif (position.y>0.4 and position.z==0.5):
		diagonalState=top
	#BOTTOM
	if (position.y<-0.4 and position.x==0.5):
		diagonalState=bottom
	elif (position.y<-0.4 and position.x==-0.5):
		diagonalState=bottom
	elif (position.y<-0.4 and position.z==-0.5):
		diagonalState=bottom
	elif (position.y<-0.4 and position.z==0.5):
		diagonalState=bottom
#BACKWARD
	if (position.z<-0.4 and position.x==0.5):
		diagonalState=backward
	elif (position.z<-0.4 and position.x==-0.5):
		diagonalState=backward
	elif (position.z<-0.4 and position.y==-0.5):
		diagonalState=backward
	elif (position.z<-0.4 and position.y==0.5):
		diagonalState=backward

#Forward
	if (position.z>0.4 and position.x==0.5):
		diagonalState=forward
	elif (position.z>0.4 and position.x==-0.5):
		diagonalState=forward
	elif (position.z>0.4 and position.y==-0.5):
		diagonalState=forward
	elif (position.z>0.4 and position.y==0.5):
		diagonalState=forward

#Right
	if (position.x>0.4 and position.z==0.5):
		diagonalState=right
	elif (position.x>0.4 and position.z==-0.5):
		diagonalState=right
	elif (position.x>0.4 and position.y==-0.5):
		diagonalState=right
	elif (position.x>0.4 and position.y==0.5):
		diagonalState=right
#LEft
	if (position.x<-0.4 and position.z==0.5):
		diagonalState=left
	elif (position.x<-0.4 and position.z==-0.5):
		diagonalState=left
	elif (position.x<-0.4 and position.y==-0.5):
		diagonalState=left
	elif (position.x<-0.4 and position.y==0.5):
		diagonalState=left


#or (position.y==0.5 and position.z<-0.4) or (position.y==-0.5 and position.z<-0.4) or ( position.x==0.5 and position.z<-0.4): #or position.x==0.5 and position.z<-0.4:
