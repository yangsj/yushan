package victor.framework.socket {

    /**
     * @author fireyang
     */
    public class SocketReq {
        // 发送对象
        public var obj : *;
        private var _cmd : uint;
        private static var _pool : Array = [];

        /**
         * Construct a <code>SocketReq</code>.
         */
        public function SocketReq() {
        }

        private function reset() : void {
            obj = null;
            _cmd = 0;
        }

        public function get cmd() : uint {
            return _cmd;
        }

        public function set cmd(cmd : uint) : void {
            _cmd = cmd;
        }

        public static function creatReq() : SocketReq {
            var req : SocketReq;
            if (_pool.length > 0) {
                req = _pool.pop();
            } else {
                req = new SocketReq();
            }
            return req;
        }

        public static function disposeReq(req : SocketReq) : void {
            req.reset();
            _pool.push(req);
        }
    }
}
