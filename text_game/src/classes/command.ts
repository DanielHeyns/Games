export default class Command{
    public verb:string
    public object:string

    constructor(verb:string, object:string){
        this.verb = verb
        this.object = object
    }
}