package com
{
	import flash.geom.Point;

	/**
	 * Interface for updatable elements (elements that must be shown by a camera) 
	 * @author kakebuke
	 */
	public interface IUpdatable
	{
		function move(mov:Point):void ;
	}
}