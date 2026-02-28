extends Node3D

@onready var cameraView := get_node("Camera3D")
@onready var placer := get_node("Placer")

@export var mouse_sensitivity := 2.0
@export var zoomScale := 8

var mouseDelta : Vector2 = Vector2()
var rot : Vector2 = Vector2()
var zoomFactor := 8.0
var mousePos : Vector2 = Vector2()



func _ready():
	mouse_sensitivity = mouse_sensitivity / 1000

func _input(event):
	mousePos = event.position
	
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
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) == true:
		rotation += Vector3(-mouseDelta.y, -mouseDelta.x, 0) * mouse_sensitivity
		print(str("rotate",mouseDelta))
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE) == true:
		var slideCamera := Vector3(-mouseDelta.x, mouseDelta.y, 0) * mouse_sensitivity * 2
		translate(slideCamera)
		print(str("move",slideCamera))

func _process(delta):
	
	pass
