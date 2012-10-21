package com
{
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
		
		public function ViewportTest()
		{
			_updatables = new Vector.<IUpdatable>();
			 
			_world = new World(1600, 1200);
			var map:Rectangle = new Rectangle(0, 0, _world.worldWidth, _world.worldHeight);
			_camera = new Camera(640, 480, map);
			_camera.setSpeed(500).setUpdatableElements(_updatables);
			
			_updatables.push(_world);
			_initUpdatables();
			
			addEventListener(Event.ENTER_FRAME, update);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyManager.me.onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyManager.me.onKeyUp);	
			
			_deltaTime = getTimer();
		}
		
		protected function update(event:Event):void
		{
			var delta:Number = getDeltaTime();
			
			if (KeyManager.me.isKeyPressed) {
				if (KeyManager.me.keysPressed.length == 1) {
					switch (KeyManager.me.keysPressed[0]) {
						case Keys.DOWN:
							_camera.move(delta, CameraDirections.DOWN);
							break;
						case Keys.UP:
							_camera.move(delta, CameraDirections.UP);
							break;
						case Keys.LEFT:
							_camera.move(delta, CameraDirections.LEFT);
							break;
						case Keys.RIGHT:
							_camera.move(delta, CameraDirections.RIGHT);
							break;
					}
				} else {
					var direction:int = CameraDirections.getDirectionByKeys(KeyManager.me.keysPressed);
					_camera.move(delta, direction);
				}			
			}
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