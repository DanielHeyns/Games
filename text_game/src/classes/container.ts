import BasicProfile from "./components/basic-profile"

class Container{
    private profile: BasicProfile

    constructor(name:string, desc:string){
        this.profile = new BasicProfile(name, desc)
    }
}