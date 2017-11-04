import Cocoa

public enum myError : Error {
    case notFoundMorse
    case notFoundWord
    case empty
    case failRead
}
public func ReadMorse(path:String) throws -> ([String: Character], [Character: String]) {
    do{
        let data = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        let lines = data.components(separatedBy: CharacterSet.newlines)
        var chToMorse: [Character: String] = [:]
        var morseToCh: [String: Character] = [:]
        var lowerline = ""
        for line in lines {
            lowerline = line.lowercased()        // change the A-Z to a-z
            if line.count > 0{
                let ch = lowerline[lowerline.startIndex]  // the letter
                // get the reference morse code
                let maxRange = lowerline.index(lowerline.endIndex, offsetBy: -1)
                let lastWord = lowerline[maxRange]
                // the final comma "," in each line is not in morse code
                var rightMost: String.Index = lowerline.endIndex
                if lastWord == "," {
                    rightMost = lowerline.index(lowerline.endIndex, offsetBy: -1)
                }
                else {
                    rightMost = lowerline.endIndex
                }
                let leftMost = lowerline.index(lowerline.startIndex, offsetBy: 4)
                // use substring to get the
                let morseCode = String( lowerline[leftMost ..< rightMost] )
                chToMorse[ch] = morseCode
                morseToCh[morseCode] = ch
            }
        }
        return (morseToCh, chToMorse)
    }
    catch{
        throw myError.failRead
    }
}
public struct morseCoder {
    var word: String = ""
    var morseWord: String = ""
    var morseToCh: [String: Character] = [:]
    var chToMorse: [Character: String] = [:]
    init(alph: String) throws {
        (morseToCh, chToMorse) = try ReadMorse(path: "morse_code.txt")
        word = alph
        morseWord = try encode(alph: alph)
    }
    public init(morse: String) throws {
        (morseToCh, chToMorse) = try ReadMorse(path: "morse_code.txt")
        morseWord = morse
        word = try decode(morse: morse)
    }
    public func encode(alph: String) throws -> String {
        let alphList = Array<Character>(alph)
        var str: String = ""
        for ch in alphList {
            if let code = chToMorse[ch] {
                str = str + code + " "
            }
            else {
                throw myError.notFoundWord
            }
        }
        return str
    }
    public func decode(morse: String) throws -> String {
        let morseList = morse.components(separatedBy: CharacterSet.whitespaces)
        var str: String = ""
        for morseCode in morseList {
            if morseCode.count > 0 {
                if let ch = morseToCh[morseCode] {
                    str = str + String(ch)
                }
                else {
                    throw myError.notFoundMorse
                }
            }
        }
        return str
    }
    public func getMorse() -> String {
        return morseWord
    }
    public func getWord() -> String {
        return word
    }
}