package app.modules.panel.personal.service
{
	import app.GameConfig;
	import app.core.Tips;
	import app.modules.login.register.vo.RegisterVo;
	import app.modules.panel.personal.events.PersonalEvent;
	import app.modules.panel.personal.model.PersonalModel;
	
	import ff.account_req_t;
	import ff.client_cmd_e;
	import ff.get_wrong_history_req_t;
	import ff.get_wrong_history_ret_t;
	import ff.modify_user_info_req_t;
	import ff.modify_user_info_ret_t;
	import ff.server_cmd_e;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	import victor.core.MD5;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-12
	 */
	public class PersonalService extends BaseService
	{
		[Inject]
		public var personalModel:PersonalModel;
		
		public function PersonalService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			regist( server_cmd_e.GET_WRONG_HISTORY_RET, getSuccessedNotify, get_wrong_history_ret_t );
			regist( server_cmd_e.MODIFY_USER_INFO_RET, modifyNotify, modify_user_info_ret_t );
		}
		
		private function getSuccessedNotify( resp:SocketResp ):void
		{
			var data:get_wrong_history_ret_t = resp.data as get_wrong_history_ret_t;
			
			personalModel.englshList = data.wrong_words;
			personalModel.chineseList = data.chinese;
			
			dispatch( new PersonalEvent( PersonalEvent.ERROR_LIST_SUCCESSED ));
		}
		
		private function modifyNotify( resp:SocketResp ):void
		{
			var data:modify_user_info_ret_t = resp.data as modify_user_info_ret_t;
			if ( data.flag ) {
				Tips.showCenter( "信息修改成功" );
				
				dispatch( new PersonalEvent( PersonalEvent.CHANGE_INFO_SUCCESS ));
			}
		}
		
		/**
		 * 获取错误单词列表
		 */
		public function getErrorList():void
		{
			var req:get_wrong_history_req_t = new get_wrong_history_req_t();
			call( client_cmd_e.GET_WRONG_HISTORY_REQ, req );
		}
		
		/**
		 * 更改个人信息
		 */
		public function changeInfo( registerVo:RegisterVo ):void
		{
			var req:modify_user_info_req_t = new modify_user_info_req_t();
			var user_info:account_req_t = new account_req_t();
			user_info.address = registerVo.address;
			user_info.email = registerVo.email;
			user_info.gender = registerVo.gender;
			user_info.grade = registerVo.grade;
			user_info.new_password = registerVo.passwordConfirm;
			if ( GameConfig.IS_MD5 ){
				user_info.new_password = MD5.calculate( registerVo.passwordConfirm );
			}
			user_info.nick_name = registerVo.name;
			user_info.password = registerVo.password;
			user_info.phone = registerVo.phone;
			user_info.qq = registerVo.QQ;
			user_info.real_name = registerVo.realName;
			user_info.school = registerVo.school;
			user_info.register_flag = false;
			req.user_info = user_info;
			call( client_cmd_e.MODIFY_USER_INFO_REQ, req );
		}
		
	}
}