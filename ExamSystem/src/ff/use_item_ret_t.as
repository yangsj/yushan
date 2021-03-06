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


  public class use_item_ret_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("use_item_ret_t");
    private static const ITEM_TYPE_FIELD_DESC:TField = new TField("item_type", TType.I16, 1);
    private static const UID_FIELD_DESC:TField = new TField("uid", TType.I32, 2);

    private var _item_type:int;
    public static const ITEM_TYPE:int = 1;
    private var _uid:int;
    public static const UID:int = 2;

    private var __isset_item_type:Boolean = false;
    private var __isset_uid:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[ITEM_TYPE] = new FieldMetaData("item_type", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I16));
      metaDataMap[UID] = new FieldMetaData("uid", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
    }
    {
      FieldMetaData.addStructMetaDataMap(use_item_ret_t, metaDataMap);
    }

    public function use_item_ret_t() {
      this._item_type = 0;
      this._uid = 0;
    }

    public function get item_type():int {
      return this._item_type;
    }

    public function set item_type(item_type:int):void {
      this._item_type = item_type;
      this.__isset_item_type = true;
    }

    public function unsetItem_type():void {
      this.__isset_item_type = false;
    }

    // Returns true if field item_type is set (has been assigned a value) and false otherwise
    public function isSetItem_type():Boolean {
      return this.__isset_item_type;
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

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case ITEM_TYPE:
        if (value == null) {
          unsetItem_type();
        } else {
          this.item_type = value;
        }
        break;

      case UID:
        if (value == null) {
          unsetUid();
        } else {
          this.uid = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case ITEM_TYPE:
        return this.item_type;
      case UID:
        return this.uid;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case ITEM_TYPE:
        return isSetItem_type();
      case UID:
        return isSetUid();
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
          case ITEM_TYPE:
            if (field.type == TType.I16) {
              this.item_type = iprot.readI16();
              this.__isset_item_type = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case UID:
            if (field.type == TType.I32) {
              this.uid = iprot.readI32();
              this.__isset_uid = true;
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
      oprot.writeFieldBegin(ITEM_TYPE_FIELD_DESC);
      oprot.writeI16(this.item_type);
      oprot.writeFieldEnd();
      oprot.writeFieldBegin(UID_FIELD_DESC);
      oprot.writeI32(this.uid);
      oprot.writeFieldEnd();
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("use_item_ret_t(");
      var first:Boolean = true;

      ret += "item_type:";
      ret += this.item_type;
      first = false;
      if (!first) ret +=  ", ";
      ret += "uid:";
      ret += this.uid;
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
