extends Node2D

var Right=false
var Left=false
var Jump=false
var Muovi=false
export var colorazion = "Color"

var BlueSkin=preload("res://Asset/Player & Person/Cubo Others noborder.png")
var RedSkin = preload("res://Asset/Player & Person/Cubo Others Red.png")
var GreenSkin=preload("res://Asset/Player & Person/Cubo Others Green.png")
var GraySkin=preload("res://Asset/Player & Person/Cubo Others Neutral.png")
var PinkSkin=preload("res://Asset/Player & Person/Cubo Others Pink.png")
var YellowSkin=preload("res://Asset/Player & Person/Cubo Others Yellow.png")
var PurpleSkin=preload("res://Asset/Player & Person/Cubo others purple.png")

func _ready():
	UpdateColor(colorazion)
	
	

func ImitatePlayer(var imitate,var L,var R,var J):
	if imitate==true:
		Muovi=true
		Left=L
		Right=R
		Jump=J
	else:
		Muovi=false
		Left=false
		Right=false
		Jump=false
		
func UpdateColor(Col):
	colorazion=Col
	if colorazion=="Blue":
		$KPerson/Sprite.texture=BlueSkin
	elif colorazion=="Red":
		$KPerson/Sprite.texture=RedSkin
	elif colorazion=="Green":
		$KPerson/Sprite.texture=GreenSkin
	elif colorazion=="Gray":
		$KPerson/Sprite.texture=GraySkin
	elif colorazion=="Pink":
		$KPerson/Sprite.texture=PinkSkin
	elif colorazion=="Yellow":
		$KPerson/Sprite.texture=YellowSkin
	elif colorazion=="Purple":
		$KPerson/Sprite.texture=PurpleSkin
		
# Member variables
const GRAVITY = 1000.0 # pixels/second/second
const PUSH_FORCE = 1000
const WALK_MIN_SPEED =30
const WALK_MAX_SPEED = 320
const STOP_FORCE = 1100
const STOP_FORCE_AIR=300
const JUMP_SPEED = 450
const JUMP_MAX_AIRBORNE_TIME = 0.1

const SLIDE_STOP_VELOCITY = 0.4 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 0.5 # one pixel

var velocity = Vector2()
var vel= Vector2()
var on_air_time = 0
var jumping = false


var prev_jump_pressed = false
var collision


func _physics_process(delta):
	if Muovi==true:
		var force = Vector2(0, GRAVITY)	
		var stop = true
	
		

			

		if $KPerson.is_on_floor():
			if on_air_time!=0:
				stop = true
			on_air_time = 0
			jumping = false
			if !Jump:
				velocity.y=0
				
		if $KPerson.is_on_ceiling():
			jumping = false
			if !Jump:
				velocity.y=10
		
		if $KPerson.is_on_wall():
			velocity.x=0
		
		if on_air_time > JUMP_MAX_AIRBORNE_TIME:
			stop = false
		
		if Left:
			if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
				force.x-=PUSH_FORCE
				stop = false
		elif Right:
			if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
				force.x+=PUSH_FORCE
				stop = false
			
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		if stop:
			vlen -= STOP_FORCE * delta
		else:
			vlen -= STOP_FORCE_AIR * delta
		if vlen < 0:
			vlen = 0		
		velocity.x = vlen * vsign

		
		if jumping and velocity.y > 0:
			# If falling, no longer jumping
			jumping = false
	
		if on_air_time < JUMP_MAX_AIRBORNE_TIME and Jump and not prev_jump_pressed and not jumping:
			# Jump must also be allowed to happen if the character left the floor a little bit ago.
			# Makes controls more snappy.
			velocity.y = -JUMP_SPEED
			jumping = true
	
		var snap = Vector2.DOWN * 32 if !jumping else Vector2.ZERO
		# Integrate forces to velocity
		velocity += force * delta
		$KPerson.move_and_slide_with_snap(velocity, snap,Vector2(0, -1))	
		for i in $KPerson.get_slide_count():
			collision = $KPerson.get_slide_collision(i)
			if collision.collider.name=="MPlatform":
				pass
			elif(collision.position.y > $KPerson.position.y):
				$KPerson.move_and_collide( - $KPerson.get_floor_velocity() * delta)
				break
				
		on_air_time += delta
		prev_jump_pressed = Jump
	else:
		velocity.x=0
		velocity.y=0
