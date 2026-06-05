import Condition from "./condition" 
import BasicProfile from "./components/basic-profile"
import Assignment from "./assignment"

export default class Action{
    profile:BasicProfile // the names here should be standardized via a list of constants, they are canonical forms or lemmas. The parser will target these names via a synonym group. desc: what is printed when user performs this action
    condition:Condition | undefined // gm will check if this condition is met from his list of "circumstance variables", if the var name of the condition is present and the value matches the req val then the action is permitted. This is the same for the interactable, just on the interactable level not the action level.
    assignment:Assignment | undefined // this will be used to set a value according to json structure, to do quick context variable sets

    constructor(name:string, description:string, condition?:Condition, assignment?:Assignment){
        this.profile = new BasicProfile(name, description)
        this.condition = condition
        this.assignment = assignment
    }   
}