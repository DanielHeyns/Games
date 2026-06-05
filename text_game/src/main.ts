import './style.css'
import Terminal from 'terminal-js-emulator'
import miscData from './assets/misc.json'
import GameMaster from './classes/gamemaster'

new GameMaster()
var t1 = new Terminal("terminal-container")
t1.setHeight("400px")
t1.setWidth('1050px')
document.body.appendChild(t1.html)


t1.print(miscData.introduction)
t1.input('What are you called?', function (input:string) {
  t1.print('Welcome, ' + input)
})
