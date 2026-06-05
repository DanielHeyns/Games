import BasicProfile from './components/basic-profile'
import Interactable from './interactable'

export default class Room {
    private profile: BasicProfile
    private position: number
    private interactables: Interactable[]

    constructor(name:string, description:string, position:number){
        this.profile = new BasicProfile(name, description)
        this.position = position
        this.interactables = []
    }

    public registerInteractable(interactable:Interactable){
        this.interactables.push(interactable)
    }
}


