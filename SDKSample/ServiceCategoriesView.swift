import SwiftUI
import synkroniqSDK

struct ServiceCategoriesView: View {
    @State private var categoryId = "1"
    @State private var searchQuery = "plumbing"

    @State private var listResponse = ""
    @State private var listLoading = false

    @State private var byIdResponse = ""
    @State private var byIdLoading = false

    @State private var searchResponse = ""
    @State private var searchLoading = false

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

    var body: some View {
        NavigationView {
            List {
                // MARK: getServiceCategories
                Section {
                    Button {
                        listLoading = true
                        listResponse = ""
                        SynkroniqSDK.shared.getServiceCategories(requestBody: requestBody) { result in
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
                    Text("getServiceCategories").font(.system(.footnote, design: .monospaced))
                }

                // MARK: getServiceCategoryById
                Section {

                    Button {
                        byIdLoading = true
                        byIdResponse = ""
                        SynkroniqSDK.shared.getServiceCategoryById(
                            categoryId: "1",
                            requestBody: requestBody
                        ) { result in
                            byIdLoading = false
                            switch result {
                            case .success(let json): byIdResponse = json
                            case .failure(let error): byIdResponse = error.localizedDescription
                            }
                        }
                    } label: {
                        if byIdLoading {
                            HStack(spacing: 6) {
                                ProgressView().scaleEffect(0.8)
                                Text("Loading…")
                            }
                        } else {
                            Text("Call")
                        }
                    }
                    .disabled(byIdLoading)
                    if !byIdResponse.isEmpty { ResponseBlock(text: byIdResponse) }
                } header: {
                    Text("getServiceCategoryById").font(.system(.footnote, design: .monospaced))
                }

                // MARK: searchServiceCategories
                Section {
                    TextField("query", text: $searchQuery)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    Button {
                        searchLoading = true
                        searchResponse = ""
                        let body = "{\"query\":\"\(searchQuery)\"}"
                        SynkroniqSDK.shared.searchServiceCategories(requestBody: requestBody) { result in
                            searchLoading = false
                            switch result {
                            case .success(let json): searchResponse = json
                            case .failure(let error): searchResponse = error.localizedDescription
                            }
                        }
                    } label: {
                        if searchLoading {
                            HStack(spacing: 6) {
                                ProgressView().scaleEffect(0.8)
                                Text("Loading…")
                            }
                        } else {
                            Text("Call")
                        }
                    }
                    .disabled(searchLoading)
                    if !searchResponse.isEmpty { ResponseBlock(text: searchResponse) }
                } header: {
                    Text("searchServiceCategories").font(.system(.footnote, design: .monospaced))
                }
            }
            .navigationTitle("Service Categories")
        }
    }
}
