import SwiftUI
import WebKit

struct ContentView: View {
    @State private var query = ""
    @State private var response = ""
    @State private var webView: WKWebView?

    var body: some View {
        VStack {
            Text("Digital Assistant")
                .font(.title)
                .padding()

            TextField("Ask me something", text: $query, onCommit: {
                respondToQuery()
            })
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.webSearch) // Enable return key for searching

            Button("Ask") {
                respondToQuery()
            }
            .padding()

            if let webView = webView {
                WebView(webView: webView)
                    .frame(minHeight: 300, maxHeight: .infinity) // Adjust height of web view
                    .padding()
            }

            Spacer()
        }
    }

    func respondToQuery() {
        // Simple predefined responses based on the query
        switch query.lowercased() {
        case "hello", "hi":
            response = "Hello! How can I help you?"
        case "how are you", "how are you?":
            response = "I'm just a digital assistant, but thanks for asking!"
        case "who are you", "what are you":
            response = "I'm a simple digital assistant built with SwiftUI."
        case "goodbye", "bye":
            response = "Goodbye! Have a great day!"
        default:
            searchWeb()
        }
    }

    func searchWeb() {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://www.google.com/search?q=\(encodedQuery)")
        else { return }

        let webView = WKWebView()
        self.webView = webView

        let request = URLRequest(url: url)
        webView.load(request)

        response = "Searching the web for '\(query)'..."
    }
}

struct WebView: UIViewRepresentable {
    let webView: WKWebView

    func makeUIView(context: Context) -> WKWebView {
        webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
