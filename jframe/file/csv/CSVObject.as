package jframe.file.csv 
{
	/**
	 * ...
	 * @author Jeff
	 */
	public class CSVObject extends Object
	{
		
		public function CSVObject() 
		{
			
		}
		public function toString():String
		{
			throw("Essa função precisa ser sobrescrita, deve retornar uma string com o necessário");
		}
		public function header():String
		{
			throw("Essa função precisa ser sobrescrita, deve retornar uma string com o cabeçalho");
		}
		
	}

}