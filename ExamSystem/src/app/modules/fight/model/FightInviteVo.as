package app.modules.fight.model
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-12-28
	 */
	public class FightInviteVo
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function FightInviteVo( name:String, uid:int, level:int, gender:int, grader:String )
		{
			this.name = name;
			this.uid = uid;
			this.level = level;
			this.gender = gender;
			this.grade = grade;
		}
		public var name:String = "";
		public var uid:int = 0;
		public var level:int = 0;
		public var gender:int = 0;
		public var grade:String = "";
		
		
	}
}