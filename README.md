
#  Petstore API Test Suite – Karate Framework

> Comprehensive automated API test suite for [Swagger Petstore](https://petstore.swagger.io/v2), written using Karate Framework. 
> Covers CRUD operations, validation rules, status code handling, and error conditions across all key endpoints.

##  Project Structure

```bash
├── src/
│   └── test/
│       ├── java/
│       │   ├── com.petstore/
│       │   │   ├── AllTests.java
│       │   │   ├── PetTests.java
│       │   │   ├── StoreTests.java
│       │   │   └── UserTests.java
│       │   │ 
│       │   └── karate/tests/pet/
│       │       ├── deletePet.feature
│       │       ├── getPet.feature
│       │       ├── getPetId.feature
│       │       ├── postPet.feature
│       │       ├── postPetImage.feature
│       │       ├── postPetUpdate.feature
│       │       └── putPet.feature
│       │    └── karate-config.js
│       │
│       └── resources/
│           └── images/
│               └── dog.jpg
│
├── README.md



```

##  What’s Covered

- **`POST /pet`** – Create pets, validation, unknown fields, duplicate IDs
- **`GET /pet/{id}`** – Valid, invalid, string, null, empty, decimal IDs
- **`GET /pet/findByStatus`** – Valid, empty, null, malformed and special-char status values
- **`PUT /pet`** – Full update logic, including missing fields, invalid types
- **`POST /pet/{id}`** – Form-based update logic, missing fields, invalid IDs
- **`DELETE /pet/{id}`** – Valid deletion, idempotency, invalid/missing API keys, edge IDs
- **`POST /pet/{id}/uploadImage`** – Valid uploads, missing files, metadata issues, wrong media types

##  How to Run

### Prerequisites

- Java 8 or higher
- Maven or Gradle
- Karate (via Maven dependency or CLI)

###  Run All Tests via Maven

```bash
mvn test
```

> Or, run individual feature files via IntelliJ IDEA / VS Code Karate plugin.
> Run the AllTests.java, PetTests.java, StoreTests.java or UserTests.java

##  Key Highlights

-  **Logical status codes enforced**
  - Example: `401 Unauthorized` instead of `405` for invalid/missing API keys
  - Proper use of `400`, `404`, `415`, `500` depending on client/server fault
-  **Robust validation**
  - Tests for malformed IDs, nulls, empty strings, extra fields, bad types
-  **Idempotency checks**
  - Ensures consistent behavior when operations are repeated (e.g., double delete)
-  **File upload handling**
  - Covers multipart, missing metadata, unsupported content types


##  Author

**Verica Chochorovska**  
Karate API Test Automation
