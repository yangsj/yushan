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


  public class account_req_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("account_req_t");
    private static const NICK_NAME_FIELD_DESC:TField = new TField("nick_name", TType.STRING, 1);
    private static const PASSWORD_FIELD_DESC:TField = new TField("password", TType.STRING, 2);
    private static const NEW_PASSWORD_FIELD_DESC:TField = new TField("new_password", TType.STRING, 13);
    private static const REGISTER_FLAG_FIELD_DESC:TField = new TField("register_flag", TType.BOOL, 3);
    private static const EMAIL_FIELD_DESC:TField = new TField("email", TType.STRING, 4);
    private static const REAL_NAME_FIELD_DESC:TField = new TField("real_name", TType.STRING, 5);
    private static const AGE_FIELD_DESC:TField = new TField("age", TType.I16, 6);
    private static const SCHOOL_FIELD_DESC:TField = new TField("school", TType.STRING, 7);
    private static const GRADE_FIELD_DESC:TField = new TField("grade", TType.STRING, 8);
    private static const QQ_FIELD_DESC:TField = new TField("qq", TType.STRING, 9);
    private static const PHONE_FIELD_DESC:TField = new TField("phone", TType.STRING, 10);
    private static const ADDRESS_FIELD_DESC:TField = new TField("address", TType.STRING, 11);
    private static const GENDER_FIELD_DESC:TField = new TField("gender", TType.I16, 12);

    private var _nick_name:String;
    public static const NICK_NAME:int = 1;
    private var _password:String;
    public static const PASSWORD:int = 2;
    private var _new_password:String;
    public static const NEW_PASSWORD:int = 13;
    private var _register_flag:Boolean;
    public static const REGISTER_FLAG:int = 3;
    private var _email:String;
    public static const EMAIL:int = 4;
    private var _real_name:String;
    public static const REAL_NAME:int = 5;
    private var _age:int;
    public static const AGE:int = 6;
    private var _school:String;
    public static const SCHOOL:int = 7;
    private var _grade:String;
    public static const GRADE:int = 8;
    private var _qq:String;
    public static const QQ:int = 9;
    private var _phone:String;
    public static const PHONE:int = 10;
    private var _address:String;
    public static const ADDRESS:int = 11;
    private var _gender:int;
    public static const GENDER:int = 12;

    private var __isset_register_flag:Boolean = false;
    private var __isset_age:Boolean = false;
    private var __isset_gender:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[NICK_NAME] = new FieldMetaData("nick_name", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.STRING));
      metaDataMap[PASSWORD] = new FieldMetaData("password", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.STRING));
      metaDataMap[NEW_PASSWORD] = new FieldMetaData("new_password", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.STRING));
      metaDataMap[REGISTER_FLAG] = new FieldMetaData("register_flag", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.BOOL));
      metaDataMap[EMAIL] = new FieldMetaData("email", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.STRING));
      metaDataMap[REAL_NAME] = new FieldMetaData("real_name", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.STRING));
      metaDataMap[AGE] = new FieldMetaData("age", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I16));
      metaDataMap[SCHOOL] = new FieldMetaData("school", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.STRING));
      metaDataMap[GRADE] = new FieldMetaData("grade", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.STRING));
      metaDataMap[QQ] = new FieldMetaData("qq", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.STRING));
      metaDataMap[PHONE] = new FieldMetaData("phone", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.STRING));
      metaDataMap[ADDRESS] = new FieldMetaData("address", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.STRING));
      metaDataMap[GENDER] = new FieldMetaData("gender", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I16));
    }
    {
      FieldMetaData.addStructMetaDataMap(account_req_t, metaDataMap);
    }

    public function account_req_t() {
      this._register_flag = 0;
      this._age = 0;
      this._gender = 0;
    }

    public function get nick_name():String {
      return this._nick_name;
    }

    public function set nick_name(nick_name:String):void {
      this._nick_name = nick_name;
    }

    public function unsetNick_name():void {
      this.nick_name = null;
    }

    // Returns true if field nick_name is set (has been assigned a value) and false otherwise
    public function isSetNick_name():Boolean {
      return this.nick_name != null;
    }

    public function get password():String {
      return this._password;
    }

    public function set password(password:String):void {
      this._password = password;
    }

    public function unsetPassword():void {
      this.password = null;
    }

    // Returns true if field password is set (has been assigned a value) and false otherwise
    public function isSetPassword():Boolean {
      return this.password != null;
    }

    public function get new_password():String {
      return this._new_password;
    }

    public function set new_password(new_password:String):void {
      this._new_password = new_password;
    }

    public function unsetNew_password():void {
      this.new_password = null;
    }

    // Returns true if field new_password is set (has been assigned a value) and false otherwise
    public function isSetNew_password():Boolean {
      return this.new_password != null;
    }

    public function get register_flag():Boolean {
      return this._register_flag;
    }

    public function set register_flag(register_flag:Boolean):void {
      this._register_flag = register_flag;
      this.__isset_register_flag = true;
    }

    public function unsetRegister_flag():void {
      this.__isset_register_flag = false;
    }

    // Returns true if field register_flag is set (has been assigned a value) and false otherwise
    public function isSetRegister_flag():Boolean {
      return this.__isset_register_flag;
    }

    public function get email():String {
      return this._email;
    }

    public function set email(email:String):void {
      this._email = email;
    }

    public function unsetEmail():void {
      this.email = null;
    }

    // Returns true if field email is set (has been assigned a value) and false otherwise
    public function isSetEmail():Boolean {
      return this.email != null;
    }

    public function get real_name():String {
      return this._real_name;
    }

    public function set real_name(real_name:String):void {
      this._real_name = real_name;
    }

    public function unsetReal_name():void {
      this.real_name = null;
    }

    // Returns true if field real_name is set (has been assigned a value) and false otherwise
    public function isSetReal_name():Boolean {
      return this.real_name != null;
    }

    public function get age():int {
      return this._age;
    }

    public function set age(age:int):void {
      this._age = age;
      this.__isset_age = true;
    }

    public function unsetAge():void {
      this.__isset_age = false;
    }

    // Returns true if field age is set (has been assigned a value) and false otherwise
    public function isSetAge():Boolean {
      return this.__isset_age;
    }

    public function get school():String {
      return this._school;
    }

    public function set school(school:String):void {
      this._school = school;
    }

    public function unsetSchool():void {
      this.school = null;
    }

    // Returns true if field school is set (has been assigned a value) and false otherwise
    public function isSetSchool():Boolean {
      return this.school != null;
    }

    public function get grade():String {
      return this._grade;
    }

    public function set grade(grade:String):void {
      this._grade = grade;
    }

    public function unsetGrade():void {
      this.grade = null;
    }

    // Returns true if field grade is set (has been assigned a value) and false otherwise
    public function isSetGrade():Boolean {
      return this.grade != null;
    }

    public function get qq():String {
      return this._qq;
    }

    public function set qq(qq:String):void {
      this._qq = qq;
    }

    public function unsetQq():void {
      this.qq = null;
    }

    // Returns true if field qq is set (has been assigned a value) and false otherwise
    public function isSetQq():Boolean {
      return this.qq != null;
    }

    public function get phone():String {
      return this._phone;
    }

    public function set phone(phone:String):void {
      this._phone = phone;
    }

    public function unsetPhone():void {
      this.phone = null;
    }

    // Returns true if field phone is set (has been assigned a value) and false otherwise
    public function isSetPhone():Boolean {
      return this.phone != null;
    }

    public function get address():String {
      return this._address;
    }

    public function set address(address:String):void {
      this._address = address;
    }

    public function unsetAddress():void {
      this.address = null;
    }

    // Returns true if field address is set (has been assigned a value) and false otherwise
    public function isSetAddress():Boolean {
      return this.address != null;
    }

    public function get gender():int {
      return this._gender;
    }

    public function set gender(gender:int):void {
      this._gender = gender;
      this.__isset_gender = true;
    }

    public function unsetGender():void {
      this.__isset_gender = false;
    }

    // Returns true if field gender is set (has been assigned a value) and false otherwise
    public function isSetGender():Boolean {
      return this.__isset_gender;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case NICK_NAME:
        if (value == null) {
          unsetNick_name();
        } else {
          this.nick_name = value;
        }
        break;

      case PASSWORD:
        if (value == null) {
          unsetPassword();
        } else {
          this.password = value;
        }
        break;

      case NEW_PASSWORD:
        if (value == null) {
          unsetNew_password();
        } else {
          this.new_password = value;
        }
        break;

      case REGISTER_FLAG:
        if (value == null) {
          unsetRegister_flag();
        } else {
          this.register_flag = value;
        }
        break;

      case EMAIL:
        if (value == null) {
          unsetEmail();
        } else {
          this.email = value;
        }
        break;

      case REAL_NAME:
        if (value == null) {
          unsetReal_name();
        } else {
          this.real_name = value;
        }
        break;

      case AGE:
        if (value == null) {
          unsetAge();
        } else {
          this.age = value;
        }
        break;

      case SCHOOL:
        if (value == null) {
          unsetSchool();
        } else {
          this.school = value;
        }
        break;

      case GRADE:
        if (value == null) {
          unsetGrade();
        } else {
          this.grade = value;
        }
        break;

      case QQ:
        if (value == null) {
          unsetQq();
        } else {
          this.qq = value;
        }
        break;

      case PHONE:
        if (value == null) {
          unsetPhone();
        } else {
          this.phone = value;
        }
        break;

      case ADDRESS:
        if (value == null) {
          unsetAddress();
        } else {
          this.address = value;
        }
        break;

      case GENDER:
        if (value == null) {
          unsetGender();
        } else {
          this.gender = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case NICK_NAME:
        return this.nick_name;
      case PASSWORD:
        return this.password;
      case NEW_PASSWORD:
        return this.new_password;
      case REGISTER_FLAG:
        return this.register_flag;
      case EMAIL:
        return this.email;
      case REAL_NAME:
        return this.real_name;
      case AGE:
        return this.age;
      case SCHOOL:
        return this.school;
      case GRADE:
        return this.grade;
      case QQ:
        return this.qq;
      case PHONE:
        return this.phone;
      case ADDRESS:
        return this.address;
      case GENDER:
        return this.gender;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case NICK_NAME:
        return isSetNick_name();
      case PASSWORD:
        return isSetPassword();
      case NEW_PASSWORD:
        return isSetNew_password();
      case REGISTER_FLAG:
        return isSetRegister_flag();
      case EMAIL:
        return isSetEmail();
      case REAL_NAME:
        return isSetReal_name();
      case AGE:
        return isSetAge();
      case SCHOOL:
        return isSetSchool();
      case GRADE:
        return isSetGrade();
      case QQ:
        return isSetQq();
      case PHONE:
        return isSetPhone();
      case ADDRESS:
        return isSetAddress();
      case GENDER:
        return isSetGender();
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
          case NICK_NAME:
            if (field.type == TType.STRING) {
              this.nick_name = iprot.readString();
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case PASSWORD:
            if (field.type == TType.STRING) {
              this.password = iprot.readString();
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case NEW_PASSWORD:
            if (field.type == TType.STRING) {
              this.new_password = iprot.readString();
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case REGISTER_FLAG:
            if (field.type == TType.BOOL) {
              this.register_flag = iprot.readBool();
              this.__isset_register_flag = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case EMAIL:
            if (field.type == TType.STRING) {
              this.email = iprot.readString();
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case REAL_NAME:
            if (field.type == TType.STRING) {
              this.real_name = iprot.readString();
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case AGE:
            if (field.type == TType.I16) {
              this.age = iprot.readI16();
              this.__isset_age = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case SCHOOL:
            if (field.type == TType.STRING) {
              this.school = iprot.readString();
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case GRADE:
            if (field.type == TType.STRING) {
              this.grade = iprot.readString();
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case QQ:
            if (field.type == TType.STRING) {
              this.qq = iprot.readString();
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case PHONE:
            if (field.type == TType.STRING) {
              this.phone = iprot.readString();
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case ADDRESS:
            if (field.type == TType.STRING) {
              this.address = iprot.readString();
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case GENDER:
            if (field.type == TType.I16) {
              this.gender = iprot.readI16();
              this.__isset_gender = true;
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
      if (this.nick_name != null) {
        oprot.writeFieldBegin(NICK_NAME_FIELD_DESC);
        oprot.writeString(this.nick_name);
        oprot.writeFieldEnd();
      }
      if (this.password != null) {
        oprot.writeFieldBegin(PASSWORD_FIELD_DESC);
        oprot.writeString(this.password);
        oprot.writeFieldEnd();
      }
      oprot.writeFieldBegin(REGISTER_FLAG_FIELD_DESC);
      oprot.writeBool(this.register_flag);
      oprot.writeFieldEnd();
      if (this.email != null) {
        oprot.writeFieldBegin(EMAIL_FIELD_DESC);
        oprot.writeString(this.email);
        oprot.writeFieldEnd();
      }
      if (this.real_name != null) {
        oprot.writeFieldBegin(REAL_NAME_FIELD_DESC);
        oprot.writeString(this.real_name);
        oprot.writeFieldEnd();
      }
      oprot.writeFieldBegin(AGE_FIELD_DESC);
      oprot.writeI16(this.age);
      oprot.writeFieldEnd();
      if (this.school != null) {
        oprot.writeFieldBegin(SCHOOL_FIELD_DESC);
        oprot.writeString(this.school);
        oprot.writeFieldEnd();
      }
      if (this.grade != null) {
        oprot.writeFieldBegin(GRADE_FIELD_DESC);
        oprot.writeString(this.grade);
        oprot.writeFieldEnd();
      }
      if (this.qq != null) {
        oprot.writeFieldBegin(QQ_FIELD_DESC);
        oprot.writeString(this.qq);
        oprot.writeFieldEnd();
      }
      if (this.phone != null) {
        oprot.writeFieldBegin(PHONE_FIELD_DESC);
        oprot.writeString(this.phone);
        oprot.writeFieldEnd();
      }
      if (this.address != null) {
        oprot.writeFieldBegin(ADDRESS_FIELD_DESC);
        oprot.writeString(this.address);
        oprot.writeFieldEnd();
      }
      oprot.writeFieldBegin(GENDER_FIELD_DESC);
      oprot.writeI16(this.gender);
      oprot.writeFieldEnd();
      if (this.new_password != null) {
        oprot.writeFieldBegin(NEW_PASSWORD_FIELD_DESC);
        oprot.writeString(this.new_password);
        oprot.writeFieldEnd();
      }
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("account_req_t(");
      var first:Boolean = true;

      ret += "nick_name:";
      if (this.nick_name == null) {
        ret += "null";
      } else {
        ret += this.nick_name;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "password:";
      if (this.password == null) {
        ret += "null";
      } else {
        ret += this.password;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "new_password:";
      if (this.new_password == null) {
        ret += "null";
      } else {
        ret += this.new_password;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "register_flag:";
      ret += this.register_flag;
      first = false;
      if (!first) ret +=  ", ";
      ret += "email:";
      if (this.email == null) {
        ret += "null";
      } else {
        ret += this.email;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "real_name:";
      if (this.real_name == null) {
        ret += "null";
      } else {
        ret += this.real_name;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "age:";
      ret += this.age;
      first = false;
      if (!first) ret +=  ", ";
      ret += "school:";
      if (this.school == null) {
        ret += "null";
      } else {
        ret += this.school;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "grade:";
      if (this.grade == null) {
        ret += "null";
      } else {
        ret += this.grade;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "qq:";
      if (this.qq == null) {
        ret += "null";
      } else {
        ret += this.qq;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "phone:";
      if (this.phone == null) {
        ret += "null";
      } else {
        ret += this.phone;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "address:";
      if (this.address == null) {
        ret += "null";
      } else {
        ret += this.address;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "gender:";
      ret += this.gender;
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