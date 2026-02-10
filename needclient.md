# Client Requirements Checklist for "Oson Bozorlik" App

This document outlines the assets, information, and access credentials required from the client to facilitate the development and deployment of the "Oson Bozorlik" mobile application.

## 1. Brand Assets
- [ ] **App Icon**: High-resolution logo (1024x1024px minimum, PNG/SVG).
- [ ] **Splash Screen**: Background image or logo for the loading screen.
- [ ] **Color Palette**: Specific hex codes if different from the technical specification.
- [ ] **Typography**: Font files (.ttf/.otf) if custom fonts are preferred.

## 2. Product Data & Content
- [ ] **Product Catalog**: A spreadsheet or document containing:
    - Product Name
    - Category & Subcategory
    - Price (in SOM)
    - Unit of measurement (kg, piece, etc.)
    - Stock status
    - **Weight per unit** (for delivery cost calculation)
- [ ] **High-Quality Images**:
    - [ ] Category banner images (8 categories defined in updated spec).
    - [ ] Individual product photos (clear, high resolution).
- [ ] **Store Info & Location**:
    - **Cities served**: Зарафшан (default), Учкудук, Наваи.
    - (Requirement: Replace address selection in header with a dropdown for these 3 cities).
    - Official address and contact details.
    - **Telegram**: @osonbozorlik
    - **Instagram**: osonbozorlik
    - **Phone**: +998 50 099 33 37 (for the "Support" and "Profile" sections).

## 3. Cart & Delivery Logic
The following calculation rules will be implemented:
- **Cost of products**: Sum of (Price × Quantity)
- **Delivery service**: Based on total weight
    - 0-10 kg: 10,000 Soʻm
    - 10-30 kg: 15,000 Soʻm
    - 30-50 kg: 20,000 Soʻm
    - 50-70 kg: 25,000 Soʻm
    - 70-90 kg: 30,000 Soʻm
    - (Every extra 20kg adds 5,000 Soʻm)
- **Total**: Cost of products + Delivery service

## 4. Checkout Requirements
- [ ] **Payment Methods Confirmation**:
    - [x] Cash upon delivery
    - [x] Card upon delivery (via courier)
- [ ] **Delivery Slots**: Confirmation of the 5 time intervals (08:00-10:00, 10:00-12:00, 13:00-15:00, 15:00-17:00, 17:00-20:00).

## 5. Legal & Documentation
- [ ] **Public Offer**: Full text of the service agreement.
- [ ] **Privacy Policy**: Data protection and processing terms.
- [ ] **About the App**: A brief description for the info section.

## 6. Technical Access & Credentials
- [ ] **Google Cloud Console**: Access for Google OAuth (Social Login).
- [ ] **Supabase Project**: Credentials or dashboard access.
- [ ] **Telegram Bot**:
    - [ ] Bot Token (via @BotFather).
    - [ ] Target Chat ID/Channel ID for orders.
- [ ] **Push Notifications**: Firebase (FCM) or OneSignal credentials.
- [ ] **Developer Accounts**: Apple App Store & Google Play Store access.

## 7. Deployment Information
- [ ] **Domain Name**: For admin panel or API.
- [ ] **Support Email**: For official communications.
