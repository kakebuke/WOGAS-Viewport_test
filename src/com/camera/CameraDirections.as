package com.camera
{
	import com.keyboard.Keys;

	public class CameraDirections
	{
		public static const NONE						:int = -1;
		
		public static const UP							:int = 1;
		public static const UP_RIGHT					:int = 10; // UP + RIGHT
		public static const RIGHT						:int = 9;
		public static const DOWN_RIGHT					:int = 14; // DOWN + RIGHT
		public static const DOWN						:int = 5;
		public static const DOWN_LEFT					:int = 12; // DOWN + LEFT
		public static const LEFT						:int = 7;
		public static const UP_LEFT						:int = 8; // UP + LEFT
		
		public function CameraDirections()
		{
		}
		
		public static function getDirectionByKeys(keysPressed:Vector.<uint>):int
		{
			var key1:uint = keysPressed[keysPressed.length - 1];
			var key2:uint = keysPressed[keysPressed.length - 2];
			
			return _getDirectionValue(key1) + _getDirectionValue(key2);
		}
		
		private static function _getDirectionValue(key:uint):int
		{
			var val:int = 0;
			
			switch (key) {
				case Keys.UP:
					val = UP;
					break;
				case Keys.DOWN:
					val = DOWN;
					break;
				case Keys.RIGHT:
					val = RIGHT;
					break;
				case Keys.LEFT:
					val = LEFT;
					break;
			}
			
			return val;
		}
	}
}