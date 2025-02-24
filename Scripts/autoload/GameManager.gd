extends Node

## Place where some important variables™ are stored. 

var player : PlayerCharacter
var flashlight : SpotLight3D = null	
var flashlight_hitbox : Area3D = null
var isUpsideDown : bool
var characterShoes := Shoes.NONE
enum Shoes {
	NONE = 0,
	NICOTINE = 1,
	COKE = 2
}
