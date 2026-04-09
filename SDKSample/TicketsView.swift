import SwiftUI
import synkroniqSDK

struct TicketsView: View {
    @State private var ticketTitle = "Water leakage in basement"
    @State private var ticketDescription = "Water leakage found near corridor B2, needs urgent attention"

    @State private var listResponse = ""
    @State private var listLoading = false

    @State private var createResponse = ""
    @State private var createLoading = false

    @State private var statesResponse = ""
    @State private var statesLoading = false

    let requestBody = """
    {
        "uid": 20,
        "email": "fahim@gmail.com",
        "firstname": "fahim",
        "lastname": "ashhab",
        "mobile": "01556839245",
        "designation": "Supervisor"
    }
    """


    let requestBodyTicketCreate = """
    {
        "uid": 20,
        "email": "fahim@gmail.com",
        "firstname": "fahim",
        "lastname": "ashhab",
        "mobile": "01556839245",
        "designation": "Supervisor",
        "body": "Test ticket body",
        "service_category_id": 1,
        "attachments": [],
        "title": "Test Ticket"
    }
    """


    let requestBodyGetTicketArticles = """
    {
        "uid": 20,
        "email": "fahim@gmail.com",
        "firstname": "fahim",
        "lastname": "ashhab",
        "mobile": "01556839245",
        "designation": "Supervisor",
        "ticket_id": 108,
        "page": 1,
        "limit": 50
    }
    """

    var body: some View {
        NavigationView {
            List {
                // MARK: getTickets
                Section {
                    Button {
                        listLoading = true
                        listResponse = ""
                        SynkroniqSDK.shared.getTickets(requestBody: requestBody) { result in
                            listLoading = false
                            switch result {
                            case .success(let json): listResponse = json
                            case .failure(let error): listResponse = error.localizedDescription
                            }
                        }
                    } label: {
                        if listLoading {
                            HStack(spacing: 6) {
                                ProgressView().scaleEffect(0.8)
                                Text("Loading…")
                            }
                        } else {
                            Text("Call")
                        }
                    }
                    .disabled(listLoading)
                    if !listResponse.isEmpty { ResponseBlock(text: listResponse) }
                } header: {
                    Text("getTickets").font(.system(.footnote, design: .monospaced))
                }

                // MARK: createTicket
                Section {

                    Button {
                        createLoading = true
                        createResponse = ""

                        SynkroniqSDK.shared.createTicket(requestBody: requestBodyTicketCreate) { result in
                            createLoading = false
                            switch result {
                            case .success(let json): createResponse = json
                            case .failure(let error): createResponse = error.localizedDescription
                            }
                        }
                    } label: {
                        if createLoading {
                            HStack(spacing: 6) {
                                ProgressView().scaleEffect(0.8)
                                Text("Loading…")
                            }
                        } else {
                            Text("Call")
                        }
                    }
                    .disabled(createLoading)
                    if !createResponse.isEmpty { ResponseBlock(text: createResponse) }
                } header: {
                    Text("createTicket").font(.system(.footnote, design: .monospaced))
                }

                // MARK: getTicketStates
                Section {
                    Button {
                        statesLoading = true
                        statesResponse = ""
                        SynkroniqSDK.shared.getTicketStates(requestBody: requestBodyGetTicketArticles) { result in
                            statesLoading = false
                            switch result {
                            case .success(let json): statesResponse = json
                            case .failure(let error): statesResponse = error.localizedDescription
                            }
                        }
                    } label: {
                        if statesLoading {
                            HStack(spacing: 6) {
                                ProgressView().scaleEffect(0.8)
                                Text("Loading…")
                            }
                        } else {
                            Text("Call")
                        }
                    }
                    .disabled(statesLoading)
                    if !statesResponse.isEmpty { ResponseBlock(text: statesResponse) }
                } header: {
                    Text("getTicketStates").font(.system(.footnote, design: .monospaced))
                }
            }
            .navigationTitle("Tickets")
        }
    }
}
