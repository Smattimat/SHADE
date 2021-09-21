extends KinematicBody2D

var Right=false
var Left=false
var Jump=false
var Muovi=false
export var colorazion = "Color"
var OcchiOpen=false
export var AlwaysOcchi=false

var BlueSkin=preload("res://Asset/Player & Person/Cubo Others noborder.png")
var RedSkin = preload("res://Asset/Player & Person/Cubo Others Red.png")
var GreenSkin=preload("res://Asset/Player & Person/Cubo Others Green.png")
var GraySkin=preload("res://Asset/Player & Person/Cubo Others Neutral.png")
var PinkSkin=preload("res://Asset/Player & Person/Cubo Others Pink.png")
var YellowSkin=preload("res://Asset/Player & Person/Cubo Others Yellow.png")
var PurpleSkin=preload("res://Asset/Player & Person/Cubo others purple.png")

func _ready():
	UpdateColor(colorazion)
	if AlwaysOcchi==true:
		$AnimationPlayer.play("Open")
	
	

func ImitatePlayer(var imitate,var L,var R,var J):
	if imitate==true:
		if AlwaysOcchi==false&&OcchiOpen==false:
			$AnimationPlayer.play("Open")
			OcchiOpen=true
		Muovi=true
		Left=L
		Right=R
		Jump=J
		$CollisionShape2D.scale.y=1
	else:
		if AlwaysOcchi==false&&OcchiOpen==true:
			$AnimationPlayer.play("Close")
			OcchiOpen=false
		Muovi=false
		Left=false
		Right=false
		Jump=false
		var rest=fposmod(-position.y, 32)
		if (rest<1  or rest>31):
			#sistemare
			if rest>16:
				position.y=position.y-rest		
			else:
				position.y=position.y+rest		
			$CollisionShape2D.scale.y=0.99
			position.y=position.y-0.32
		
func UpdateColor(Col):
	colorazion=Col
	if colorazion=="Blue":
		$Sprite.texture=BlueSkin
	elif colorazion=="Red":
		$Sprite.texture=RedSkin
	elif colorazion=="Green":
		$Sprite.texture=GreenSkin
	elif colorazion=="Gray":
		$Sprite.texture=GraySkin
	elif colorazion=="Pink":
		$Sprite.texture=PinkSkin
	elif colorazion=="Yellow":
		$Sprite.texture=YellowSkin
	elif colorazion=="Purple":
		$Sprite.texture=PurpleSkin
		
# Member variables
const GRAVITY = 1000.0 # pixels/second/second
const PUSH_FORCE = 1000
const WALK_MIN_SPEED =30
const WALK_MAX_SPEED = 320
const STOP_FORCE = 1250
const STOP_FORCE_AIR=350
const JUMP_SPEED = 450
const JUMP_MAX_AIRBORNE_TIME = 0.1

const SLIDE_STOP_VELOCITY = 0.4 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 0.5 # one pixel

var velocity = Vector2()
var vel= Vector2()
var on_air_time = 0
var jumping = false


var collision


var ap1
var ap2

func _physics_process(delta):
	if Muovi==true:
		var force = Vector2(0, GRAVITY)	
		var stop = true
	
		
			

		if is_on_floor():
			if on_air_time!=0:
				stop = true
			on_air_time = 0
			jumping = false
			velocity.y=0
			
				
		if is_on_ceiling():
			jumping = false
			if !Jump:
				velocity.y=10
		
		if is_on_wall():
			velocity.x=0
		
		if !is_on_floor():
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

		
		if jumping and velocity.y >= 0:
			# If falling, no longer jumping
			jumping = false
	
		if on_air_time < JUMP_MAX_AIRBORNE_TIME and Jump and not jumping:
			# Jump must also be allowed to happen if the character left the floor a little bit ago.
			# Makes controls more snappy.
			velocity.y = -JUMP_SPEED
			jumping = true
	
		var snap = Vector2.DOWN * 32 if !jumping else Vector2.ZERO

		
		# Integrate forces to velocity
		velocity += force * delta
		move_and_slide_with_snap(velocity, snap,Vector2(0, -1))	
		for i in get_slide_count():
			collision = get_slide_collision(i)
			if collision.collider.name=="MPlatform":
				pass	
			elif collision.collider.name=="SPlatform":
				move_and_collide( - get_floor_velocity() * delta)
			elif(collision.position.y > position.y ):
					move_and_collide( - get_floor_velocity() * delta)
			
				
				
		on_air_time += delta
	else:
		velocity.x=0
		velocity.y=0
