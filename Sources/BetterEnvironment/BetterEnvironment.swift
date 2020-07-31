import SwiftUI

struct HashableType<T>: Hashable {}

extension EnvironmentValues {
  subscript<Key: EnvironmentKey>(key key: HashableType<Key>) -> Key.Value {
    get { self[Key.self] }
    set { self[Key.self] = newValue }
  }
}

public extension Environment {
  init<Key: EnvironmentKey>(key: Key.Type) where Key.Value == Value {
    self.init(\.[key: HashableType<Key>()])
  }
  
  init<Key: EnvironmentKey>(key: Key.Type, selection: WritableKeyPath<Key.Value, Value>) {
    self.init((\EnvironmentValues.[key: HashableType<Key>()]).appending(path: selection))
  }
}

public extension View {
  func environment<Key: EnvironmentKey>(key: Key.Type, value: Key.Value) -> some View {
    self
      .environment(\.[key: HashableType<Key>()], value)
  }
  func transformEnvironment<Key: EnvironmentKey>(key: Key.Type, transform: @escaping (inout Key.Value) -> Void) -> some View {
    self
      .transformEnvironment(\.[key: HashableType<Key>()], transform: transform)
  }
}
