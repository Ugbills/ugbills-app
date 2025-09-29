# UG Bills Authentication System

This document outlines the authentication system implemented for the UG Bills application.

## Backend API Endpoints

### Login
- **URL**: `POST /api/v1/auth/login`
- **Body**:
```json
{
  "email": "user@example.com",
  "password": "password123",
  "device_name": "iPhone",
  "device_id": "device_token_here",
  "operating_system": "iOS",
  "latitude": "0.0",
  "longitude": "0.0"
}
```
- **Response**:
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "access_key": "jwt_token_here",
    "user_id": "user_id",
    "user": {
      "id": "user_id",
      "email": "user@example.com",
      "full_name": "User Name",
      "phone_number": "+1234567890",
      "username": "username"
    },
    "expires_at": "2024-01-01 12:00:00"
  }
}
```

### PIN Login
- **URL**: `POST /api/v1/auth/login/pin`
- **Body**:
```json
{
  "pin": "1234",
  "user_id": "user_id_here"
}
```

### Register
- **URL**: `POST /api/v1/auth/register`
- **Body**:
```json
{
  "username": "johndoe",
  "email": "john@example.com",
  "phone": "+1234567890",
  "fullname": "John Doe",
  "password1": "password123",
  "password2": "password123",
  "refname": "referrer_username"
}
```

### Get User Info (Authenticated)
- **URL**: `GET /api/v1/me`
- **Headers**: `ZEEL-SECURE-KEY: jwt_token_here`
- **Response**:
```json
{
  "success": true,
  "message": "User information retrieved successfully",
  "data": {
    "id": "user_id",
    "email": "user@example.com",
    "username": "johndoe",
    "full_name": "John Doe",
    "phone_number": "+1234567890",
    "firstname": "John",
    "lastname": "Doe",
    "created_at": "2024-01-01 12:00:00",
    "updated_at": "2024-01-01 12:00:00",
    "pin": "set"
  }
}
```

## Flutter Implementation

### Login Screen
- Located at: `lib/screens/auth/login_screen.dart`
- Uses `AuthController` to handle login
- Supports form validation
- Shows loading states

### Create Account Screen
- Located at: `lib/screens/auth/create/create_account_screen.dart`
- Password strength validation
- Form validation
- Multi-step registration process

### Auth Repository
- Located at: `lib/repository/auth_repository.dart`
- Handles API calls
- Token storage and management
- User data storage
- Error handling with user feedback

### Auth Controller
- Located at: `lib/controllers/auth/auth_controller.dart`
- Uses Riverpod for state management
- Handles authentication logic

## Key Features Implemented

1. **Email/Password Login**: Standard authentication with email and password
2. **PIN Login**: Quick login using 4-digit PIN for returning users
3. **User Registration**: Complete user registration with validation
4. **JWT Token Management**: Secure token-based authentication
5. **Automatic Token Refresh**: Handled by the authentication middleware
6. **Form Validation**: Client-side validation for all forms
7. **Loading States**: Proper loading indicators during API calls
8. **Error Handling**: User-friendly error messages
9. **Session Management**: Auto-logout on token expiration
10. **Device Tracking**: Track device information for security

## Security Features

- Password hashing using BCrypt
- JWT tokens with expiration
- Request validation and sanitization
- Authentication middleware for protected routes
- Device and location tracking for login attempts

## Usage Instructions

1. **New Users**: Use the "Create Account" button on the main screen
2. **Existing Users**: Use the "Log in" button
3. **Quick Access**: Use PIN login for faster access (after initial setup)
4. **Password Recovery**: Use "Forgot Password" link on login screen

The authentication system is now fully functional and ready for testing!