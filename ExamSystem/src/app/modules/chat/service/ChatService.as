package app.modules.chat.service
{
	import flash.utils.Dictionary;
	
	import app.modules.LoadingEffect;
	import app.modules.chat.model.ChatModel;
	import app.modules.chat.model.ChatVo;
	
	import ff.chat_msg_req_t;
	import ff.chat_msg_ret_t;
	import ff.client_cmd_e;
	import ff.server_cmd_e;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class ChatService extends BaseService
	{
		[Inject]
		public var chatModel:ChatModel;
		
		public function ChatService()
		{
		}
		
		override protected function initRegist():void
		{
			regist( server_cmd_e.CHAT_RET, chatNotify, chat_msg_ret_t );
		}
		
		private function chatNotify(  res:SocketResp ):void
		{
			var data:chat_msg_ret_t = res.data as chat_msg_ret_t;
			var chatVo:ChatVo = new ChatVo();
			chatVo.msg = data.msg;
			chatVo.channel = data.channel;
			chatVo.emoticons = decode( data.emotions );
			chatVo.playerUid = data.from_player_uid;
			chatVo.playerName = data.from_player_name;
			chatModel.addMsg( chatVo );
		}
		
		public function sendRequestMsg(chatVo:ChatVo):void
		{
			var req:chat_msg_req_t = new chat_msg_req_t();
			req.msg = chatVo.msg;
			req.channel = chatVo.channel;
			req.emotions = encode( chatVo.emoticons );
			req.player_uid = chatVo.playerUid;
			req.player_name = chatVo.playerName;
			call( client_cmd_e.CHAT_REQ, req );
			
			LoadingEffect.hide();
			
			// 发送到自己聊天窗口
//			chatVo.emoticons = decode( req.emotions );
//			chatModel.addMsg( chatVo );
//			
//			// 关闭loading
//			LoadingEffect.hide();
		}
		
		/**
		 * 编码
		 * @param emoticons
		 * @return 
		 */
		private function encode( emoticons:Array ):Dictionary
		{
			var dict:Dictionary = new Dictionary();
			if ( emoticons )
			{
				var num:int = 100;
				for each ( var obj:Object in emoticons )
				{
					var index:int = obj.index;
					var src:String = num + "" + String(obj.src);
					dict[src] = index;
					num++;
				}
			}
			return dict;
		}
		
		/**
		 * 解码
		 * @param emoticons
		 * @return 
		 */
		private function decode( emoticons:Dictionary ):Array
		{
			var array:Array = [];
			if ( emoticons )
			{
				for ( var key:* in emoticons )
					array.push({index:int(emoticons[key]), src:"ui.chat.emotion_" + String( key ).substr(3) });
			}
			return array;
		}
		
	}
}