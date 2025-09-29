# API Separation Documentation

## Complete Separation Between Web and Mobile APIs

This document explains how the UG Bills backend now maintains complete separation between the PHP web frontend and Flutter mobile app APIs.

## Backend Structure

### 🌐 Web Frontend (PHP)
**Routes**: `routes/main.php`
```
/login              -> Web login page (HTML)
/register           -> Web registration page (HTML) 
/dashboard/*        -> Web dashboard (HTML)
/password-reset     -> Web password reset (HTML)
```

**Controllers**: Regular PHP controllers returning HTML views
**Authentication**: Session-based (cookies)
**Views**: `app/views/` directory (HTML templates)
**Users**: Web users via browser

### 📱 Mobile API (Flutter)
**Routes**: `routes/mobile-api.php`
```
/api/mobile/v1/auth/login        -> Mobile login (JSON)
/api/mobile/v1/auth/register     -> Mobile registration (JSON)
/api/mobile/v1/me               -> Mobile user info (JSON)
/api/mobile/v1/*                -> All mobile endpoints (JSON)
```

**Controllers**: `app/Controllers/Api/Auth/MobileAuthController.php`
**Authentication**: JWT token-based
**Response Format**: JSON only
**Users**: Mobile app users

## Key Differences

### 1. **Authentication Systems**
- **Web**: Uses PHP sessions and cookies
- **Mobile**: Uses JWT tokens with `token_type: 'mobile_app'`

### 2. **Response Formats**
- **Web**: Returns HTML views and redirects
- **Mobile**: Returns structured JSON responses

### 3. **Routes**
- **Web**: `/login`, `/dashboard/*`
- **Mobile**: `/api/mobile/v1/*`

### 4. **Middlewares**
- **Web**: Uses existing web authentication middleware
- **Mobile**: Uses `MobileAuthMiddleware` for JWT validation

### 5. **Controllers**
- **Web**: Uses existing controllers (unchanged)
- **Mobile**: Uses `MobileAuthController` (separate)

## Benefits of This Separation

✅ **Zero Impact on Web Frontend**: All existing web functionality remains unchanged
✅ **Mobile-Specific Features**: Can add mobile-only features without affecting web
✅ **Different Authentication**: Web sessions vs JWT tokens
✅ **API Versioning**: Mobile API can be versioned independently 
✅ **Security**: Different security models for different platforms
✅ **Maintenance**: Easier to maintain and debug separately

## Migration Strategy

### Phase 1: ✅ Complete Separation
- Created separate mobile API routes
- Created mobile-specific controllers
- Created mobile-specific middleware
- Created mobile-specific endpoints

### Phase 2: Update Flutter App
- Update Flutter app to use `/api/mobile/v1/*` endpoints
- Use mobile-specific authentication flow
- Handle mobile-specific response formats

### Phase 3: Legacy Support (Optional)
- Keep old `/api/v1/*` routes for backward compatibility
- Gradually migrate to new mobile endpoints
- Remove legacy routes when fully migrated

## Example Usage

### Web Login (Unchanged)
```
POST /login
Content-Type: application/x-www-form-urlencoded

Response: Redirect to /dashboard or error page
```

### Mobile Login (New)
```
POST /api/mobile/v1/auth/login
Content-Type: application/json
{
  "email": "user@example.com",
  "password": "password123"
}

Response:
{
  "success": true,
  "data": {
    "access_key": "jwt_token",
    "user": {...},
    "token_type": "mobile_app"
  }
}
```

## Testing Both Systems

1. **Test Web Frontend**: Visit the website normally - everything should work as before
2. **Test Mobile API**: Use the Flutter app with new endpoints - should work with JWT tokens

## Conclusion

This separation ensures:
- 🛡️ **Web frontend is completely safe** - no changes to existing functionality
- 📱 **Mobile app has dedicated API** - optimized for mobile usage
- 🔒 **Different security models** - appropriate for each platform
- 🚀 **Independent scaling** - can optimize each API separately
- 🛠️ **Easy maintenance** - clear separation of concerns

Both systems can now operate independently without any conflicts!