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
		
		public function Camera(width:int, height:int, stage:Rectangle, position:Point = null)
		{
			_stage = stage;
			if (position == null) {
				position = new Point();
			}
			super(position.x, position.y, width, height);			
		}
		
		public function setSpeed(speed:Number):Camera
		{
			_speed = speed;			
			return this;
		}
		
		public function setUpdatableElements(updatables:Vector.<IUpdatable>):Camera
		{
			_updatables = updatables;
			return this;
		}
		
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
			
			/*var movement:Point = new Point();
			if (canMoveX(newPos)) {
				this.x += newPos.x;
				movement.x = newPos.x;
			}
			
			if (canMoveY(newPos)) {
				this.y += newPos.y;
				movement.y = newPos.y;
			}
			
			moveUpdatables(movement);*/
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