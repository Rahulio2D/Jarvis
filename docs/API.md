# People API Documentation

This document describes the People API endpoints for the Jarvis application.

## Base URL

All API endpoints are relative to the application root.

## Authentication

Currently, no authentication is required for API endpoints.

## Endpoints

### Get Person by UID

Retrieves a specific person by their unique UID.

**Endpoint:** `GET /people/:uid`

**Parameters:**
- `uid` (string, required) - The unique identifier of the person

**Response:**

#### Success (200 OK)
```json
{
  "id": 1,
  "uid": "3af22ef6-74cf-4c21-9582-fbbc6d5c6b6e",
  "name": "John Doe",
  "email": "john@example.com",
  "phone_number": "+1234567890",
  "date_of_birth": "1990-01-01",
  "relation": "Friend"
}
```

#### Not Found (404)
```json
{
  "error": "Person not found"
}
```

**Example Usage:**

```bash
# Get person by UID
curl -X GET "http://localhost:3000/people/3af22ef6-74cf-4c21-9582-fbbc6d5c6b6e"

# Response for existing person
{
  "id": 1,
  "uid": "3af22ef6-74cf-4c21-9582-fbbc6d5c6b6e",
  "name": "John Doe",
  "email": "john@example.com",
  "phone_number": null,
  "date_of_birth": null,
  "relation": "Friend"
}

# Response for non-existent person
{
  "error": "Person not found"
}
```

## Data Model

### Person Object

| Field | Type | Description | Required |
|-------|------|-------------|----------|
| `id` | integer | Database ID | Yes |
| `uid` | string | Unique identifier (UUID) | Yes |
| `name` | string | Person's full name | Yes |
| `email` | string | Email address | No* |
| `phone_number` | string | Phone number | No* |
| `date_of_birth` | date | Date of birth | No |
| `relation` | string | Relationship type | Yes |

*At least one of `email` or `phone_number` must be provided.

### Valid Relation Values

- Friend
- Mother
- Father
- Sister
- Brother
- Son
- Daughter
- Wife
- Uncle
- Aunt
- Colleague
- Other

## Error Handling

The API uses standard HTTP status codes:

- `200 OK` - Request successful
- `404 Not Found` - Person not found
- `500 Internal Server Error` - Server error

Error responses include an `error` field with a descriptive message.

## Rate Limiting

Currently, no rate limiting is implemented.

## Versioning

This is version 1 of the API. Future versions will be indicated in the URL path.

## Testing

You can test the API using:

```bash
# Start the server
make start

# Test with curl
curl -X GET "http://localhost:3000/people/YOUR_UID_HERE"
```

## Implementation Details

### Architecture

The API follows a clean architecture pattern:

1. **Controller** (`PeopleController`) - Handles HTTP requests/responses
2. **Service** (`PeopleService`) - Contains business logic
3. **Serializer** (`PersonSerializer`) - Formats JSON responses
4. **Model** (`Person`) - Data persistence and validations

### Code Structure

```
app/
├── controllers/
│   └── people_controller.rb      # HTTP request handling
├── services/
│   └── people_service.rb         # Business logic
├── serializers/
│   └── person_serializer.rb      # JSON formatting
└── models/
    └── person.rb                 # Data model
```

### Testing

Comprehensive test coverage includes:

- **Request specs** - HTTP endpoint testing
- **Service specs** - Business logic testing
- **Serializer specs** - JSON formatting testing
- **Model specs** - Data validation testing

Run tests with:
```bash
make test
``` 