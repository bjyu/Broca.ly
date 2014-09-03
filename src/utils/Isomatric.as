package utils
{
	import flash.geom.Point;

	public class Isomatric
	{
		public function Isomatric()
		{
		}
		
		/**
		 * convert a 2D point to isometric
		 * @param pt2d: origin point for 2D array
		 * @param side: unit of a side(Tile width)
		 */
		public static function convert2dToIsometric(pt2d:Point, side:Number):Point
		{
			var ptIso:Point = new Point();
			ptIso.x = (pt2d.x - pt2d.y) * side 
				/* offset */ + 2 * side;
			ptIso.y = (pt2d.x + pt2d.y)/2 * side;
			return(ptIso);
		}
		
	}
}