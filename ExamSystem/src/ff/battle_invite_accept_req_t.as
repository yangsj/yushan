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


  public class battle_invite_accept_req_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("battle_invite_accept_req_t");
    private static const DEST_ID_FIELD_DESC:TField = new TField("dest_id", TType.I32, 1);
    private static const ACCEPT_FLAG_FIELD_DESC:TField = new TField("accept_flag", TType.BOOL, 2);

    private var _dest_id:int;
    public static const DEST_ID:int = 1;
    private var _accept_flag:Boolean;
    public static const ACCEPT_FLAG:int = 2;

    private var __isset_dest_id:Boolean = false;
    private var __isset_accept_flag:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[DEST_ID] = new FieldMetaData("dest_id", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
      metaDataMap[ACCEPT_FLAG] = new FieldMetaData("accept_flag", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.BOOL));
    }
    {
      FieldMetaData.addStructMetaDataMap(battle_invite_accept_req_t, metaDataMap);
    }

    public function battle_invite_accept_req_t() {
      this._dest_id = 0;
      this._accept_flag = 0;
    }

    public function get dest_id():int {
      return this._dest_id;
    }

    public function set dest_id(dest_id:int):void {
      this._dest_id = dest_id;
      this.__isset_dest_id = true;
    }

    public function unsetDest_id():void {
      this.__isset_dest_id = false;
    }

    // Returns true if field dest_id is set (has been assigned a value) and false otherwise
    public function isSetDest_id():Boolean {
      return this.__isset_dest_id;
    }

    public function get accept_flag():Boolean {
      return this._accept_flag;
    }

    public function set accept_flag(accept_flag:Boolean):void {
      this._accept_flag = accept_flag;
      this.__isset_accept_flag = true;
    }

    public function unsetAccept_flag():void {
      this.__isset_accept_flag = false;
    }

    // Returns true if field accept_flag is set (has been assigned a value) and false otherwise
    public function isSetAccept_flag():Boolean {
      return this.__isset_accept_flag;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case DEST_ID:
        if (value == null) {
          unsetDest_id();
        } else {
          this.dest_id = value;
        }
        break;

      case ACCEPT_FLAG:
        if (value == null) {
          unsetAccept_flag();
        } else {
          this.accept_flag = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case DEST_ID:
        return this.dest_id;
      case ACCEPT_FLAG:
        return this.accept_flag;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case DEST_ID:
        return isSetDest_id();
      case ACCEPT_FLAG:
        return isSetAccept_flag();
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
          case DEST_ID:
            if (field.type == TType.I32) {
              this.dest_id = iprot.readI32();
              this.__isset_dest_id = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case ACCEPT_FLAG:
            if (field.type == TType.BOOL) {
              this.accept_flag = iprot.readBool();
              this.__isset_accept_flag = true;
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
      oprot.writeFieldBegin(DEST_ID_FIELD_DESC);
      oprot.writeI32(this.dest_id);
      oprot.writeFieldEnd();
      oprot.writeFieldBegin(ACCEPT_FLAG_FIELD_DESC);
      oprot.writeBool(this.accept_flag);
      oprot.writeFieldEnd();
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("battle_invite_accept_req_t(");
      var first:Boolean = true;

      ret += "dest_id:";
      ret += this.dest_id;
      first = false;
      if (!first) ret +=  ", ";
      ret += "accept_flag:";
      ret += this.accept_flag;
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
