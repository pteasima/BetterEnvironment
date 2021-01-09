# BetterEnvironment

## [DEPRECATED], use https://twitter.com/pteasima/status/1347927033100251139 instead. Its so minimal it doesn't warrant a dependency.

SwiftUI µsugar.

Lets you subscript by the key type, like this:

```swift
struct ContentView: View {
  @Environment(key: K.self) var profit
    var body: some View {
        Text("Hello, world!")
          .onTapGesture { profit() }
    }
}
```

without the need to define a proxy property, like this:

```swift
extension EnvironmentValues {
  var k: K.Value {
    get { self[K.self] }
    set { self[K.self] = newValue }
  }
}
struct ContentView: View {
  @Environment(\.k) var lessProfit
    var body: some View {
        Text("Hello, world!")
          .onTapGesture { lessProfit() }
    }
}
```

Works with any `EnvironmentKey` and is purely additive.
