import Command from './command'
import lemma_list_json from '../assets/lemma-list.json'

export default class InputParser{
    private lemmaMap:Map<string, string>;

    constructor(){
        this.lemmaMap = new Map<string, string>()
        lemma_list_json.forEach(lemma_item => {
            lemma_item.synonyms.forEach(syn => {
                this.lemmaMap.set(syn, lemma_item.canonical)
            })
        })
    }

    public parseInput(input:string): Command | string{
        let words:string[] = input.split(" ")

        if(words.length == 3){
            words.splice(1, 1)
        } else if(words.length > 3){
            return "Use fewer words."
        }

        let lemma:string | undefined = this.lemmaMap.get(words[0])

        if(!lemma){
            return "Verb not found in lemma list json."
        }

        return new Command(lemma, words[1])
    }

}