extends Node

func roll_dice(dice_num:int, faces:int) -> int:
	print("Rolling %d d%ds" % [dice_num, faces])
	var total: int = 0
	for i in dice_num:
		var roll_val = randi_range(1, faces)
		total += roll_val
		print("Rolling d%d: %d" % [faces, roll_val])
	print("Finised rolls result: %d" % total)
	return total

func roll_for_sixes(dice_num:int) -> int:
	print("Rolling for sixes # dice: %d" % dice_num)
	var num_of_sixes: int = 0
	for i in dice_num:
		var roll_val = randi_range(1, 6)
		print("Rolling d6: %d" % roll_val)
		if roll_val == 6:
			num_of_sixes += 1
	print("Finished rolling for sixes result: %d" % num_of_sixes)
	return num_of_sixes
