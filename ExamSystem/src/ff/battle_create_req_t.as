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


  public class battle_create_req_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("battle_create_req_t");
    private static const MODE_FIELD_DESC:TField = new TField("mode", TType.I16, 1);
    private static const FRIEND_ID_FIELD_DESC:TField = new TField("friend_id", TType.I32, 2);

    private var _mode:int;
    public static const MODE:int = 1;
    private var _friend_id:int;
    public static const FRIEND_ID:int = 2;

    private var __isset_mode:Boolean = false;
    private var __isset_friend_id:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[MODE] = new FieldMetaData("mode", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I16));
      metaDataMap[FRIEND_ID] = new FieldMetaData("friend_id", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
    }
    {
      FieldMetaData.addStructMetaDataMap(battle_create_req_t, metaDataMap);
    }

    public function battle_create_req_t() {
      this._mode = 0;
      this._friend_id = 0;
    }

    public function get mode():int {
      return this._mode;
    }

    public function set mode(mode:int):void {
      this._mode = mode;
      this.__isset_mode = true;
    }

    public function unsetMode():void {
      this.__isset_mode = false;
    }

    // Returns true if field mode is set (has been assigned a value) and false otherwise
    public function isSetMode():Boolean {
      return this.__isset_mode;
    }

    public function get friend_id():int {
      return this._friend_id;
    }

    public function set friend_id(friend_id:int):void {
      this._friend_id = friend_id;
      this.__isset_friend_id = true;
    }

    public function unsetFriend_id():void {
      this.__isset_friend_id = false;
    }

    // Returns true if field friend_id is set (has been assigned a value) and false otherwise
    public function isSetFriend_id():Boolean {
      return this.__isset_friend_id;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case MODE:
        if (value == null) {
          unsetMode();
        } else {
          this.mode = value;
        }
        break;

      case FRIEND_ID:
        if (value == null) {
          unsetFriend_id();
        } else {
          this.friend_id = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case MODE:
        return this.mode;
      case FRIEND_ID:
        return this.friend_id;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case MODE:
        return isSetMode();
      case FRIEND_ID:
        return isSetFriend_id();
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
          case MODE:
            if (field.type == TType.I16) {
              this.mode = iprot.readI16();
              this.__isset_mode = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case FRIEND_ID:
            if (field.type == TType.I32) {
              this.friend_id = iprot.readI32();
              this.__isset_friend_id = true;
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
      oprot.writeFieldBegin(MODE_FIELD_DESC);
      oprot.writeI16(this.mode);
      oprot.writeFieldEnd();
      oprot.writeFieldBegin(FRIEND_ID_FIELD_DESC);
      oprot.writeI32(this.friend_id);
      oprot.writeFieldEnd();
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("battle_create_req_t(");
      var first:Boolean = true;

      ret += "mode:";
      ret += this.mode;
      first = false;
      if (!first) ret +=  ", ";
      ret += "friend_id:";
      ret += this.friend_id;
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
