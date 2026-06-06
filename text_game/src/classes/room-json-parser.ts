import Room from '../classes/room'
import Interactable from './interactable'
import Condition from './condition'
import Action from './action'
import Assignment from './assignment'

export default class RoomJsonParser {
    private rooms_json: any[]

    constructor() {
        this.rooms_json = this.loadAllRooms()
    }

    private loadAllRooms(): any[] { // returns a json object from the file
        const modules = import.meta.glob('../assets/rooms/*.json', { eager: true })
        return Object.values(modules).map(m => (m as any).default ?? m)
    }

    public getRooms(): Room[]{
        let room_array:Room[]  = []
        this.rooms_json.forEach((room_json) => {
            let position:number = 1 // TODO: make a way to randomize the rooms after making more rooms
            if(room_json?.starting_room){
                position = 0
            }

            let room:Room = new Room(room_json['name'], room_json['description'], position)
            
            room_json["interactables"].forEach((interactable_json:any) =>{
                let condition: Condition | undefined = this._create_condition_from_json(interactable_json);

                let interactable:Interactable = new Interactable(interactable_json['name'], condition)

                interactable_json["actions"].forEach((action_json:any)=>{
                    let condition: Condition | undefined = this._create_condition_from_json(action_json);
                    let assignment: Assignment | undefined = this._create_assignment_from_json(action_json)
                    let action:Action = new Action(action_json['name'], action_json['description'], condition, assignment)

                    interactable.registerAction(action)
                })
                room.registerInteractable(interactable)
            })
            room_array.push(room)
        })
        return room_array
    }

    private _create_condition_from_json(json_arg:any): Condition | undefined{
        let condition: Condition | undefined = undefined;
        if('condition' in json_arg) condition = new Condition(json_arg['condition']['var_name'], json_arg['condition']['req_val'])
        return condition
    }

    private _create_assignment_from_json(json_arg:any): Assignment | undefined{
        let assignment: Assignment | undefined = undefined;
        if('assignment' in json_arg) assignment = new Assignment(json_arg['assignment']['var_name'], json_arg['assignment']['val'])
        return assignment
    }

}