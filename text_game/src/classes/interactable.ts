import Action from './action'
import Condition from './condition'
import BasicProfile from './components/basic-profile'

export default class Interactable{
    profile:BasicProfile
    condition:Condition | undefined
    actions:Action[]

    constructor(name:string, condition?:Condition){
        this.profile = new BasicProfile(name, "") // TODO: add descriptions to interactables
        this.condition = condition
        this.actions = []
    }

    public registerAction(action:Action){
        this.actions.push(action)
    }

    public checkActionExistAndRetrieve(verb:string): Action | undefined{
        let action:Action | undefined = this.actions.find((action)=>{
            return action.profile.name == verb
        })
        return action
    }
}