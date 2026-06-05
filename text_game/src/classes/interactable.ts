import Action from './action'
import Condition from './condition'

export default class Interactable{
    name:string
    condition:Condition | undefined
    actions:Action[]

    constructor(name:string, condition?:Condition){
        this.name = name
        this.condition = condition
        this.actions = []
    }

    public registerAction(action:Action){
        this.actions.push(action)
    }
}