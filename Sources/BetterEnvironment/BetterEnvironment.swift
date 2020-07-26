import SwiftUI

struct Unit: Hashable { }
// this is https://github.com/pointfreeco/swift-tagged but I chose not to depend on it.
struct Tagged<Tag, RawValue> {
  var rawValue: RawValue
}
extension Tagged: Equatable where RawValue: Equatable {}
extension Tagged: Hashable where RawValue: Hashable {}

extension EnvironmentValues {
  subscript<Key: EnvironmentKey>(key key: Tagged<Key, Unit>) -> Key.Value {
    get { self[Key.self] }
    set { self[Key.self] = newValue }
  }
}

public extension Environment {
  init<Key: EnvironmentKey>(key: Key.Type) where Key.Value == Value {
    self.init(\.[key: Tagged<Key, Unit>(rawValue: Unit())])
  }
  
  init<Key: EnvironmentKey>(key: Key.Type, selection: WritableKeyPath<Key.Value, Value>) {
    self.init((\EnvironmentValues.[key: Tagged<Key, Unit>(rawValue: Unit())]).appending(path: selection))
  }
}

public extension View {
  func environment<Key: EnvironmentKey>(key: Key.Type, value: Key.Value) -> some View {
    self
      .environment(\.[key: Tagged<Key, Unit>(rawValue: Unit())], value)
  }
  func transformEnvironment<Key: EnvironmentKey>(key: Key.Type, transform: @escaping (inout Key.Value) -> Void) -> some View {
    self
      .transformEnvironment(\.[key: Tagged<Key, Unit>(rawValue: Unit())], transform: transform)
  }
}
