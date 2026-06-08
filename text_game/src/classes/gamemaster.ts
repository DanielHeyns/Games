import Room from './room'
import RoomJsonParser from './room-json-parser'
import Player from './player'
import Command from './command'
import Terminal from 'terminal-js-emulator'
import miscData from '../assets/misc.json'
import InputParser from './input-parser'
import Interactable from './interactable'
import Action from './action'

export default class GameMaster{
    private rooms:Room[]
    private player:Player
    private ip:InputParser
    private term:Terminal

    constructor(){
        this.rooms = new RoomJsonParser().getRooms()
        this.player = new Player(0)
        this.ip = new InputParser()
        this.term = this._initializeTerminal()
    }

    public async runGame() {
        this.term.print(miscData.introduction);

        while (true) {
            await this._askForInput();
        }
    }

    private _askForInput(): Promise<void> {
        return new Promise((resolve) => {
            this.term.input('What do you do?', (input: string) => {
                this._takeRawPlayerInput(input);
                resolve();
            });
        });
    }

    private _takeRawPlayerInput(input:string){
        let command:Command | string = this.ip.parseInput(input)

        if(typeof command == "string"){
            this.term.print(command)
            return
        }

        // room verification
        let room:Room | undefined = this.rooms.find((r:Room)=>{
            return r.position == this.player.position
        })
        if(!room){
            this.term.print("Player position is not valid")
            return
        }

        // interactable verification
        let interactable:Interactable | undefined = room.checkInteractableExistAndRetrieve(command.object)
        if(!interactable){
            this.term.print(`There is no ${command.object} in this room`)
            return
        }

        //TODO: ADD CONDITION LOGIC HERE TO CHECK IF INTERACTABLE

        // action verification
        let action:Action | undefined = interactable.checkActionExistAndRetrieve(command.verb)
        if(!action){
            this.term.print(`You cannot ${command.verb} a ${command.object}`)
            return
        }

        this.term.print(action.profile.description)

        // TODO: DO ASSIGNMENT OF CONDITION VARIABLES ACCORDING TO ACTION

    }

    private _initializeTerminal(): Terminal{
        var t1 = new Terminal("terminal-container")
        t1.setHeight("400px")
        t1.setWidth('1050px')
        document.body.appendChild(t1.html)
        return t1
    }
}