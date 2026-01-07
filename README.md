# Flydle App

Flydle App is a mobile application built with **Flutter** that focuses on implementing **authentication and user profile management using Supabase**.  
This project was developed to explore backend integration for login, registration, and profile handling.

---

## Overview

The main goal of this project is to implement a complete authentication flow using **Supabase** as the backend service.  
Users can register, log in, view their profile, update profile data, and log out of the application.

The home page displays dummy content to represent the main app interface after successful authentication.

---

## Tech Stack

- Flutter
- Dart
- Supabase (Authentication & Database)
- Navigator (Flutter navigation)
- setState (state management)

---

## Implemented Features

### Authentication
- User registration using:
  - Name
  - Email
  - Password
- User login using:
  - Email
  - Password
- Authentication handled entirely by Supabase

---

### Home Page
- Displays user name fetched from Supabase
- Shows dummy data for UI representation
- Accessible only after successful login

---

### Profile Page
- Displays user profile data
- User can:
  - Update name
  - Update password
- Profile data is synced with Supabase

---

### Logout
- User can log out from the application
- Session is cleared
- User is redirected back to the login page

---

## Application Flow

1. User opens the application
2. User logs in or registers
3. After successful authentication:
   - User is redirected to the Home Page
   - User name is displayed
4. User can navigate to the Profile Page
5. User updates profile information if needed
6. User logs out and returns to the Login Page

---

## Data Management

- User authentication is handled by Supabase Auth
- User profile data is stored and retrieved from Supabase database
- Home page content uses dummy data for display purposes

---

## Limitations

- Home page content is static (dummy data)
- No complex business logic implemented yet
- Focus is limited to authentication and profile features

---

## Purpose

This project was created to:
- Learn and implement Supabase authentication
- Practice backend integration in Flutter
- Build a clean authentication flow with profile management
- Serve as a technical task / learning project

---

## License

This project is intended for educational and evaluation purposes.
