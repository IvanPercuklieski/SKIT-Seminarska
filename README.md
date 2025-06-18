
#  Petstore API Test Suite – Karate Framework

> Comprehensive automated API test suite for [Swagger Petstore](https://petstore.swagger.io/v2), written using Karate Framework. 
> Covers CRUD operations, validation rules, status code handling, and error conditions across all key endpoints.

##  Project Structure
```

src/test/
├── java/
│   ├── com.petstore/
│   │   ├── AllTests.java          # Runs all Karate feature tests
│   │   ├── PetTests.java          # Runs pet-related features
│   │   ├── StoreTests.java        # Runs store-related features
│   │   └── UserTests.java         # Runs user-related features
│
│   └── karate/tests/
│       ├── pet/
│       │   ├── deletePet.feature
│       │   ├── getPet.feature
│       │   ├── getPetId.feature
│       │   ├── postPet.feature
│       │   ├── postPetImage.feature
│       │   ├── postPetUpdate.feature
│       │   └── putPet.feature
│
│       ├── store/
│       │   ├── common.feature
│       │   ├── delete_order.feature
│       │   ├── find_order_by_id.feature
│       │   ├── get_inventory.feature
│       │   └── place_order.feature
│
│       ├── user/
│       │   ├── common-user.feature
│       │   ├── create-user.feature
│       │   ├── create-users-with-array.feature
│       │   ├── create-users-with-list.feature
│       │   ├── delete-user-by-username.feature
│       │   ├── get-user-by-username.feature
│       │   ├── login-user.feature
│       │   ├── logout-user.feature
│       │   └── update-user-by-username.feature
│
│   └── karate-config.js          # Global Karate config 
│
├── resources/
│   └── images/
│       └── dog.jpg               # Sample image for upload tests

```


## ✅ What’s Covered

### 🐾 **Pet Endpoint**

* **`POST /pet`** – Create pets, validation, unknown fields, duplicate IDs
* **`GET /pet/{id}`** – Valid, invalid, string, null, empty, decimal IDs
* **`GET /pet/findByStatus`** – Valid, empty, null, malformed and special-char status values
* **`PUT /pet`** – Full update logic, including missing fields, invalid types
* **`POST /pet/{id}`** – Form-based update logic, missing fields, invalid IDs
* **`DELETE /pet/{id}`** – Valid deletion, idempotency, invalid/missing API keys, edge IDs
* **`POST /pet/{id}/uploadImage`** – Valid uploads, missing files, metadata issues, wrong media types

---

### 🏬 **Store Endpoint**

* **`POST /store/order`** – Create order, validation, unknown fields, duplicate IDs
* **`GET /store/order/{orderId}`** – Valid, invalid, string, null, empty, decimal IDs
* **`DELETE /store/order/{orderId}`** – Valid deletion, idempotency, invalid/missing API keys, edge IDs
* **`GET /store/inventory`** – Inventory fetch, empty results, unauthorized access, schema validation

---

### 👤 **User Endpoint**

* **`POST /user`** – Create user, validation, unknown fields, duplicate usernames
* **`POST /user/createWithArray`** – Valid array, empty array, invalid user objects, duplicates
* **`POST /user/createWithList`** – Valid list, partial data, invalid types, list with errors
* **`GET /user/{username}`** – Valid, invalid, string, null, empty, special-char usernames
* **`PUT /user/{username}`** – Full update logic, missing fields, invalid types, non-existent user
* **`DELETE /user/{username}`** – Valid deletion, idempotency, invalid/missing usernames
* **`GET /user/login`** – Valid credentials, invalid login, missing/empty username or password
* **`GET /user/logout`** – Valid logout, multiple logouts, logout without login

---

##  How to Run

### Prerequisites
```
- Java 8 or higher
- Maven or Gradle
- Karate (via Maven dependency or CLI)
```
###  Run All Tests via Maven

```
bash
mvn test
```

> Or, run individual feature files via IntelliJ IDEA / VS Code Karate plugin.
> Run the AllTests.java, PetTests.java, StoreTests.java or UserTests.java

##  AuthorS

**Verica Chochorovska** │ **Bojana Andonova** │ **Ivan Perchuklieski** │
Karate API Test Automation
