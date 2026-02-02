extends RefCounted
class_name Quest

var id : int
var location_details : LocationDetails
var name : String
var minimum_level : float
var brick_availabilities : Dictionary[GameConstants.BrickType, float]
