class_name RayCastingComponent
extends Node2D

func check(dir:Vector2) -> Object:
	var raycast: RayCast2D = null
	
	match dir:
		Vector2(0, -1): raycast =  $UpCast
		Vector2(0, 1): raycast = $DownCast
		Vector2(-1, 0): raycast = $LeftCast
		Vector2(1, 0): raycast = $RightCast
		Vector2(-1, -1): raycast = $UpLeftCast
		Vector2(1, -1): raycast = $UpRightCast
		Vector2(-1, 1): raycast = $DownLeftCast
		Vector2(1, 1): raycast = $DownRightCast
		_:
			return null
		
	if raycast == null:
		return null
	
	raycast.force_raycast_update()
	
	return raycast.get_collider()
