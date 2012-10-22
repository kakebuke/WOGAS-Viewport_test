package com
{
	import com.actors.SimpleBall;
	import com.camera.Camera;
	import com.camera.CameraDirections;
	import com.keyboard.KeyManager;
	import com.keyboard.Keys;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	[SWF(width="640", height="480", frameRate="60", backgroundColor="#FFFFFF")]
	public class ViewportTest extends Sprite
	{
		private var _deltaTime:Number;
		private var _updatables:Vector.<IUpdatable>;
		private var _camera:Camera;
		private var _world:World;
		private var _ball:SimpleBall;
		
		public function ViewportTest()
		{
			_updatables = new Vector.<IUpdatable>();
			 
			_world = new World(1600, 1200);
			var map:Rectangle = new Rectangle(0, 0, _world.worldWidth, _world.worldHeight);
			
			_camera = new Camera(640, 480, map);
			_camera.setSpeed(500).setUpdatableElements(_updatables);
			
			// adding a moving ball
			_ball = new SimpleBall()
				.setColor(0xFF0000)
				.setRadius(10)
				.setSpeed(50);
			_ball.x = 30;
			_ball.y = 30;
			
			addChild(_ball);
			
			_updatables.push(_world, _ball);
			_initUpdatables();
			
			addEventListener(Event.ENTER_FRAME, update);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyManager.me.onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyManager.me.onKeyUp);	
			
			_deltaTime = getTimer();
			_camera.initialize();
		}
		
		protected function update(event:Event):void
		{
			var delta:Number = getDeltaTime();
			
			if (KeyManager.me.isKeyPressed) {
				var direction:int = CameraDirections.getDirectionByKeys(KeyManager.me.keysPressed);
				_camera.move(delta, direction);
			}
			
			_ball.updatePosition(delta);
			
		}
		
		/**
		 * Returns the number of seconds elapsed from the last ENTER_FRAME event 
		 * @return <b>(Number)</b> seconds elapsed 
		 */
		public function getDeltaTime():Number
		{
			var oldDelta:Number = _deltaTime;
			_deltaTime = getTimer();
			
			return (_deltaTime - oldDelta) / 1000;
		}
		
		private function _initUpdatables():void
		{
			for each (var updatable:DisplayObject in _updatables) {
				addChild(updatable);
			}
		}
	}
}