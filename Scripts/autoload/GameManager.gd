extends Node

## Place where some important variables™ are stored. 

var player : PlayerCharacter
var flashlight : SpotLight3D = null	
@onready var flashlight_hitbox = $head/flashlight/Cone_006/Area3D
var isUpsideDown : bool
var characterShoes := Shoes.NONE
enum Shoes {
	NONE = 0,
	NICOTINE = 1,
	COKE = 2
}
