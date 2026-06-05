import Room from './room'
import RoomJsonParser from './roomjsonparser'

export default class GameMaster{
    rooms:Room[]

    constructor(){
        this.rooms = new RoomJsonParser().getRooms()
        console.log("rooms: ", this.rooms)
    }
}