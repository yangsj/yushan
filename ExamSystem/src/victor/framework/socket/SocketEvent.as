package victor.framework.socket {
    import flash.events.Event;

    /**
     * @author fireyang
     */
    public class SocketEvent extends Event {
        public static const CONNECTED : String = "socket_connected";
        public static const CLOSE : String = "socket_close";
        public static const CALL_ERROR : String = "CALL_ERROR";
        public static const ERROR_SECURITY : String = "ERROR_SECURITY";
        public static const RECONNECT : String = "RECONNECT";
		public static const IO_ERROR:String = "io_error";
		public static const CALL_START:String = "call_start";//開始請求
		public static const CALL_END:String = "call_end";//請求結束

        /**
         * Construct a <code>SocketEvent</code>.
         */
        public function SocketEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
            super(type, bubbles, cancelable);
        }
    }
}
