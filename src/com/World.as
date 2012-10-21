package com
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class World extends Sprite implements IUpdatable
	{
		private var _worldWidth:int;
		private var _worldHeight:int;
		
		public function World(_width:int, _height:int)
		{
			_worldWidth = _width;
			_worldHeight = _height;
			
			_loadBg();
		}
		
		private function _loadBg():void
		{
			var request:URLRequest = new URLRequest("bg.jpeg");
			var loader:Loader = new Loader();
			Loader(loader).load(request);
			Loader(loader).contentLoaderInfo.addEventListener(Event.COMPLETE, onBgLoaded);
			Loader(loader).contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);			
		}
		
		public function move(mov:Point):void
		{
			x -= mov.x;
			y -= mov.y;
		}
		
		public function canMove(mov:Point):Boolean
		{
			return true;
		}		
		
		protected function onLoadError(event:IOErrorEvent):void
		{
			trace("AN ERROR HAS OCCURRED: " + IOErrorEvent(event.currentTarget).toString());			
		}
		
		protected function onBgLoaded(event:Event):void
		{
			var bmp:Bitmap = LoaderInfo(event.currentTarget).content as Bitmap;
			addChild(bmp);
			_worldWidth = this.width;
			_worldHeight = this.height;
		}
		
		public function get worldHeight():int
		{
			return _worldHeight;
		}
		
		public function get worldWidth():int
		{
			return _worldWidth;
		}
	}
}