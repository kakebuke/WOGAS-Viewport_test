package com.keyboard
{
	import flash.events.KeyboardEvent;
	
	import mx.core.Singleton;

	public class KeyManager
	{
		private static var _instance:KeyManager;
		
		private var _keys:Vector.<uint>;
		
		public function KeyManager(sg:Singleton)
		{
			_keys = new Vector.<uint>();
		}
		
		public static function get me():KeyManager
		{
			if (!_instance) {
				_instance = new KeyManager(new Singleton());
			}
			return _instance;
		}
		
		public function onKeyDown(evt:KeyboardEvent):void
		{
			if (_keys.indexOf(evt.keyCode) == -1) {
				_keys.push(evt.keyCode);
			}
		}
		
		public function onKeyUp(evt:KeyboardEvent):void
		{
			var pos:int = _keys.indexOf(evt.keyCode);
			
			if (pos != -1) {
				_keys.splice(pos, 1);
			}
		}
		
		/**
		 * Checks if a key is currently pressed and returns true if so 
		 * @param key KeyCode to chech if is currently pressed
		 * @param only check if it's the only pressed key
		 * @return <em>true</em> if pressed<br> <em>false</em> if not pressed
		 */
		public function isPressed(key:uint, only:Boolean = true):Boolean
		{
			var isTrue:Boolean;
			
			if (only) {
				isTrue = _keys.length == 1 && (_keys.indexOf(key) != -1);
			} else {
				isTrue = _keys.indexOf(key) != -1;
			}
			
			trace("Is pressed: " + isTrue.toString());
			return isTrue;
		}
		
		/**
		 * Gets the currently pressed key 
		 * @return keyCode of the currently pressed key
		 */
		public function get keysPressed():Vector.<uint>
		{
			var keys:Vector.<uint> = new Vector.<uint>();			
			
			if (_keys.length) {
				keys = _keys;
			}
			
			return keys;
		}
		
		public function get isKeyPressed():Boolean
		{
			return _keys.length > 0;
		}
		
		
	}
}
internal class Singleton{}