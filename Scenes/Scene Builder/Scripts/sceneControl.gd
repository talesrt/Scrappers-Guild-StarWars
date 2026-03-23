extends Node3D

@onready var cameraView := get_node("ViewerRoot/Camera3D")
@onready var viewer := get_node("ViewerRoot")
@onready var lightSource := get_node("WorldRoot")

@export var mouse_sensitivity := 2.0
@export var zoomScale := 8

var mouseDelta : Vector2 = Vector2()
var rot : Vector2 = Vector2()
var zoomFactor := 8.0
var mousePos : Vector2 = Vector2()

var startZoom := Vector3()
var startLight := Vector3()
var startViewerRot := Vector3()
var startViewerPos := Vector3()

func _ready():
	mouse_sensitivity = mouse_sensitivity / 1000
	startZoom = cameraView.position
	startLight = lightSource.rotation
	startViewerPos = viewer.position
	startViewerRot = viewer.rotation
	print(str("Zoom:",startZoom,"/Light: ",startLight,"/Viewer Pos: ",startViewerPos,"/Viewer Rot: ", startViewerRot))
	
#-------- INPUT EVENT--------
func _input(event):
	
# ---- Reset View ----
	if Input.is_action_just_pressed("reset_view"):
		reset_view()
	
#-------- Movement Events --------
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
	
	if event is InputEventMouseButton:
		event as InputEventMouseButton
		if event.pressed:
			
			match event.button_index:
				MOUSE_BUTTON_WHEEL_UP:
					#print("up")
					zoomFactor = cameraView.position.z - position.z
					zoomFactor = zoomFactor/zoomScale
					cameraView.translate(Vector3(0,0,-1) * zoomFactor)
					print(zoomFactor)
					
			match event.button_index:
				MOUSE_BUTTON_WHEEL_DOWN:
					#print("Down")
					zoomFactor = cameraView.position.z - position.z
					zoomFactor = zoomFactor/zoomScale
					cameraView.translate(Vector3(0,0,1) * zoomFactor)
					print(zoomFactor)
	
	#---- Camera Rotation
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) == true:
		viewer.rotation += Vector3(-mouseDelta.y, -mouseDelta.x, 0) * mouse_sensitivity
		print(str("rotate",mouseDelta))
	
	#---- Camera Pan
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE) == true:
		var slideCamera := Vector3(-mouseDelta.x, mouseDelta.y, 0) * mouse_sensitivity * 2
		viewer.translate(slideCamera)
		print(str("move",slideCamera))
		
	#---- Light Rotation
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) == true:
		lightSource.rotation += Vector3(mouseDelta.y, mouseDelta.x, 0) * mouse_sensitivity
		print(str("Light rotate",mouseDelta))

func _process(delta):
	
	pass

func reset_view() -> void:
	cameraView.set_position(startZoom)
	lightSource.set_rotation(startLight)
	viewer.set_position(startViewerPos)
	viewer.set_rotation(startViewerRot)
