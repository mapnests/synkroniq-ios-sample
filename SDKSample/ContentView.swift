import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ServiceCategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "list.bullet")
                }

            TicketsView()
                .tabItem {
                    Label("Tickets", systemImage: "ticket")
                }

            ArticlesView()
                .tabItem {
                    Label("Articles", systemImage: "doc.text")
                }
        }
    }
}
