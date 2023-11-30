function __Camera() constructor
{
	///Initalizes the camera variables
	static Init = function()
	{
		oGlobal.MainCamera = {};
		with oGlobal.MainCamera
		{
			x = 0;
			y = 0;
			Scale = [1, 1];
			view_width = 640;
			view_height = 480;
			shake_i = 0;
			decrease_i = 1;
			angle = 0;
			target = noone;
			previous_target = noone;
			//camera angle will not matter when z is enabled
			enable_z = false;
			// Set up 3D camera
			camDist	= -240;
			camFov	= 90;
			camAsp	= view_width / view_height;
			camXDisplace = 0;
			camYDisplace = 0;
			// Rotation
			camAngleXRaw = 90;
			camAngleYRaw = 0;
			camAngleX = camAngleXRaw;
			camAngleY = camAngleYRaw;
			camAngleXShake = 0;
			camAngleYShake = 0;
		}
	}
	/**
		Shakes the Camera
		@param {real} Amount	The amount in pixels to shake
		@param {real} Decrease	The amount of intensity to decrease after each frame
	*/
	static Shake = function(amount, decrease = 1)
	{
		with oGlobal.MainCamera
		{
			shake_i = ceil(amount);
			decrease_i = ceil(decrease);
			if enable_z
			{
				camAngleXShake = amount / 2;
				camAngleYShake = -amount / 2;
			}
		}
	}
	/**
		Sets the scale of the Camera
		@param {real} x_scale		The X scale of the camera
		@param {real} y_scale		The Y scale of the camera
		@param {real} duration		The anim duration of the scaling
		@param {function,string} ease		The easing of the animation
	*/
	static Scale = function(sx, sy, duration = 0, ease = "")
	{
		with oGlobal.MainCamera TweenFire("~", ease, "$", duration, TPArray(Scale, 0), Scale[0], sx, TPArray(Scale, 1), Scale[1], sy);
	}
	/**
		Sets the X and Y position of the Camera
		@param {real}				x The x position
		@param {real}				y The y position
		@param {real} duration		The anim duration of the movement
		@param {real} delay			The anim delay of the movement
		@param {function,string} ease		The easing of the animation
	*/
	static SetPos = function(x, y, duration, delay = 0, ease = "")
	{
		with oGlobal.MainCamera TweenFire(self, ease, 0, 0, delay, duration, "x>", x, "y>", y);
	}
	/**
		Rotates the camera
		@param {real} start				The start angle of the camera
		@param {real} target			The target angle of the camera
		@param {real} duration			The time taken for the camera to rotate
		@param {function,string} Easing	The ease of the rotation
		@param {real} delay 			The delay of the animation
	*/
	static RotateTo = function(start = oGlobal.MainCamera.angle, target, duration, ease = "", delay = 0)
	{
		TweenFire(oGlobal.MainCamera, ease, 0, 0, delay, duration, "angle", start, target);
	}
	///Gets the x position of the main camera
	static ViewX = function()
	{
		return camera_get_view_x(view_camera[0]);
	}
	///Gets the y position of the main camera
	static ViewY = function()
	{
		return camera_get_view_y(view_camera[0]);
	}
	/**
		Sets the width and height of the view
		@param {real} width		The width of the camera
		@param {real} height	The height of the camera
	*/
	static SetAspect = function(width, height)
	{
		with oGlobal.MainCamera
		{
			view_width = width;
			view_height = height;
		}
	}
	///Gets the scale of the camera
	///@param {real} value		0/none -> both (In array) 1/"x" -> x 2/"y" -> y
	static GetScale = function(val = 0)
	{
		switch val
		{
			case 0: return oGlobal.MainCamera.Scale; break;
			case 1: case "x": return oGlobal.MainCamera.Scale[0]; break;
			case 2: case "y": return oGlobal.MainCamera.Scale[1]; break;
		}
	}
	///Gets the aspect of the view
	///@param {real} value		0/none/"width"/"w" -> width 1/"height"/"h" -> height 2/"ratio"/"r" -> ratio
	static GetAspect = function(val = 0)
	{
		switch val
		{
			case 0: case "width":  case "w": return oGlobal.MainCamera.view_width; break;
			case 1: case "height":  case "h": return oGlobal.MainCamera.view_height; break;
			case 2: case "ratio":  case "r":
				return oGlobal.MainCamera.view_width / oGlobal.MainCamera.view_height; break;
		}
	}///Gets the position of the camera
	///@param {real} value		0/"x" -> x 1/"y" -> y
	static GetPos = function(val = 0)
	{
		switch val
		{
			case 0: case "x": return oGlobal.MainCamera.x; break;
			case 1: case "y": return oGlobal.MainCamera.y; break;
		}
	}
	///Gets the angle of the camera
	static GetAngle = function()
	{
		return oGlobal.MainCamera.angle;
	}
}