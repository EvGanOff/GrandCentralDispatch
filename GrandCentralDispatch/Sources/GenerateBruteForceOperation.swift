//
//  GenerateBruteForceOperation.swift
//  GrandCentralDispatch
//
//  Created by Евгений Ганусенко on 2/24/22.
//

import Foundation

class GenerateBruteForceOperation {

    // Сравнивает заданный пароль со сгенерированной строкой. Если сгенерированная строка совпадает с заданным паролем, метод выводит сгенерированную строку в консоль.
    func bruteForce(passwordToUnlock: String) {
        let allowedCharacters: [String] = String().printable.map { String($0) }
        var password: String = ""
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: allowedCharacters)
            print(password)
        }
        print(password)
    }

    // Получает индекс заданного символа (тип Character) в заданном массиве типа [String]. Возвращает -1, если не удалось найти символ.
    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    // Получает символ в заданной позиции (индекс) в заданном массиве. Возвращает пустой символ "", если не удается найти символ.
    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
                                   : Character("")
    }

    // Генерирует новую строку (result) из массива (array) и строки (string), заменяя последний символ.
    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var result: String = string
        if result.count <= 0 {
            result.append(characterAt(index: 0, array))
        }
        else {
            result.replace(at: result.count - 1, with: characterAt(index: (indexOf(character: result.last!, array) + 1) % array.count, array))
            if indexOf(character: result.last!, array) == 0 {
                result = String(generateBruteForce(String(result.dropLast()), fromArray: array)) + String(result.last!)
            }
        }
        return result
    }
}
