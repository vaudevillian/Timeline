package experiments 
{
	import starling.display.graphics.Fill;
	import starling.display.graphics.Stroke;
	import starling.display.materials.StandardMaterial;
	import starling.display.shaders.fragment.TextureFragmentShader;
	import starling.display.shaders.fragment.TextureVertexColorFragmentShader;
	import starling.display.shaders.vertex.AnimateUVVertexShader;
	import starling.display.shaders.vertex.StandardVertexShader;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Dominik Forstmaier
	 */
	public class Timeline extends Sprite 
	{
		[Embed( source = "/assets/Rock.png" )]
		private var RockBMP		:Class;
		[Embed( source = "../assets/Grass.png" )]
		private var GrassBMP		:Class;
		
		private var fill			:Fill;
		private var rockTexture	:Texture;
		private var grassTexture:Texture;
		
		
		// Display objects
		private var shape			:Shape;
		
		//private var shapeA:Shape;
		private var shapeB:Shape;
		private var shapeC:Shape;
		private var columnWidth:int = 100;
		
		public function Timeline() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);		
		}
		
		private function onAdded ( e:Event ):void
		{
			grassTexture = Texture.fromBitmap( new GrassBMP(), false );
			rockTexture = Texture.fromBitmap( new RockBMP(), false );
			
			drawPlayer( 82 + 2 + 16, 49 + 44 + 7, 33 + 60 + 7, 0xdf8df8 );
			drawPlayer( 82 + 2, 49 + 44, 33 + 60, 0xffff08 );
			drawPlayer( 82, 49, 33 );
		}
		
		private function drawPlayer( firstDay:int, secondDay:int, thirdDay:int, color:uint = 0 ) : void
		{
			firstDay = 100 - firstDay;
			secondDay = 100 - secondDay;
			thirdDay = 100 - thirdDay;
			
			var shapeA:Shape = new Shape();
			addChild( shapeA );
			shapeA.x = 20;
			shapeA.y = 20;
			shapeA.graphics.clear();
			
			
			if ( color == 0 )
			{
				var lavaMaterial:StandardMaterial = new StandardMaterial(  );
				lavaMaterial.vertexShader = new AnimateUVVertexShader( 0.03, 0 );
				lavaMaterial.fragmentShader = new TextureFragmentShader();
				lavaMaterial.textures[0] = rockTexture;
				shapeA.graphics.beginMaterialFill( lavaMaterial );				
			}
			else
			{
				shapeA.graphics.beginFill(color);				
			}
			
			shapeA.graphics.lineTo( 0, 100 );
			shapeA.graphics.lineTo( columnWidth * 3, 100 );
			shapeA.graphics.lineTo( columnWidth * 3, thirdDay );
			shapeA.graphics.lineTo( columnWidth * 2, secondDay );
			shapeA.graphics.lineTo( columnWidth, firstDay );
			shapeA.graphics.lineTo( 0, 0 );
			shapeA.graphics.endFill();
		}
		
		private function paintTimeline() : void
		{
			
			shape = new Shape();
			addChild(shape);
			shape.x = 20;
			shape.y = 20;
			shape.graphics.clear();
						
			// Rect drawn with textured fill and stroke
			shape.graphics.beginTextureFill(rockTexture);
			shape.graphics.lineTexture(20, grassTexture);
			shape.graphics.lineTo( 0, 250 );
			shape.graphics.lineTo( 100, 210 );
			shape.graphics.lineTo( 100, 0 );
			shape.graphics.lineTo( 0, 0 );
			shape.graphics.endFill();
		}
		
		private function paintTimelineVertex() : void
		{
			var landFill:Fill = new Fill();
			landFill.material.fragmentShader = new TextureVertexColorFragmentShader();
			landFill.material.textures[0] = rockTexture;
			var landStroke:Stroke = new Stroke();
			landStroke.material.fragmentShader = new TextureVertexColorFragmentShader();
			landStroke.material.textures[0] = grassTexture;
			
			var w:Number = stage.stageWidth;
			var h:Number = stage.stageHeight;
			
			landFill.addVertex( 0, 100 );
			landFill.addVertex( 10, 120 );
			landFill.addVertex( 20, 80 );
			
			//
			//landFill.addVertex( 100, 100 );
			//landFill.addVertex( 110, 120 );
			//landFill.addVertex( 120, 80 );
			
			//var landHeight:Number = 200;
			//var landDetail:int = 30;
			//for ( var i:int = 0; i < landDetail; i++ )
			//{
				//var ratio:Number = i / (landDetail-1);
				//var x:Number = ratio * w;
				//var termA:Number = Math.cos( ratio * Math.PI * 2.34 );
				//var termB:Number = Math.sin( ratio * Math.PI * 1.12 );
				//var y:Number = h - ((termA+termB)+1) * 0.4 * landHeight;
				//y += Math.random() * 40;
				//landFill.addVertex( x, y );
				//
				//var thickness:Number = (30 + Math.random() * 30)// * (y > (waterHeight-40) ? 0 : 1);
				//landStroke.addVertex( x, y, thickness  );
			//}
			//landFill.addVertex(w, h+40);
			//landFill.addVertex(0, h+40);
			addChild(landFill);
			addChild(landStroke);
			
		}
		
		private function paintCosSin() : void
		{
			var landFill:Fill = new Fill();
			landFill.material.fragmentShader = new TextureVertexColorFragmentShader();
			landFill.material.textures[0] = rockTexture;
			var landStroke:Stroke = new Stroke();
			landStroke.material.fragmentShader = new TextureVertexColorFragmentShader();
			landStroke.material.textures[0] = grassTexture;
			
			var w:Number = stage.stageWidth;
			var h:Number = stage.stageHeight;
			
			var landHeight:Number = 200;
			var landDetail:int = 30;
			for ( var i:int = 0; i < landDetail; i++ )
			{
				var ratio:Number = i / (landDetail-1);
				var x:Number = ratio * w;
				var termA:Number = Math.cos( ratio * Math.PI * 2.34 );
				var termB:Number = Math.sin( ratio * Math.PI * 1.12 );
				var y:Number = h - ((termA+termB)+1) * 0.4 * landHeight;
				y += Math.random() * 40;
				landFill.addVertex( x, y );
				
				var thickness:Number = (30 + Math.random() * 30)// * (y > (waterHeight-40) ? 0 : 1);
				landStroke.addVertex( x, y, thickness  );
			}
			landFill.addVertex(w, h+40);
			landFill.addVertex(0, h+40);
			addChild(landFill);
			addChild(landStroke);
		}
	}

}