import './style.css'
import Terminal from 'terminal-js-emulator'
import miscData from './assets/misc.json'
import GameMaster from './classes/gamemaster'
import InputParser from './classes/input-parser'

var t1 = new Terminal("terminal-container")
t1.setHeight("400px")
t1.setWidth('1050px')
document.body.appendChild(t1.html)


let gm:GameMaster = new GameMaster()
let ip:InputParser = new InputParser()

t1.print(miscData.introduction)
t1.input('What do you do?', function (input:string) {
  console.log("parsed input: ", ip.parseInput(input))
})
