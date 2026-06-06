import Room from './room'
import RoomJsonParser from './room-json-parser'
import Player from './player'

export default class GameMaster{
    private rooms:Room[]
    private player:Player

    constructor(){
        this.rooms = new RoomJsonParser().getRooms()
        this.player = new Player(0)
        console.log("rooms: ", this.rooms)
    }
}