import SwiftUI

let judgeTable: [[Int]: [String: Any]] = [
    [0]: [
        "name": "Hanachirusato",
        "point": 3
    ],
    [1]: [
        "name": "Yugao",
        "point": 8
    ],
    [2]: [
        "name": "Yugiri",
        "point": 5
    ],
    [3,4,5]: [
        "name": "Miotsukushi",
        "point": 35
    ],
    [6]: [
        "name": "Suma",
        "point": 10
    ],
    [7]: [
        "name": "Makibashira",
        "point": 30
    ],
    [8]: [
        "name": "Akikaze",
        "point": 8
    ],
    [9,10,11]: [
        "name": "Matsukaze",
        "point": 4
    ],
    [12,14]: [
        "name": "Hahakigi",
        "point": 80
    ],
    [13]: [
        "name": "Shirotae",
        "point": 50
    ],
    [15,16,17]: [
        "name": "Tokonatsu",
        "point": 10
    ],
    [18]: [
        "name": "Sawarabi",
        "point": 4
    ],
    [19]: [
        "name": "Ukifune",
        "point": 20
    ],
    [20,26]: [
        "name": "Yomogiu",
        "point": 35
    ],
    [21,22,23]: [
        "name": "Kiritsubo",
        "point": 50
    ],
    [24,25]: [
        "name": "Akashi",
        "point": 20
    ],
    [45]: [
        "name": "Yumeno-Ukihashi",
        "point": 100
    ],
    [27,28,29]: [
        "name": "Tenarai",
        "point": 0
    ],
    [30,31,32]: [
        "name": "Kochou",
        "point": 85
    ],
    [33,34,35]: [
        "name": "Fujibakama",
        "point": 2
    ],
    [36,37,38]: [
        "name": "Konotabi",
        "point": 20
    ],
    [39,40,41]: [
        "name": "Ashibiki",
        "point": 40
    ],
    [42,43,44]: [
        "name": "Maboroshi",
        "point": 20
    ]
]

func findTrick(_ code: Int) -> [String: Any] {
    var result: [String: Any] = [
        "name": "error",
        "point": 0
    ]
    for trick in judgeTable {
        if trick.key.firstIndex(of: code) != nil {
            result = judgeTable[trick.key]!
            break
        }
    }
    return result
}

func trickConditions(_ code: Int) -> [String] {
    let overlap = code % 3
    let sensu = Int(code / 3) % 3
    let cho = Int(code / 9)
    var result:[String] = []
    if cho == 4 {
        result.append("Cho is hung on the makura")
    } else  {
        if Int(cho / 2) == 1 {
            result.append("Cho is Standing")
        }
        if cho % 2 == 1 {
            result.append("Cho is on the makura")
        }
        if cho == 0 {
            result.append("Cho is on the floor")
        }
    }
    if sensu == 1 {
        result.append("Sensu is on the makura")
    } else if sensu == 2 {
        result.append("Sensu is against the makura")
    } else if sensu == 0 {
        result.append("Sensu is on the floor")
    }
    if overlap == 1 {
        result.append("Cho is above the sensu")
    } else if overlap == 2 {
        result.append("Cho is under the sensu")
    }
    return result
}
