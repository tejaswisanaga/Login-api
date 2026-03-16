# Login API with JWT Authentication

A Spring Boot REST API that provides user authentication and registration functionality using JWT (JSON Web Tokens).

## Features

- User registration
- User login with JWT token generation
- Password encryption using BCrypt
- JWT-based authentication
- H2 in-memory database
- RESTful API endpoints

## Technologies Used

- Java 17
- Spring Boot 3.2.0
- Spring Security
- Spring Data JPA
- JWT (JSON Web Tokens)
- H2 Database
- Maven

## API Endpoints

### Authentication

#### Register User
```
POST /api/auth/register
Content-Type: application/json

{
    "username": "john_doe",
    "password": "password123",
    "email": "john@example.com"
}
```

#### Login User
```
POST /api/auth/login
Content-Type: application/json

{
    "username": "john_doe",
    "password": "password123"
}
```

**Response:**
```json
{
    "token": "eyJhbGciOiJIUzI1NiJ9...",
    "type": "Bearer",
    "id": 1,
    "username": "john_doe",
    "email": "john@example.com",
    "role": "USER"
}
```

#### Test Endpoint
```
GET /api/auth/test
```

## How to Run

1. Clone the repository or create the project structure
2. Navigate to the project directory
3. Run the application:
   ```bash
   mvn spring-boot:run
   ```
4. The API will be available at `http://localhost:8081`

## Production Deployment

#### Option 1: Using Deploy Script
```bash
# Run the deployment script
./deploy.bat
```

#### Option 2: Manual Build and Deploy
```bash
# Build the application
mvn clean package -DskipTests

# Run with production profile
java -jar target/login-api-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
```

#### Option 3: Docker Deployment (Coming Soon)
```bash
# Build Docker image
docker build -t login-api .

# Run container
docker run -p 8081:8081 login-api
```

## Database

### Development (H2)
The application uses H2 in-memory database. You can access the H2 console at:
```
http://localhost:8081/h2-console
```

**JDBC URL:** `jdbc:h2:mem:testdb`
**Username:** `sa`
**Password:** (leave blank)

### Production
For production, configure a persistent database in `application-prod.properties`:
- MySQL
- PostgreSQL
- Oracle

## API Access

### Local Network
```bash
# Access from other devices on same network
http://YOUR_LOCAL_IP:8081
```

### Public Access
To make your API publicly accessible:
1. **Deploy to cloud platform** (AWS, Azure, Google Cloud)
2. **Configure firewall** to allow port 8081
3. **Use domain name** instead of IP address

## Testing with curl

### Register a new user:
```bash
curl -X POST http://localhost:8081/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"testpass","email":"test@example.com"}'
```

### Login:
```bash
curl -X POST http://localhost:8081/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"testpass"}'
```

### Access protected endpoint (after login):
```bash
curl -X GET http://localhost:8081/api/auth/test \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## Configuration

The application configuration is in `src/main/resources/application.properties`:

- **Server Port:** 8081
- **Server Address:** 0.0.0.0 (accessible from all network interfaces)
- **JWT Secret:** Configured for production use
- **JWT Expiration:** 86400000ms (24 hours)

## Security Notes

- Passwords are encrypted using BCrypt
- JWT tokens are used for authentication
- CORS is enabled for all origins (configure appropriately for production)
- H2 console disabled in production

## Production Checklist

- [ ] Configure persistent database
- [ ] Update JWT secret with secure random key
- [ ] Configure CORS for specific domains
- [ ] Set up HTTPS/SSL certificates
- [ ] Configure firewall rules
- [ ] Set up monitoring and logging
- [ ] Deploy to cloud platform
- [ ] Configure domain and DNS
