# Vendaah Backend Guide

## Table of Contents
- [Introduction](#introduction)
- [Authentication and Authorization](#authentication-and-authorization)
  - [User Registration](#user-registration)
  - [User Login](#user-login)
  - [Password Reset](#password-reset)
  - [OAuth using Google](#OAuth-using-Google)
  - [JWT Authentication](#jwt-authentication)
  - [Role-Based Access Control (RBAC)](#role-based-access-control-rbac)
- [Vendor Management Endpoints](#Vendor-Management-Endpoints)
  - [Register Vendor](#Register-Vendor)
  - [Create Product Listing](#Create-Product-Listing)
  - [Get Vendor Analytics](#Get-Vendor-Analytics)
- [Customer Management Endpoints](#Customer-Management-Endpoints)
  - [Search Businesses](#Search-Businesses)
  - [Get Product Details](#Get-Product-Details)
  - [Submit Inquiry](#Submit-Inquiry)
- [Admin Endpoints](#Admin-Endpoints)
  - [Get System Health](#Get-System-Health)
  - [Manage User Account](#Manage-User-Account)
- [Error Responses](#Error-Responses)

## Introduction
Vendaah is a backend system designed to support a digital marketplace for small informal businesses. This guide outlines the key API endpoints and functionalities, including authentication, Vendor Management, Customer Management, user profile updates, reviews, and administrative functions.

## Authentication and Authorization
### User Registration
- **Endpoint**: `/api/auth/register/`
- **Method**: `POST`
- **Description**: Allows new users to register by providing their email, password, and other necessary details.
- **Payload**:
  ```json
  {
    "email": "user@example.com",
    "password": "securepassword",
    "first_name": "John",
    "last_name": "Doe",
    "age": 20,
    "gender": "Male",
    "phone_number": "123-456-7890",
    "address": "123 Street, City, Country",
    "date_of_birth": "2000-01-01"
  }

### User Login
  - **Endpoint**: `/api/auth/login/`
  - **Method**: `POST`
  - **Description**: Authenticates users by verifying their email and password.ir email, password, and other necessary details.
  - **Payload**:
    ```json
     {
      "email": "user@example.com",
      "password": "securepassword"
    }

### Email Verification
  - **Endpoint**: `/api/auth/verify-email/`
  - **Method**: `POST`
  - **Description**: Sends a verification email to the user after registration.
  - **Payload**:
    ```json
    {
      "email": "user@example.com"
    }
  

### Password Reset
  - **Endpoint**: `/api/auth/reset-password/`
  - **Method**: `POST`
  - **Description**: Allows users to reset their password by providing their email.
  - **Payload**:
    ```json
    {
      "email": "user@example.com"
    }

### OAuth using Google
  - **Endpoint**: `/api/auth/oauth/google/`
  - **Method**: `GET`
  - **Description**: `Redirects users to Google for OAuth authentication and retrieves user information.`
  - **Payload**:
    ```json
    {
      "client_id": "YOUR_CLIENT_ID.apps.googleusercontent.com",
      "client_secret": "YOUR_CLIENT_SECRET",
      "redirect_uris": [
        "YOUR_REDIRECT_URI"
      ],
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "userinfo_uri": "https://openidconnect.googleapis.com/v1/userinfo",
      "scope": "https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email",
      "response_type": "code"
    }

### JWT Authentication
  - **Endpoint**: `/api/auth/token/`
  - **Method**: `POST`
  - **Description**: Generates a JWT token for authenticated users.
  - **Payload**:
    ```json
    {
      "email": "user@example.com",
      "password": "securepassword"
    }
  - **Response**:
    ```json
    {
      "access": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...",
      "refresh": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9..."
    }

### Role-Based Access Control (RBAC)
  - **Description**: `Users are assigned roles (customer, Vendor, Admin) that determine their access levels and permissions within the system.`
  - **roles**:
      - **customer**: `View and star products.`
      - **Vendor**: `Manage products and view ratings.`
      - **Admin**:  `Can manage users, configure system settings, and access global analytics.`

## Vendor Management Endpoints
### Register Vendor
  - **Endpoint**: `/api/vendors/register`
  - **Method**: `POST`
  - **Description**: Register a new vendor account.
  - **Payload**:
    ```json
    {
      "businessName": "Fresh Groceries Ltd",
      "description": "Local grocery store specializing in organic produce",
      "email": "contact@freshgroceries.com",
      "password": "********",
      "phone": "+1234567890",
      "location": {
        "address": "123 Market Street",
        "city": "Springfield",
        "state": "IL",
        "postalCode": "62701",
        "coordinates": {
          "latitude": 39.78373,
          "longitude": -89.65063
        }
      },
      "businessHours": [
        {
          "day": "MONDAY",
          "open": "09:00",
          "close": "18:00"
        }
      ]
    }
  - **Response**: 
    ```json
    {
      "vendorId": "v-123xyz",
      "businessName": "Fresh Groceries Ltd",
      "createdAt": "2025-01-27T10:30:00Z",
      "status": "ACTIVE"
    }

### Create Product Listing
  - **Endpoint**: `/api/vendors/{vendorId}/products`
  - **Method**: `POST`
  - **Description**: Create a new product listing.
  - **Payload**:
    ```json
    {
    "name": "Organic Red Apples",
    "description": "Fresh organic apples from local farms",
    "category": "PRODUCE",
    "price": {
      "amount": 4.99,
      "currency": "USD",
      "unit": "per pound"
    },
    "inventory": {
      "quantity": 100,
      "threshold": 20
    },
    "images": [
      {
        "url": "https://storage.vendaah.com/products/apple1.jpg",
        "isPrimary": true
      }
    ],
    "attributes": {
      "organic": true,
      "origin": "Local Farm",
      "season": "Fall"
    }

### Get Vendor Analytics
  - **Endpoint**: `/api/vendors/{vendorId}/analytics
  - **Method**: ` GET`
  - **Description**: Retrieve vendor performance metrics.
  - **Query Parameters**:
    - **startDate**: `ISO date`
    - **endDate**: `ISO date.`
    - **metrics**:  `Array of requested metrics.`
    
  - **Payload**:
    ```json
    {
    "period": {
      "start": "2025-01-01T00:00:00Z",
      "end": "2025-01-27T23:59:59Z"
    },
    "metrics": {
      "views": 1250,
      "clicks": 380,
      "inquiries": 45,
      "conversionRate": 3.6,
      "demographics": {
        "ageGroups": {
          "18-24": 15,
          "25-34": 45,
          "35-44": 25,
          "45+": 15
        },
        "topLocations": [
          {
            "city": "Springfield",
            "percentage": 75
          }
        ]
      }
    }

## Customer Management Endpoints
### Search Businesses
  - **Endpoint**: `/api/search`
  - **Method**: `GET`
  - **Description**: Search for businesses based on various criteria.
  - **Query Parameters**:
    - **query**: `Search term`
    - **category**: `Business category.`
    - **radius**: `Search radius in km.`
    - **location**: `Geographic coordinates.`
    - **page**: `Page number.`
    - **limit**: `Results per page.`
  - **Payload**:
    ```json
    {
      "total": 150,
      "page": 1,
      "limit": 10,
      "results": [
        {
          "vendorId": "v-123xyz",
          "businessName": "Fresh Groceries Ltd",
          "category": "GROCERY",
          "rating": 4.5,
          "distance": 1.2,
          "thumbnail": "https://storage.vendaah.com/vendors/thumbnail1.jpg",
          "location": {
            "address": "123 Market Street",
            "city": "Springfield"
          }
        }
      ]
    }

### Get Product Details
  - **Endpoint**: `/api/products/{productId}`
  - **Method**: `GET`
  - **Description**: Get detailed information about a specific product.
.
  - **Payload**:
    ```json
    {
      "productId": "p-789abc",
      "name": "Organic Red Apples",
      "description": "Fresh organic apples from local farms",
      "vendor": {
        "id": "v-123xyz",
        "businessName": "Fresh Groceries Ltd",
        "rating": 4.5
      },
      "price": {
        "amount": 4.99,
        "currency": "USD",
        "unit": "per pound"
      },
      "inventory": {
        "status": "IN_STOCK",
        "quantity": 85
      },
      "images": [
        {
          "url": "https://storage.vendaah.com/products/apple1.jpg",
          "isPrimary": true
        }
      ],
      "reviews": {
        "average": 4.8,
        "count": 24,
        "recent": [
          {
            "rating": 5,
            "comment": "Very fresh and tasty!",
            "createdAt": "2025-01-26T15:30:00Z"
          }
        ]
      }
    }


### Submit Inquiry
  - **Endpoint**: `/api/vendors/{vendorId}/inquiries`
  - **Method**: `POST`
  - **Description**: Submit a customer inquiry to a vendor
.
  - **Payload**:
    ```json
    {  
      "customerId": "c-456def",
      "subject": "Product Availability",
      "message": "Do you have organic pears in stock?",
      "productId": "p-789abc",
      "preferredContactMethod": "EMAIL"
    }
  - **Response**:
    ```json
    {
      "inquiryId": "i-987mno",
      "status": "PENDING",
      "createdAt": "2025-01-27T14:45:00Z",
      "expectedResponseTime": "24h"
    }
  
## Admin Endpoints
### Get System Health
  - **Endpoint**: `/api/admin/health`
  - **Method**: `GET`
  - **Description**: Get system health metrics and status
.
  - **Payload**:
    ```json
    {
      "status": "HEALTHY",
      "metrics": {
        "uptime": "99.99%",
        "responseTime": "45ms",
        "activeUsers": 1250,
        "errorRate": "0.01%"
      },
      "services": {
        "database": "OPERATIONAL",
        "cache": "OPERATIONAL",
        "storage": "OPERATIONAL"
      }
    }

### Manage User Account
  - **Endpoint**: `/api/admin/users/{userId}`
  - **Method**: `PATCH`
  - **Description**: pdate user account status or details.
  - **Payload**:
    ```json
    {
      "status": "SUSPENDED",
      "reason": "Violation of terms of service",
      "duration": "7d",
      "notifyUser": true
    }

## Error Responses
All endpoints may return the following error responses:
- **Payload**:
    ```json
  {
    "error": {
      "code": "VALIDATION_ERROR",
      "message": "Invalid input parameters",
      "details": [
        {
          "field": "email",
          "message": "Invalid email format"
        }
      ]
    }
  }
