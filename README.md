# synkroniqSDK

![Version](https://img.shields.io/badge/version-1.0.0--beta.1-blue)
![Platform](https://img.shields.io/badge/platform-iOS%2015%2B-lightgrey)
![Swift](https://img.shields.io/badge/swift-5.7%2B-orange)
![License](https://img.shields.io/badge/license-Proprietary-red)

iOS SDK for integrating Synkroniq ticketing and service-category APIs into your app. All network calls run on a background thread; results are dispatched to the main thread via completion callbacks.

---

### v1.0.0-beta.1
- Initial beta release
- Service Categories: list, get by ID, search
- Tickets: list, create
- Ticket Articles: list, add
- Ticket States: list
- TLS 1.2 enforced via libcurl + OpenSSL xcframeworks

## Requirements

| Requirement | Minimum |
|---|---|
| iOS | 15.0 |
| Swift | 5.7 |
| Xcode | 14.0 |

---

## Installation

synkroniqSDK ships as a pre-built `.xcframework`. There is no SPM or CocoaPods support.

1. Obtain `synkroniqSDK.xcframework` from your distribution channel.
2. In Xcode, select your app target → **General** → **Frameworks, Libraries, and Embedded Content**.
3. Click **+** → **Add Other…** → **Add Files…** and choose `synkroniqSDK.xcframework`.
4. Set the embed option to **Embed & Sign**.
5. Import the module wherever needed:
   ```swift
   import synkroniqSDK
   ```

---

## Getting Started

Call `initialize` once, before any API method — typically in `AppDelegate.application(_:didFinishLaunchingWithOptions:)`:

```swift
import synkroniqSDK

SynkroniqSDK.shared.initialize(
    apiKey: "YOUR_API_KEY",
    platform: "ios",
    timeoutMs: 30000   // optional, default 30 000 ms
)
```

| Parameter | Type | Required | Description |
|---|---|---|---|
| `apiKey` | `String` | Yes | API key issued by Synkroniq |
| `platform` | `String` | Yes | Client platform identifier (e.g. `"ios"`) |
| `timeoutMs` | `Int` | No | Request timeout in milliseconds (default `30000`) |

---

## API Coverage

All methods are on `SynkroniqSDK.shared` and deliver their result via `(Result<String, Error>) -> Void`. On success the `String` is a raw JSON response from the server. On failure the error has domain `"synkroniqSDK"` and code `-1`.

### Common Request Body Fields

All 8 methods require the following user context fields in the JSON request body:

| Field | Type | Required | Description |
|---|---|---|---|
| `uid` | `Int` | Yes | User ID |
| `email` | `String` | Yes | User email address |
| `firstname` | `String` | Yes | User first name |
| `lastname` | `String` | Yes | User last name |
| `mobile` | `String` | Yes | User mobile number |
| `designation` | `String` | Yes | User designation/role |

---

### Service Categories

#### `getServiceCategories(requestBody:completion:)`

Fetches the full list of service categories.

**Endpoint:** `GET /api/sdk/v1/service_categories/`

**Signature:**
```swift
func getServiceCategories(
    requestBody: String,
    completion: @escaping (Result<String, Error>) -> Void
)
```

**Request Body Fields:**

| Field | Type | Required | Description |
|---|---|---|---|
| `uid` | `Int` | Yes | User ID |
| `email` | `String` | Yes | User email address |
| `firstname` | `String` | Yes | User first name |
| `lastname` | `String` | Yes | User last name |
| `mobile` | `String` | Yes | User mobile number |
| `designation` | `String` | Yes | User designation/role |

**Example:**
```swift
let body = """
{
    "uid": 20,
    "email": "user@example.com",
    "firstname": "John",
    "lastname": "Doe",
    "mobile": "01556839245",
    "designation": "Supervisor"
}
"""

SynkroniqSDK.shared.getServiceCategories(requestBody: body) { result in
    switch result {
    case .success(let json): print(json)
    case .failure(let error): print(error.localizedDescription)
    }
}
```

---

#### `getServiceCategoryById(categoryId:requestBody:completion:)`

Fetches a single service category by its ID.

**Endpoint:** `GET /api/sdk/v1/service_categories/{categoryId}`

**Signature:**
```swift
func getServiceCategoryById(
    categoryId: String,
    requestBody: String,
    completion: @escaping (Result<String, Error>) -> Void
)
```

**Request Body Fields:**

| Field | Type | Required | Description |
|---|---|---|---|
| `uid` | `Int` | Yes | User ID |
| `email` | `String` | Yes | User email address |
| `firstname` | `String` | Yes | User first name |
| `lastname` | `String` | Yes | User last name |
| `mobile` | `String` | Yes | User mobile number |
| `designation` | `String` | Yes | User designation/role |

**Example:**
```swift
let body = """
{
    "uid": 20,
    "email": "user@example.com",
    "firstname": "John",
    "lastname": "Doe",
    "mobile": "01556839245",
    "designation": "Supervisor"
}
"""

SynkroniqSDK.shared.getServiceCategoryById(
    categoryId: "1",
    requestBody: body
) { result in
    switch result {
    case .success(let json): print(json)
    case .failure(let error): print(error.localizedDescription)
    }
}
```

---

#### `searchServiceCategories(requestBody:completion:)`

Full-text search across service categories.

**Endpoint:** `GET /api/sdk/v1/service_categories/search`

**Signature:**
```swift
func searchServiceCategories(
    requestBody: String,
    completion: @escaping (Result<String, Error>) -> Void
)
```

**Request Body Fields:**

| Field | Type | Required | Description |
|---|---|---|---|
| `uid` | `Int` | Yes | User ID |
| `email` | `String` | Yes | User email address |
| `firstname` | `String` | Yes | User first name |
| `lastname` | `String` | Yes | User last name |
| `mobile` | `String` | Yes | User mobile number |
| `designation` | `String` | Yes | User designation/role |

**Example:**
```swift
let body = """
{
    "uid": 20,
    "email": "user@example.com",
    "firstname": "John",
    "lastname": "Doe",
    "mobile": "01556839245",
    "designation": "Supervisor"
}
"""

SynkroniqSDK.shared.searchServiceCategories(requestBody: body) { result in
    switch result {
    case .success(let json): print(json)
    case .failure(let error): print(error.localizedDescription)
    }
}
```

---

### Tickets

#### `getTickets(requestBody:completion:)`

Retrieves a list of tickets.

**Endpoint:** `GET /api/sdk/v1/tickets/`

**Signature:**
```swift
func getTickets(
    requestBody: String,
    completion: @escaping (Result<String, Error>) -> Void
)
```

**Request Body Fields:**

| Field | Type | Required | Description |
|---|---|---|---|
| `uid` | `Int` | Yes | User ID |
| `email` | `String` | Yes | User email address |
| `firstname` | `String` | Yes | User first name |
| `lastname` | `String` | Yes | User last name |
| `mobile` | `String` | Yes | User mobile number |
| `designation` | `String` | Yes | User designation/role |

**Example:**
```swift
let body = """
{
    "uid": 20,
    "email": "user@example.com",
    "firstname": "John",
    "lastname": "Doe",
    "mobile": "01556839245",
    "designation": "Supervisor"
}
"""

SynkroniqSDK.shared.getTickets(requestBody: body) { result in
    switch result {
    case .success(let json): print(json)
    case .failure(let error): print(error.localizedDescription)
    }
}
```

---

#### `createTicket(requestBody:completion:)`

Creates a new ticket.

**Endpoint:** `POST /api/sdk/v1/tickets/`

**Signature:**
```swift
func createTicket(
    requestBody: String,
    completion: @escaping (Result<String, Error>) -> Void
)
```

**Request Body Fields:**

| Field | Type | Required | Description |
|---|---|---|---|
| `uid` | `Int` | Yes | User ID |
| `email` | `String` | Yes | User email address |
| `firstname` | `String` | Yes | User first name |
| `lastname` | `String` | Yes | User last name |
| `mobile` | `String` | Yes | User mobile number |
| `designation` | `String` | Yes | User designation/role |
| `title` | `String` | Yes | Ticket title |
| `body` | `String` | Yes | Ticket description |
| `service_category_id` | `Int` | Yes | ID of the associated service category |
| `attachments` | `Array` | Yes | List of file attachments (can be empty) |

## Note: Create createTicket suppport custome field type like 

category |
| `customerField` | `String` | No |

**Example:**
```swift
let body = """
{
    "uid": 20,
    "email": "user@example.com",
    "firstname": "John",
    "lastname": "Doe",
    "mobile": "01556839245",
    "designation": "Supervisor",
    "title": "Water leakage in basement",
    "body": "Water leakage found near corridor B2",
    "service_category_id": 1,
    "attachments": [], 
    "customerField1": "customerFieldValue1",
    "customerField2": "customerFieldValue2",
}
"""

SynkroniqSDK.shared.createTicket(requestBody: body) { result in
    switch result {
    case .success(let json): print("Ticket created:", json)
    case .failure(let error): print(error.localizedDescription)
    }
}
```

---

### Ticket Articles

#### `getTicketArticles(requestBody:completion:)`

Retrieves articles associated with a ticket.

**Endpoint:** `GET /api/sdk/v1/ticket_articles`

**Signature:**
```swift
func getTicketArticles(
    requestBody: String,
    completion: @escaping (Result<String, Error>) -> Void
)
```

**Request Body Fields:**

| Field | Type | Required | Description |
|---|---|---|---|
| `uid` | `Int` | Yes | User ID |
| `email` | `String` | Yes | User email address |
| `firstname` | `String` | Yes | User first name |
| `lastname` | `String` | Yes | User last name |
| `mobile` | `String` | Yes | User mobile number |
| `designation` | `String` | Yes | User designation/role |
| `ticket_id` | `Int` | Yes | ID of the ticket to fetch articles for |
| `page` | `Int` | Yes | Page number for pagination |
| `limit` | `Int` | Yes | Number of results per page |

**Example:**
```swift
let body = """
{
    "uid": 20,
    "email": "user@example.com",
    "firstname": "John",
    "lastname": "Doe",
    "mobile": "01556839245",
    "designation": "Supervisor",
    "ticket_id": 108,
    "page": 1,
    "limit": 50
}
"""

SynkroniqSDK.shared.getTicketArticles(requestBody: body) { result in
    switch result {
    case .success(let json): print(json)
    case .failure(let error): print(error.localizedDescription)
    }
}
```

---

#### `addTicketArticle(requestBody:completion:)`

Adds an article (comment/note) to a ticket.

**Endpoint:** `POST /api/sdk/v1/ticket_articles/`

**Signature:**
```swift
func addTicketArticle(
    requestBody: String,
    completion: @escaping (Result<String, Error>) -> Void
)
```

**Request Body Fields:**

| Field | Type | Required | Description |
|---|---|---|---|
| `uid` | `Int` | Yes | User ID |
| `email` | `String` | Yes | User email address |
| `firstname` | `String` | Yes | User first name |
| `lastname` | `String` | Yes | User last name |
| `mobile` | `String` | Yes | User mobile number |
| `designation` | `String` | Yes | User designation/role |
| `ticket_id` | `Int` | Yes | ID of the ticket to add the article to |
| `body` | `String` | Yes | Content of the article/comment |
| `attachments` | `Array` | Yes | List of file attachments (can be empty) |

**Example:**
```swift
let body = """
{
    "uid": 20,
    "email": "user@example.com",
    "firstname": "John",
    "lastname": "Doe",
    "mobile": "01556839245",
    "designation": "Supervisor",
    "ticket_id": 1,
    "body": "Technician dispatched to resolve the issue",
    "attachments": []
}
"""

SynkroniqSDK.shared.addTicketArticle(requestBody: body) { result in
    switch result {
    case .success(let json): print("Article added:", json)
    case .failure(let error): print(error.localizedDescription)
    }
}
```

---

### Ticket States

#### `getTicketStates(requestBody:completion:)`

Retrieves all available ticket states.

**Endpoint:** `GET /api/sdk/v1/ticket_states/`

**Signature:**
```swift
func getTicketStates(
    requestBody: String,
    completion: @escaping (Result<String, Error>) -> Void
)
```

**Request Body Fields:**

| Field | Type | Required | Description |
|---|---|---|---|
| `uid` | `Int` | Yes | User ID |
| `email` | `String` | Yes | User email address |
| `firstname` | `String` | Yes | User first name |
| `lastname` | `String` | Yes | User last name |
| `mobile` | `String` | Yes | User mobile number |
| `designation` | `String` | Yes | User designation/role |

**Example:**
```swift
let body = """
{
    "uid": 20,
    "email": "user@example.com",
    "firstname": "John",
    "lastname": "Doe",
    "mobile": "01556839245",
    "designation": "Supervisor"
}
"""

SynkroniqSDK.shared.getTicketStates(requestBody: body) { result in
    switch result {
    case .success(let json): print(json)
    case .failure(let error): print(error.localizedDescription)
    }
}
```

---

## Error Handling

All failures arrive as an `NSError` with:

| Property | Value |
|---|---|
| `domain` | `"synkroniqSDK"` |
| `code` | `-1` |
| `localizedDescription` | Server error message or `"Unknown error"` |

```swift
let body = """
{
    "uid": 20,
    "email": "user@example.com",
    "firstname": "John",
    "lastname": "Doe",
    "mobile": "01556839245",
    "designation": "Supervisor"
}
"""

SynkroniqSDK.shared.getTickets(requestBody: body) { result in
    if case .failure(let error) = result {
        let nsError = error as NSError
        print("Domain:", nsError.domain)        // "synkroniqSDK"
        print("Code:", nsError.code)            // -1
        print("Message:", nsError.localizedDescription)
    }
}
```

