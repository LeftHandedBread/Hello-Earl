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

#this is for the mannequin appearing logic. wish i set this up in a better way to make this cleaner
var axe = false
var house = false
var tower = false
var tree = false
var well = false
var hasSeenBedroom = false
var solvedBasement = false

var sungrav = false

enum Shoes {
	NONE = 0,
	NICOTINE = 1,
	COKE = 2,
	SUN = 3,
	GRAV = 4
}

enum Light {
	NONE = 0,
	NORMAL = 1,
	RED = 2,
	DARK = 3
}
