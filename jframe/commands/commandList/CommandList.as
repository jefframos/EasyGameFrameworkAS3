package jframe.commands.commandList
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.System;
	import jframe.commands.event.CommandEvent;
	import jframe.commands.interfaces.IAsyncCommand;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class CommandList extends EventDispatcher
	{
		private var commands:Array = [];
		private var isBusy:Boolean = false;
		private var currentCommand:IAsyncCommand;
		private var labelCurrentCommand:String;
		private var breakExec:Boolean = false;
		private var inExecCommand:IAsyncCommand;
		private var maxCommands:int;
		
		public function CommandList(maxCommands:int = 10)
		{
			this.maxCommands = maxCommands;		
		}
		
		/**
		 * Adiciona um comando no array de comandos
		 * @param	command IAsyncCommand que será adicionado
		 */
		public function add(command:IAsyncCommand, label:String):void
		{
			/**
			 * Adiciona a callback "executeNext" no comando, para quando este chegar ao fim, executar esta função
			 */
			if (commands.length <= maxCommands)
			{
				command.addCompleteCallback(executeNext, label);
				commands.push(command);
				attempExecute();
			}
		}
		
		/**
		 * Retorna a quantidade de commandos na lista
		 * @return
		 */
		public function getLenght():int
		{
			return commands.length;
		}
		
		/**
		 * Interrompe a execução dos comandos
		 */
		public function killCommands():void
		{
			for each (var item:IAsyncCommand in commands)
			{
				item.kill();
			}
			if (currentCommand != null)
				currentCommand.kill();
			commands = new Array();
			isBusy = false;
		}
		
		/**
		 * Pausa o commando em execução
		 */
		public function pauseList():void
		{
			inExecCommand.pause();
		}
		
		/**
		 * Pausa o commando em execução
		 */
		public function continueList():void
		{
			inExecCommand.unPause();
		}
		
		/**
		 * Interrompe a execução dos commandos
		 */
		public function breakExecution():void
		{
			breakExec = true;
		}
		
		/**
		 * Continua execução dos commandos
		 */
		public function continueExecution():void
		{
			breakExec = false;
		}
		
		/**
		 * Se nenhum comando estiver em execução, executa o próximo comando
		 */
		private function attempExecute():void
		{
			if (!isBusy)
			{
				executeNext();
			}
		}
		
		/**
		 * Executa o próximo comando
		 */
		private function executeNext():void
		{
			if (!breakExec)
			{
				if (isBusy)
					this.dispatchEvent(new CommandEvent(CommandEvent.FINISH_COMMAND, {label: labelCurrentCommand}));
				
				isBusy = false;
				//se houver algum comando no array
				if (commands.length > 0)
				{
					isBusy = true;
					//remove o primeiro comando do array e executa
					currentCommand = commands.shift() as IAsyncCommand;
					currentCommand.execute();
					labelCurrentCommand = currentCommand.label;
					inExecCommand = currentCommand;
					currentCommand = null;
					System.gc();
				}
				else
				{
					this.dispatchEvent(new CommandEvent(CommandEvent.FINISH_QUEUE));
				}
			}
		}
	
	}

}