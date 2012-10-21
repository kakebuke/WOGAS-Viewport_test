package com
{
	import flash.geom.Point;

	public interface IUpdatable
	{
		function move(mov:Point):void ;
		function canMove(mov:Point):Boolean;
	}
}