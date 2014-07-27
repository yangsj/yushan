package app.modules.login.service
{
	import app.GameConfig;
	import app.data.GameData;
	import app.data.PlayerSelfVo;
	import app.events.GameEvent;
	import app.modules.LoadingEffect;
	import app.modules.login.login.vo.LoginVo;
	import app.modules.login.register.vo.RegisterVo;
	
	import ff.account_req_t;
	import ff.client_cmd_e;
	import ff.property_info_t;
	import ff.server_cmd_e;
	import ff.user_login_ret_t;
	
	import net.victoryang.deubg.Debug;
	
	import victor.core.MD5;
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;


	/**
	 * ……
	 * @author 	victor
	 * 			2013-9-7
	 */
	public class LoginService extends BaseService
	{
		[Inject]
		public var gameDb:GameData;
		
		public function LoginService()
		{
			super();
		}

		override protected function initRegist():void
		{
			// 登陆或注册成功通知
			regist( server_cmd_e.LOGIN_RET, loginSuccessedNotify, user_login_ret_t );
		}

		private function loginSuccessedNotify( res:SocketResp ):void
		{
			var data:user_login_ret_t = res.data as user_login_ret_t;

			////////////////////////////////////////
			/////////// set player data ////////////
			////////////////////////////////////////

			var selfVo:PlayerSelfVo = GameData.instance.selfVo ||= new PlayerSelfVo();
			selfVo.uid = data.uid;
			setPlayerInfo( data.property_info );
			
			////////////////////////////////////////
			/////////// set player data ////////////
			////////////////////////////////////////

			loginSuccessed();
		}

		public function login( loginVo:LoginVo ):void
		{
			var req:account_req_t = new account_req_t();
			req.nick_name = loginVo.accountName;
			req.password = loginVo.password;
			if ( GameConfig.IS_MD5 ){
				req.password = MD5.calculate( loginVo.password );
			}
			req.register_flag = false;
			call( client_cmd_e.LOGIN_REQ, req );
			
			LoadingEffect.hide();
		}

		public function register( registerVo:RegisterVo ):void
		{
			var req:account_req_t = new account_req_t();
			req.real_name = registerVo.realName;
			req.nick_name = registerVo.name;
			req.password = registerVo.password;
			if ( GameConfig.IS_MD5 ){
				req.password = MD5.calculate( registerVo.password );
			}
			req.address = registerVo.address;
			req.email = registerVo.email;
			req.grade = registerVo.grade;
			req.phone = registerVo.phone;
			req.qq = registerVo.QQ;
			req.school = registerVo.school;
			req.gender = registerVo.gender;
			req.register_flag = true;
			call( client_cmd_e.LOGIN_REQ, req );
			
			LoadingEffect.hide();
		}

		private function loginSuccessed():void
		{
			dispatch( new GameEvent( GameEvent.LOGIN_SUCCESSED ));
		}

		private function setPlayerInfo( data:property_info_t ):void
		{
			if ( data )
			{
				var selfVo:PlayerSelfVo = GameData.instance.selfVo ||= new PlayerSelfVo();
				selfVo.exp = data.exp;
				selfVo.address = data.adress;
				selfVo.email = data.email;
				selfVo.grade = data.grade;
				selfVo.level = data.level;
				selfVo.name = data.nick_name;
				selfVo.money = data.coin;
				selfVo.phone = data.phone;
				selfVo.qq = data.qq;
				selfVo.realName = data.real_name;
				selfVo.rightWordsNum = data.right_words_num;
				selfVo.wrongWordsNum = data.wrong_words_num;
				selfVo.school = data.school;
				selfVo.gender = data.gender;
			}
			else
			{
				Debug.error("at setPlayerInfo function params value Invalid. at LoginService line 119");
			}
		}

	}
}
