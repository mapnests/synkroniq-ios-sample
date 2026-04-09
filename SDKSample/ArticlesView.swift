import SwiftUI
import synkroniqSDK

struct ArticlesView: View {
    @State private var articlesTicketId = "1"
    @State private var addTicketId = "1"
    @State private var addBody = "Technician dispatched to resolve the issue"

    @State private var getResponse = ""
    @State private var getLoading = false

    @State private var addResponse = ""
    @State private var addLoading = false


    let requestBodyGetTicketStates = """
    {
        "uid": 20,
        "email": "fahim@gmail.com",
        "firstname": "fahim",
        "lastname": "ashhab",
        "mobile": "01556839245",
        "designation": "Supervisor"
    }
    """


    let requestBodyCreateTicket = """
    {
        "uid": 20,
        "email": "fahim@gmail.com",
        "firstname": "fahim",
        "lastname": "ashhab",
        "mobile": "01556839245",
        "designation": "Supervisor",
        "ticket_id": 1,
        "body": "Test article body",
        "attachments": []
    }
    """


    var body: some View {
        NavigationView {
            List {
                // MARK: getTicketArticles
                Section {
                    Button {
                        getLoading = true
                        getResponse = ""
                        let body = requestBodyGetTicketStates
                        SynkroniqSDK.shared.getTicketStates(requestBody: body) { result in
                            getLoading = false
                            switch result {
                            case .success(let json): getResponse = json
                            case .failure(let error): getResponse = error.localizedDescription
                            }
                        }
                    } label: {
                        if getLoading {
                            HStack(spacing: 6) {
                                ProgressView().scaleEffect(0.8)
                                Text("Loading…")
                            }
                        } else {
                            Text("Call")
                        }
                    }
                    .disabled(getLoading)
                    if !getResponse.isEmpty { ResponseBlock(text: getResponse) }
                } header: {
                    Text("getTicketStates").font(.system(.footnote, design: .monospaced))
                }

                // MARK: addTicketArticle
                Section {
                    Button {
                        addLoading = true
                        addResponse = ""
                        let body = requestBodyCreateTicket
                        SynkroniqSDK.shared.addTicketArticle(requestBody: body) { result in
                            addLoading = false
                            switch result {
                            case .success(let json): addResponse = json
                            case .failure(let error): addResponse = error.localizedDescription
                            }
                        }
                    } label: {
                        if addLoading {
                            HStack(spacing: 6) {
                                ProgressView().scaleEffect(0.8)
                                Text("Loading…")
                            }
                        } else {
                            Text("Call")
                        }
                    }
                    .disabled(addLoading)
                    if !addResponse.isEmpty { ResponseBlock(text: addResponse) }
                } header: {
                    Text("addTicketArticle").font(.system(.footnote, design: .monospaced))
                }
            }
            .navigationTitle("Ticket Articles")
        }
    }
}
