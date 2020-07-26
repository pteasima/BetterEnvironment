# BetterEnvironment

SwiftUI sugar.

Lets you subscript by the key type, like this:

```
struct ContentView: View {
  @Environment(key: K.self) var profit
    var body: some View {
        Text("Hello, world!")
          .onTapGesture { profit() }
    }
}
```

without the need to define a proxy property, like this:

```
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

Works with any EvironmentKey and is purely additive.
