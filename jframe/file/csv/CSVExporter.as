package jframe.file.csv
{
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class CSVExporter
	{
		private var _csv:String;
		private var _byteExporter:ByteArray;
		private var _fileReference:FileReference;
		
		public function CSVExporter(baseClass:ICSVObject)
		{
			_csv = baseClass.header() + "\n";
			_fileReference = new FileReference();
			_fileReference.addEventListener(Event.SELECT, _onRefSelect);
			_fileReference.addEventListener(Event.CANCEL, _onRefCancel);
		}
		
		/**
		 * Salva o arquivo em disco
		 */
		public function saveCSV():void
		{
			_byteExporter = new ByteArray();
			_byteExporter.writeUTFBytes(_csv);
			
			_fileReference.save(_byteExporter, "log.csv");
		}
		
		public function appendObject(object:ICSVObject):void
		{
			trace( "appendObject : " + appendObject );
			var _tempString:String = "";
			//for each (var item:Number in object)
			//{
				//trace( "item : " + item );
				//_tempString += item + ",";
			//}
			_tempString = object.toString();
			
			
			_tempString = _tempString.substr(0, _tempString.length - 1);
			
			trace( "_tempString : " + _tempString );
			
			_csv += _tempString += "\n";
		}
		
		private function _onRefCancel(e:Event):void
		{
		
		}
		
		private function _onRefSelect(e:Event):void
		{
		
		}
	
	}

}