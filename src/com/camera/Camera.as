package com.camera
{
	import com.IUpdatable;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Camera extends Rectangle
	{
		private var _stage:Rectangle;
		private var _updatables:Vector.<IUpdatable>;
		
		/** Speed of camera movement in pixels / second (default: 10) */
		private var _speed:Number = 10;
		
		private var _initialized:Boolean = false;
		
		/**
		 * Creates a camera with a viewport of the width and height specified by the so spelled
		 * parameters that looks at a world with the limits specified by the stage rectangle. If a 
		 * position is passed the camera will be looking at this position straight away. Camera is
		 * nothing but a Rectangle that keeps track of the position where the inner objects have to 
		 * be placed to be properly shown.
		 * @param width int viewport's width
		 * @param height int viewport's height
		 * @param stage Rectangle delimitating the world where the camera is looking to
		 * @param position Point initial position of the camera
		 */
		public function Camera(_width:int, _height:int, stage:Rectangle, position:Point = null)
		{
			_stage = stage;
			
			if (position == null) {
				position = new Point();
			} else {
				// Validate the position and make sure it's within the limits
				if (position.x < 0) {
					position.x = 0;
				} else if (position.x + _width > stage.width) {
					position.x = stage.width - _width;
				}
				if (position.y < 0) {
					position.y = 0;
				} else if (position.x + _width > stage.width) {
					position.y = stage.height - _height;
				}
			}
			
			super(position.x, position.y, _width, _height);			
		}
		
		/**
		 * Initializes the camera and makes it look at the initial desired
		 * position (moves the objects accordingly) 
		 */
		public function initialize():void
		{
			_initialized = true;
			moveUpdatables(new Point(this.x, this.y));
		}
		
		/**
		 * Sets the default movement speed for the camera  
		 * @param speed in pixels / second
		 * @return Camera instance for chained calls
		 */
		public function setSpeed(speed:Number):Camera
		{
			_speed = speed;			
			return this;
		}
		
		/**
		 * Sets the updatable elements vector that will be traversed every time
		 * the camera moves to update the positions of the objects 
		 * @param updatables Vector of IUpdatable elements
		 * @return Camera instance for chained calls
		 * @see IUpdatable
		 */
		public function setUpdatableElements(updatables:Vector.<IUpdatable>):Camera
		{
			_updatables = updatables;
			return this;
		}
		
		/**
		 * Moves the camera towards one direction checking that the movement is 
		 * within the limits
		 * @param delta seconds elapsed since last update
		 * @param direction of the movement. 
		 * @see CameraDirections
		 * 
		 */
		public function move(delta:Number, direction:int):void
		{
			var despl:Number = Math.max(delta * _speed, 1);
			var newPos:Point = new Point();
			
			switch (direction) {
				case CameraDirections.DOWN:
					newPos.y += despl;
					break;
				case CameraDirections.UP:
					newPos.y -= despl;
					break;
				case CameraDirections.LEFT:
					newPos.x -= despl;
					break;
				case CameraDirections.RIGHT:
					newPos.x += despl;
					break;
				case CameraDirections.DOWN_RIGHT:
					newPos.x += despl;
					newPos.y += despl;
					break;
				case CameraDirections.UP_RIGHT:
					newPos.x += despl;
					newPos.y -= despl;
					break;
				case CameraDirections.DOWN_LEFT:
					newPos.x -= despl;
					newPos.y += despl;
					break;
				case CameraDirections.UP_LEFT:
					newPos.x -= despl;
					newPos.y -= despl;
					break;
			}
			
			doMove(newPos);
			trace("Camera moved to position: " + this.x + ", " + this.y);
		}
		
		private function doMove(mov:Point):void
		{
			mov.x = int(mov.x);
			mov.y = int(mov.y);
			
			if (x + mov.x < 0) {
				mov.x = mov.x - (x + mov.x);
				x = 0;
			} else if (x + width + mov.x > _stage.width) {
				mov.x = mov.x - (x + width + mov.x - _stage.width); 
				x = _stage.width - width;
			} else {
				x += mov.x;
			}
			
			if (y + mov.y < 0) {
				mov.y = mov.y - (y + mov.y);
				y = 0;
			} else if (y + height + mov.y > _stage.height) {
				mov.y = mov.y - (y + height + mov.y - _stage.height); 
				y = _stage.height - height;
			} else {
				y += mov.y;
			}
			trace("Camera moved: x:" + mov.x + ", y: " + mov.y);
			moveUpdatables(mov);
		}
		
		private function moveUpdatables(newPos:Point):void
		{
			for each (var updatable:IUpdatable in _updatables) {
				updatable.move(newPos);
				trace("Updatable moved to: " + DisplayObject(updatable).x + ", " + DisplayObject(updatable).y);
			}
		}
		
		public function canMoveX(mov:Point):Boolean
		{
			var canMove:Boolean = true;
			
			if (this.x + mov.x < 0 ) {
				canMove = false;
				trace("Left limit reached");
			}
			
			if (this.x + this.width + mov.x > _stage.width) {
				canMove = false;
				trace("Right limit reached");
			}
			
			return canMove;
		}
		
		public function canMoveY(mov:Point):Boolean
		{
			var canMove:Boolean = true;
			
			if (this.y + mov.y < 0) {
				canMove = false;
				trace("Top limit reached");
			}
			
			if (this.y + this.height + mov.y > _stage.height) {
				canMove = false;
				trace("Down limit reached");
			}
			
			return canMove;
		}
	}
}