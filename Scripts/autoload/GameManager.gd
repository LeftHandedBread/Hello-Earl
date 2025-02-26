extends Node

## Place where some important variables™ are stored. 

var player : PlayerCharacter
var flashlightManager : Node3D
var flashlight_hitbox : Area3D
var isUpsideDown : bool
var characterShoes := Shoes.NONE
var currentLightType : Light = Light.NONE
var timeOfDay = 0.0
var timeSpeed = 0.002

enum Shoes {
	NONE = 0,
	NICOTINE = 1,
	COKE = 2
}

enum Light {
	NONE = 0,
	NORMAL = 1,
	RED = 2,
	DARK = 3
}
