///@category Overworld
///@title Culling
///@text These scripts are used for deactivating instances in the overworld if they are outside the camera view
///so the player can't see them load/unload, but still maintaining performance.

///@func CullObject(object)
///@desc Culls every isntance of the given object if it's outside the view
///@param {Asset.GMObject} object The object to cull
function CullObject(object) {
	forceinline
	static _hpad = 5, _vpad = 5;
	with object {
		var _bboxLeft = x - sprite_xoffset - _hpad,
			_bboxTop = y - sprite_yoffset - _vpad,
			_bboxRight = _bboxLeft + sprite_width + _hpad * 2,
			_bboxBottom = _bboxTop + sprite_height + _vpad * 2,
			_camx = Camera.GetPos("x"), _camy = Camera.GetPos("y"),
			_cam_width = Camera.GetAspect("w"), _cam_height = Camera.GetAspect("h"),
			_cull = !(
				(_bboxLeft < _camx + _cam_width) &&
				(_bboxTop < _camx + _cam_height) &&
				(_bboxRight > _camx) &&
				(_bboxBottom > _camx)
			);
		if _cull {
			instance_deactivate_object(id);
			ds_list_add(global.__deactivatedInstances, [id, _bboxLeft, _bboxTop, _bboxRight, _bboxBottom]);
		}
	}
}

///@func ProcessCulls()
///@desc Checks for all currently culled instances to see if they are now in view
function ProcessCulls() {
	forceinline
	var i = 0;
	repeat ds_list_size(global.__deactivatedInstances) {
		var _inst = global.__deactivatedInstances[| i],
			_camx = Camera.GetPos("x"), _camy = Camera.GetPos("y"),
			_cam_width = Camera.GetAspect("w"), _cam_height = Camera.GetAspect("h"),
			_not_culled = (
				(_inst[1] < _camx + _cam_width) &&
				(_inst[2] < _camy + _cam_height) &&
				(_inst[3] > _camx) &&
				(_inst[4] > _camy)
			);
		if _not_culled {
			instance_activate_object(_inst[0]);
			ds_list_delete(global.__deactivatedInstances, i--);
		}
		++i;
	}
}
///@text There are more functions of culling but they aren't needed in this engine.