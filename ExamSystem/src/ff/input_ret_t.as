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


  public class input_ret_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("input_ret_t");
    private static const FLAG_FIELD_DESC:TField = new TField("flag", TType.BOOL, 1);
    private static const INC_COIN_FIELD_DESC:TField = new TField("inc_coin", TType.I32, 2);
    private static const COIN_TYPE_FIELD_DESC:TField = new TField("coin_type", TType.I32, 3);

    private var _flag:Boolean;
    public static const FLAG:int = 1;
    private var _inc_coin:int;
    public static const INC_COIN:int = 2;
    private var _coin_type:int;
    public static const COIN_TYPE:int = 3;

    private var __isset_flag:Boolean = false;
    private var __isset_inc_coin:Boolean = false;
    private var __isset_coin_type:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[FLAG] = new FieldMetaData("flag", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.BOOL));
      metaDataMap[INC_COIN] = new FieldMetaData("inc_coin", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
      metaDataMap[COIN_TYPE] = new FieldMetaData("coin_type", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
    }
    {
      FieldMetaData.addStructMetaDataMap(input_ret_t, metaDataMap);
    }

    public function input_ret_t() {
      this._flag = 0;
      this._inc_coin = 0;
      this._coin_type = 0;
    }

    public function get flag():Boolean {
      return this._flag;
    }

    public function set flag(flag:Boolean):void {
      this._flag = flag;
      this.__isset_flag = true;
    }

    public function unsetFlag():void {
      this.__isset_flag = false;
    }

    // Returns true if field flag is set (has been assigned a value) and false otherwise
    public function isSetFlag():Boolean {
      return this.__isset_flag;
    }

    public function get inc_coin():int {
      return this._inc_coin;
    }

    public function set inc_coin(inc_coin:int):void {
      this._inc_coin = inc_coin;
      this.__isset_inc_coin = true;
    }

    public function unsetInc_coin():void {
      this.__isset_inc_coin = false;
    }

    // Returns true if field inc_coin is set (has been assigned a value) and false otherwise
    public function isSetInc_coin():Boolean {
      return this.__isset_inc_coin;
    }

    public function get coin_type():int {
      return this._coin_type;
    }

    public function set coin_type(coin_type:int):void {
      this._coin_type = coin_type;
      this.__isset_coin_type = true;
    }

    public function unsetCoin_type():void {
      this.__isset_coin_type = false;
    }

    // Returns true if field coin_type is set (has been assigned a value) and false otherwise
    public function isSetCoin_type():Boolean {
      return this.__isset_coin_type;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case FLAG:
        if (value == null) {
          unsetFlag();
        } else {
          this.flag = value;
        }
        break;

      case INC_COIN:
        if (value == null) {
          unsetInc_coin();
        } else {
          this.inc_coin = value;
        }
        break;

      case COIN_TYPE:
        if (value == null) {
          unsetCoin_type();
        } else {
          this.coin_type = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case FLAG:
        return this.flag;
      case INC_COIN:
        return this.inc_coin;
      case COIN_TYPE:
        return this.coin_type;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case FLAG:
        return isSetFlag();
      case INC_COIN:
        return isSetInc_coin();
      case COIN_TYPE:
        return isSetCoin_type();
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
          case FLAG:
            if (field.type == TType.BOOL) {
              this.flag = iprot.readBool();
              this.__isset_flag = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case INC_COIN:
            if (field.type == TType.I32) {
              this.inc_coin = iprot.readI32();
              this.__isset_inc_coin = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case COIN_TYPE:
            if (field.type == TType.I32) {
              this.coin_type = iprot.readI32();
              this.__isset_coin_type = true;
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
      oprot.writeFieldBegin(FLAG_FIELD_DESC);
      oprot.writeBool(this.flag);
      oprot.writeFieldEnd();
      oprot.writeFieldBegin(INC_COIN_FIELD_DESC);
      oprot.writeI32(this.inc_coin);
      oprot.writeFieldEnd();
      oprot.writeFieldBegin(COIN_TYPE_FIELD_DESC);
      oprot.writeI32(this.coin_type);
      oprot.writeFieldEnd();
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("input_ret_t(");
      var first:Boolean = true;

      ret += "flag:";
      ret += this.flag;
      first = false;
      if (!first) ret +=  ", ";
      ret += "inc_coin:";
      ret += this.inc_coin;
      first = false;
      if (!first) ret +=  ", ";
      ret += "coin_type:";
      ret += this.coin_type;
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
