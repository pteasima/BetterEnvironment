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
}

public extension View {
  func environment<Key: EnvironmentKey>(key: Key.Type, value: Key.Value) -> some View {
    self
      .environment(\.[key: Tagged<Key, Unit>(rawValue: Unit())], value)
  }
}
