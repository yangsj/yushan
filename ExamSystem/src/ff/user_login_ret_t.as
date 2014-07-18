/**
 * Autogenerated by Thrift Compiler (0.9.1)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */
package ff {

import org.apache.thrift.Set;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import org.apache.thrift.*;
import org.apache.thrift.meta_data.*;
import org.apache.thrift.protocol.*;


  public class user_login_ret_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("user_login_ret_t");
    private static const UID_FIELD_DESC:TField = new TField("uid", TType.I32, 1);
    private static const PROPERTY_INFO_FIELD_DESC:TField = new TField("property_info", TType.STRUCT, 2);
    private static const SERVER_TIME_FIELD_DESC:TField = new TField("server_time", TType.I32, 3);

    private var _uid:int;
    public static const UID:int = 1;
    private var _property_info:property_info_t;
    public static const PROPERTY_INFO:int = 2;
    private var _server_time:int;
    public static const SERVER_TIME:int = 3;

    private var __isset_uid:Boolean = false;
    private var __isset_server_time:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[UID] = new FieldMetaData("uid", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
      metaDataMap[PROPERTY_INFO] = new FieldMetaData("property_info", TFieldRequirementType.DEFAULT, 
          new StructMetaData(TType.STRUCT, property_info_t));
      metaDataMap[SERVER_TIME] = new FieldMetaData("server_time", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
    }
    {
      FieldMetaData.addStructMetaDataMap(user_login_ret_t, metaDataMap);
    }

    public function user_login_ret_t() {
      this._uid = 0;
      this._server_time = 0;
    }

    public function get uid():int {
      return this._uid;
    }

    public function set uid(uid:int):void {
      this._uid = uid;
      this.__isset_uid = true;
    }

    public function unsetUid():void {
      this.__isset_uid = false;
    }

    // Returns true if field uid is set (has been assigned a value) and false otherwise
    public function isSetUid():Boolean {
      return this.__isset_uid;
    }

    public function get property_info():property_info_t {
      return this._property_info;
    }

    public function set property_info(property_info:property_info_t):void {
      this._property_info = property_info;
    }

    public function unsetProperty_info():void {
      this.property_info = null;
    }

    // Returns true if field property_info is set (has been assigned a value) and false otherwise
    public function isSetProperty_info():Boolean {
      return this.property_info != null;
    }

    public function get server_time():int {
      return this._server_time;
    }

    public function set server_time(server_time:int):void {
      this._server_time = server_time;
      this.__isset_server_time = true;
    }

    public function unsetServer_time():void {
      this.__isset_server_time = false;
    }

    // Returns true if field server_time is set (has been assigned a value) and false otherwise
    public function isSetServer_time():Boolean {
      return this.__isset_server_time;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case UID:
        if (value == null) {
          unsetUid();
        } else {
          this.uid = value;
        }
        break;

      case PROPERTY_INFO:
        if (value == null) {
          unsetProperty_info();
        } else {
          this.property_info = value;
        }
        break;

      case SERVER_TIME:
        if (value == null) {
          unsetServer_time();
        } else {
          this.server_time = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case UID:
        return this.uid;
      case PROPERTY_INFO:
        return this.property_info;
      case SERVER_TIME:
        return this.server_time;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case UID:
        return isSetUid();
      case PROPERTY_INFO:
        return isSetProperty_info();
      case SERVER_TIME:
        return isSetServer_time();
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function read(iprot:TProtocol):void {
      var field:TField;
      iprot.readStructBegin();
      while (true)
      {
        field = iprot.readFieldBegin();
        if (field.type == TType.STOP) { 
          break;
        }
        switch (field.id)
        {
          case UID:
            if (field.type == TType.I32) {
              this.uid = iprot.readI32();
              this.__isset_uid = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case PROPERTY_INFO:
            if (field.type == TType.STRUCT) {
              this.property_info = new property_info_t();
              this.property_info.read(iprot);
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case SERVER_TIME:
            if (field.type == TType.I32) {
              this.server_time = iprot.readI32();
              this.__isset_server_time = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          default:
            TProtocolUtil.skip(iprot, field.type);
            break;
        }
        iprot.readFieldEnd();
      }
      iprot.readStructEnd();


      // check for required fields of primitive type, which can't be checked in the validate method
      validate();
    }

    public function write(oprot:TProtocol):void {
      validate();

      oprot.writeStructBegin(STRUCT_DESC);
      oprot.writeFieldBegin(UID_FIELD_DESC);
      oprot.writeI32(this.uid);
      oprot.writeFieldEnd();
      if (this.property_info != null) {
        oprot.writeFieldBegin(PROPERTY_INFO_FIELD_DESC);
        this.property_info.write(oprot);
        oprot.writeFieldEnd();
      }
      oprot.writeFieldBegin(SERVER_TIME_FIELD_DESC);
      oprot.writeI32(this.server_time);
      oprot.writeFieldEnd();
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("user_login_ret_t(");
      var first:Boolean = true;

      ret += "uid:";
      ret += this.uid;
      first = false;
      if (!first) ret +=  ", ";
      ret += "property_info:";
      if (this.property_info == null) {
        ret += "null";
      } else {
        ret += this.property_info;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "server_time:";
      ret += this.server_time;
      first = false;
      ret += ")";
      return ret;
    }

    public function validate():void {
      // check for required fields
      // check that fields of type enum have valid values
    }

  }

}