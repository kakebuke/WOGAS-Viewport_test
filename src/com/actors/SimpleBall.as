package com.actors
{
	import com.IUpdatable;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class SimpleBall extends Sprite implements IUpdatable
	{
		private var _speed : int;
		private var _radius : int;
		private var _color : Number;
		
		private var _movement:Point;
		
		public function SimpleBall()
		{
			super();
			_movement = new Point();
			
			addEventListener(Event.ADDED_TO_STAGE, draw);
		}
		
		public function updatePosition(delta:Number):void
		{
			var despl:Number = Math.max(delta * _speed, 1);
			
			if (_speed > 0) {
				if (_movement.x + despl < 200) {
					_movement.x += despl;
					x += despl;
				} else {
					_movement.x = 200;
					x = x + (_movement.x + despl - 200);
					_speed *= -1
				}
			} else {
				if (_movement.x + despl > 0) {
					_movement.x += despl;
					x += despl;
				} else {
					_movement.x = 0;
					x = x + (_movement.x + despl);
					_speed *= -1;
				}
			}
		}
		
		protected function draw(evt:Event = null):void
		{
			while (numChildren > 0) {
				removeChildAt(0);
			}
			
			graphics.beginFill(_color);
			graphics.drawCircle(0, 0, _radius);
			graphics.endFill();
		}
		
		public function move(mov:Point):void
		{
			x -= mov.x;
			y -= mov.y;
		}
		
		public function setSpeed(value:int):SimpleBall
		{
			_speed = value;
			return this;
		}
		
		public function setRadius(value:int):SimpleBall
		{
			_radius = value;
			return this;
		}
		
		public function setColor(value:Number):SimpleBall
		{
			_color = value;
			return this;
		}
		

		public function get color():Number
		{
			return _color;
		}

		public function set color(value:Number):void
		{
			_color = value;
			draw();		
		}
		
		public function get radius():int
		{
			return _radius;
		}
		
		public function set radius(value:int):void
		{
			_radius = value;
			draw();
		}
		
		public function get speed():int
		{
			return _speed;
		}
		
		public function set speed(value:int):void
		{
			_speed = value;
		}
	}
}