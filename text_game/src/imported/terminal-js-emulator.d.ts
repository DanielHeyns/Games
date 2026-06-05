declare module 'terminal-js-emulator' {
    export default class Terminal {
        html: HTMLElement
        constructor(containerId: string)
        setHeight(height: string): void
        setWidth(width: string): void
        print(text: string): void
        input(prompt: string, callback: (input: string) => void): void
    }
}