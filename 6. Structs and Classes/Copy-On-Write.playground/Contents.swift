import Foundation

struct HTTPRequest {
  fileprivate class Storage {
    var path: String
    var headers: [String: String]
    init(path: String, headers: [String: String]) {
      self.path = path
      self.headers = headers
    }
  }
  
  private var storage: Storage
  
  init(path: String, headers: [String: String]) {
    storage = Storage(path: path, headers: headers)
  }
}

extension HTTPRequest {
  var path: String {
    get { storage.path }
    set {
      storageForWriting.path = newValue
    }
  }
  
  var headers: [String: String] {
    get { storage.headers }
    set {
      storageForWriting.headers = newValue
    }
  }
}

extension HTTPRequest.Storage {
  func copy() -> HTTPRequest.Storage {
    print("Making a copy...")
    return HTTPRequest.Storage(path: path, headers: headers)
  }
}

extension HTTPRequest {
  private var storageForWriting: HTTPRequest.Storage {
    mutating get {
      if !isKnownUniquelyReferenced(&storage) {
        self.storage = storage.copy()
      }
      return storage
    }
  }
}
