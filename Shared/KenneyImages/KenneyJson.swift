// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

struct KenneyJson {
    struct Prototype: Codable {
        let count: Int
        let firstIndex: Int
        let folderName: String
    }

    static let json = """
    [
      {
        "count" : 2,
        "folderName" : "biclops",
        "firstIndex" : 0
      },
      {
        "count" : 3,
        "folderName" : "bluethingLarge",
        "firstIndex" : 21
      },
      {
        "count" : 3,
        "folderName" : "bluethinglarge",
        "firstIndex" : 18
      },
      {
        "count" : 2,
        "folderName" : "claw",
        "firstIndex" : 11
      },
      {
        "count" : 2,
        "folderName" : "cyclops",
        "firstIndex" : 4
      },
      {
        "count" : 2,
        "folderName" : "emojer",
        "firstIndex" : 13
      },
      {
        "count" : 3,
        "folderName" : "flapper",
        "firstIndex" : 24
      },
      {
        "count" : 1,
        "folderName" : "grouch",
        "firstIndex" : 8
      },
      {
        "count" : 3,
        "folderName" : "inkwell",
        "firstIndex" : 15
      },
      {
        "count" : 2,
        "folderName" : "jumpywelder",
        "firstIndex" : 9
      },
      {
        "count" : 2,
        "folderName" : "sleepyjumper",
        "firstIndex" : 6
      },
      {
        "count" : 2,
        "folderName" : "triclops",
        "firstIndex" : 2
      }
    ]
    """

    static func decode() -> [KenneyJson.Prototype] {
        try! JSONDecoder().decode([KenneyJson.Prototype].self, from: json.data(using: .utf8)!)
    }
}
