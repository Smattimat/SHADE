extends KinematicBody2D

var colorazion = "Gray"

var Right=false
var Left=false
var Jump=false

var hasKey = false
var hasPhoto = false

var SadSkin= preload("res://Asset/Player & Person/Cubo triste sketch style gg copy.png")
var AngrySkin = preload("res://Asset/Player & Person/Cubo Cazzo sketch style copy.png")
var HappySkin=preload("res://Asset/Player & Person/Cubo Happy.png")
var EmpathicSkin=preload("res://Asset/Player & Person/Cubo Empatico.png")
var DepressedSkin=preload("res://Asset/Player & Person/Cubo Depre.png")
var Loveskin=preload("res://Asset/Player & Person/Cubo Innamorato.png")
var NeutralSkin=preload("res://Asset/Player & Person/Cubo Neutral.png")

export(String,FILE,"*.png") var BackLayer4Sprite 
export var BackLayer4Scale = 0
export (String,FILE,"*.png")var BackLayer3Sprite
export var BackLayer3Scale = 0.4
export (String,FILE,"*.png")var BackLayer2Sprite
export var BackLayer2Scale=0.6
export (String,FILE,"*.png")var BackLayer1Sprite
export var BackLayer1Scale=0.8
export var LevelAt="PrimUno"


func _ready():
	$ParallaxBackground/Back1.scale.x=BackLayer1Scale
	$ParallaxBackground/Back1/S1.texture= load(BackLayer1Sprite) 
	$ParallaxBackground/Back2.scale.x=BackLayer2Scale
	$ParallaxBackground/Back2/S2.texture=load(BackLayer2Sprite)
	$ParallaxBackground/Back3.scale.x=BackLayer3Scale
	$ParallaxBackground/Back3/S3.texture=load(BackLayer3Sprite)
	$ParallaxBackground/Back4.scale.x=BackLayer4Scale
	$ParallaxBackground/Back4/S4.texture=load(BackLayer4Sprite)

	
	
func MovePlayer(var L,var R,var J):
	Left=L
	Right=R
	Jump=J

func UpdateColor(var Col):
	colorazion=Col
	if Col=="Red":
		$Sprite.texture = AngrySkin
	elif Col=="Blue":
		$Sprite.texture=SadSkin
	elif Col=="Green":
		$Sprite.texture=HappySkin
	elif Col=="Pink":
		$Sprite.texture=Loveskin
	elif Col=="Gray":
		$Sprite.texture=NeutralSkin
	elif Col=="Yellow":
		$Sprite.texture=EmpathicSkin
	elif Col=="Purple":
		$Sprite.texture=DepressedSkin


func UpdateKey():
	if hasKey==true:
		$Key.visible=true
	else:
		$Key.visible=false

func UpdatePhoto():
	if hasPhoto==true:
		$Photo.visible=true
	else:
		$Photo.visible=false
	
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

func _physics_process(delta):
	# Create forces
	var force = Vector2(0, GRAVITY)	
	var stop = true
	
	
	if is_on_floor():
		if on_air_time!=0:
			stop = true
		on_air_time = 0	
		jumping=false
		velocity.y=0
		
			
	if is_on_ceiling():
		jumping = false
		if !Jump:
			velocity.y=10
	
	if is_on_wall():
		velocity.x=0
		
	#if on_air_time > JUMP_MAX_AIRBORNE_TIME:
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

	
