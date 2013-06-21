package jframe.samples.factorySample
{
	import factory.factorySample.BoxUp;
	import factory.factorySample.ButtonLabel;
	import factory.factorySample.ButtonOver;
	import factory.factorySample.ButtonUp;
	import factory.factorySample.Label;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import jframe.factory.AbstractFactory;
	import jframe.factory.box.BoxFactory;
	import jframe.factory.button.ButtonFactory;
	import jframe.factory.input.InputFactory;
	import jframe.factory.label.LabelFactory;
	import jframe.factory.window.WindowFactory;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class FactorySample extends AbstractFactory
	{
		private var upState:Sprite;
		private var overState:Sprite;
		
		public function FactorySample()
		{
			this.buttonFactory = new ButtonFactory();
			this.buttonFactory.buttonUpState = ButtonUp;
			this.buttonFactory.buttonOverState = ButtonOver;
			this.buttonFactory.buttonTextField = (new ButtonLabel)["_label"];
			this.buttonFactory.sizeType = ButtonFactory.TEXT_AUTO_SIZE;
			this.buttonFactory.margin = new Point(30, 10);
			this.buttonFactory.colorOver = 0xFFFFFF;
			this.buttonFactory.colorUp = 0xFFFFFF;
			
			this.boxFactory = new BoxFactory();
			this.boxFactory.upState = BoxUp;
			
			this.labelFactory = new LabelFactory();
			this.labelFactory.textField = (new Label)["_label"];
			this.labelFactory.textField.autoSize = TextFieldAutoSize.LEFT;
			this.labelFactory.textAlign = TextFormatAlign.CENTER;
			//this.labelFactory.textFilters.push(new DropShadowFilter())
			
			this.inputFactory = new InputFactory();
			this.inputFactory.textField = (new Label)["_label"];
			this.inputFactory.textField.autoSize = TextFieldAutoSize.LEFT;
			
			this.windowFactory = new WindowFactory()
			this.windowFactory.upState = BoxUp;
			this.windowFactory.backColor = 0;
			this.windowFactory.backAlpha = .8;
		
		}
	
	}

}