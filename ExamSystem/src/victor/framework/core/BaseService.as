package victor.framework.core {

	
	import net.victoryang.events.ViewEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	import victor.framework.socket.IService;
	import victor.framework.socket.ISocketManager;
	import victor.framework.socket.SocketReq;

    /**
     * @author fireyang
     */
    public class BaseService extends Actor implements IService {
        [Inject]
        public var socket : ISocketManager;

        /**
         * 初始化构造
         */
        [PostConstruct]
        public function __construct() : void {
            initRegist();
        }

        /**
         * 注册回调函数 
         */
        protected function initRegist() : void {
        }

        /**
         * 请求数据
         * @param model 数据模型
         * 
         */
		protected function call(cmd : uint, msg : *, callBack : Function = null, noTimeAllow : Boolean = true) : void {
            var req : SocketReq =SocketReq.creatReq();
            req.cmd = cmd;
            req.obj = msg;
            socket.call(req, callBack, noTimeAllow);
        }

        /**
         * 单次请求
         */
		protected function onceCall(cmd : uint, msg : *, callBack : Function, respCla : Class) : void {
            var req : SocketReq = SocketReq.creatReq();
			req.cmd = cmd;
            req.obj = msg;
            socket.onceCall(req, callBack, respCla);
        }

        /**
         * 服务端数据推送注册
         * @param model 接口模块
         * @param action 接口动作
         * @param dataCallBack 接口数据回调
         */
		protected function regist(cmd : uint, dataCallBack : Function, respProc : Class) : void {
			socket.registerDataCallback( cmd, dataCallBack, respProc);
        }
		
		protected function openView( viewName:String, data:Object = null ):void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW, viewName, data ));
		}
		
		protected function closeView( viewName:String ):void
		{
			dispatch( new ViewEvent( ViewEvent.HIDE, viewName ));
		}
    }
}
