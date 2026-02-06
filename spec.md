# Technical Specification: "Oson Bozorlik" Mobile App

## General Description
The project is a mobile application for an online grocery store, developed using the **Flutter** framework. The primary goal of the application is to provide users with a convenient interface for selecting and purchasing products by category.

- **App Currency**: Uzbekistani Som (**SOM**). Throughout the application, prices are displayed in the format "Price SOM" (e.g., 5600 SOM).

## Main Screen

### Header (Header / AppBar)
- **Left**: Menu icon (hamburger, three horizontal lines).
- **Center**: Address selection widget.
  - Components: Location icon (pin/place), "Select Address" text, down arrow icon (dropdown).
  - Action: Opens functionality to select or change the delivery address.
- **Right**: Notifications icon (bell).

### Main Content
The main screen consists of product category blocks. Each block is clickable and leads to the corresponding catalog section.

#### List of Categories:
1.  **Fruits**
2.  **Vegetables**
3.  **Oil, Eggs, Milk, and Other Products**
4.  **Flour and Grain Products**
5.  **Teas and Coffee**
6.  **Hygiene and Cleaning Products**
7.  **Beverages**

*Note: Ready-made photographs are provided for each category block.*

### Floating Search Button
- A search button should be located in the bottom right part of the screen.
- The button should be pinned and float over the content during scrolling.
- Icon: Search (magnifying glass).

## Navigation
- Tapping a category -> Navigate to the Category Screen.
- Tapping a product card -> Navigate to the Product Details Screen.
- Tapping the menu icon -> Open the side menu (Drawer).
- Tapping search -> Navigate to the Search Screen.

## Category Screen
This screen opens when a specific category is selected on the main screen.

### Header (Header / AppBar)
- **Left**: "Back" icon (left arrow).
- **Center**: Current category name (e.g., "Fruits").
- **Right**: "Search" icon (magnifying glass).

### Subcategories (Tabs)
- Horizontal scrolling list of tabs (subcategories) under the header.
- **First Tab**: Main category name (e.g., "All Fruits" or just "Fruits"), displays the entire product list.
- **Other Tabs**: Subcategories (e.g., "Citrus", "Tropical Fruits", etc.).
- **Logic**: Tapping a tab triggers an automatic scroll (anchor scroll) to the corresponding section on the page.

### Product Grid
- Products displayed in a grid: **2 cards per row**.
- Display Order: General category products first, followed by subcategory blocks (according to tabs).

### Product Card
Card Components:
1.  **Product Image**.
2.  **Name**: e.g., "Local Golden Apple".
3.  **Price**: Price per unit of measurement (e.g., per 1 kg).
4.  **Weight/Quantity Management**:
    - Step increment: **500 grams** (for weight-based products).
    - Weight/Total indicator: Located on a pale-pale-green background. Shows the current total for the selected weight of this product.
5.  **"Out of Stock" Status**:
    - If a product is unavailable, the card becomes faded (semi-transparent).
    - "Out of Stock" text is displayed over or under the card.
    - Increment/decrement buttons are disabled.

## Product Details Screen
Opens when a product card is tapped.

### Header (Header / AppBar)
- **Left**: "Back" icon (left arrow).
- **Right**: Optional "Share" or "Favorite" icon (as needed).

### Screen Content
1.  **Large Product Image**:
    - Occupies approximately **50% of the screen height**.
    - High-quality photo of the fruit/product.
2.  **Information Block**:
    - **Name**: Large font (e.g., "Local Apple Crebston").
    - **Price**: Price per kilogram (or other unit).
    - **Description**: Text block with a description of the variety, taste qualities, or other product characteristics.
3.  **Bottom Action Bar**:
    - **Weight Selection**: Quantity management with a **500-gram** step.
    - **"Add to Cart" Button**: Bright, accent button to confirm selection.

## Search Screen
Opens when the floating search button or the search icon in the header is tapped.

### Header (Header / AppBar)
- **Left**: "Back" icon (left arrow).
- **Center**: Input field with "Search" placeholder text.
- **Input Logic**: 
    - When text appears in the input field, a "Clear" icon (X) appears on the right of the input for quick clearing.

### Search Results
- **Live Search**: Search should start immediately as characters are typed.
- **Filtering Logic**: 
    - Search is performed based on any match in the product name (even a single letter).
    - If matches are found, a list of all matching products is displayed (in card format, similar to the category screen).
- **Empty State**: 
    - If no matches are found for the entered query, "Nothing found" text is displayed.

## Auth & Registration

### Login Screen
- **Login Methods**:
    1.  **Email + Password**: Fields for email and password, "Login" button.
    2.  **Google Auth**: Quick login button via Google account.
- **Transition**: "Register" link for new users.

### Registration Screen
- **Input Fields**:
    1.  **Name**: Text field for user's name.
    2.  **Phone**: Field for phone number (with mask).
    3.  **Email**: Field for email address.
    4.  **Password**: Field for creating a password.
- **Consent**: "I agree to the terms of personal data processing" checkbox (required to activate the registration button).
- **Alternative Sign-up**: Registration via **Google account**.
- **Button**: "Register" (becomes active after all required fields are filled and terms are accepted).

## Profile Screen

### User Header
- **Avatar**: Circular user icon. A standard "User" icon is located in the center of the circle.
- **Information**:
    - Username.
    - Email address.

### Main Menu Items
1.  **Recent Orders**: Navigate to the order history list.
2.  **Language Selection**: Switcher or dropdown. Available languages:
    - **Uzbek**
    - **Russian**
    - **English**

### Information Block
1.  **About the App**: Project information.
2.  **Public Offer**: Legal document.
3.  **Privacy Policy**: Data processing terms.
4.  **App Version**: `1.0.0` (static text at the bottom of the screen).

## Cart Screen

### Header (Header / AppBar)
- **Left**: "Back" icon.
- **Center**: "Cart" title.
- **Right**: "Clear Cart" button.
    - Action: Displays a **Pop-up (dialog window)** asking: "Are you sure you want to clear the cart?". Options: Yes / Cancel.

### Product List
- Products displayed in a list (one per row).
- **Product Row Components**:
    - Left: Thumbnail image.
    - Right: Product name, unit price (e.g., "5600 SOM").
    - "Delete" button (trash icon or X) for each product.

### Pinned Bottom Bar
- **Information Text**: "You have [X] items costing [Y] SOM".
- **Button**: "Checkout" (large, accent button).
- **Validation**:
    - If there are "Out of Stock" items in the cart, the "Checkout" button is disabled.
    - A warning is displayed: "Please remove unavailable items from the cart".

## Checkout Screen

### Screen Sections
1.  **Delivery Address**:
    - Interactive "Delivery Address" tile/block.
    - Action: Opens a screen or window to enter/select an address.
2.  **Delivery Date**:
    - Selection via tabs or switchers: **Today** / **Tomorrow**.
3.  **Delivery Time**:
    - Time interval selection (tabs):
        - 09:00 - 12:00
        - 12:00 - 15:00
        - 16:00 - 18:00
        - 18:00 - 20:00
4.  **Payment Method**:
    - Only available option: **Payment upon delivery**.

### Confirmation Button
- Large button at the bottom: **"Place Order for [Y] SOM"**.

## Admin Panel (Web-Interface)
A web interface (based on Supabase Dashboard or a separate Flutter Web app) is used for store management.

### Product Management
- **Product List**: View all items with filtering by category.
- **Actions**:
    - **Add**: Create a new card (photo, name, price, category).
    - **Edit**: Modify product data.
    - **Delete**: Permanently remove a product from the database.
    - **Pause (Stock Toggle)**: Ability to hide a product from sale or set "Out of Stock" status.

### Order Management
- **Current and History of Orders**: A single list with filtering by status (New, Processing, Completed).
- **Search**: By order number or client phone number.
- **Order Details**:
    - Order number.
    - List of products and total amount.
    - Address, date, and delivery time.
    - Client contact information.

## Design & UI/UX

### Color Palette
- **Main Background**: Pure white (#FFFFFF). Creates a feeling of cleanliness and lightness.
- **Accent Green**: "Young leaf" or "grassy" green. Used for primary buttons and active elements.
- **Dark Green**: For headers and important navigation elements.
- **Light Green (Pastel)**: For backgrounds, weight selection indicators, and secondary blocks.

### Visual Style
- **Concept**: Light, modern, "digital" design with an emphasis on high-quality visual content.
- **Cards and Images**: Large, juicy product photos. Corner rounding for cards (BorderRadius) should be soft (16-24 dp).
- **Typography**: Use of modern sans-serif fonts (e.g., Inter, Montserrat, or SF Pro). Clear header hierarchy.
- **UX Benchmarks**: Inspiration from leading delivery service interfaces (Yandex.Delivery, Wolt, Glovo). Priority is minimizing clicks to purchase.

### Animations and Micro-interactions
- **Smoothness**: Use of `Hero` animations when transitioning from a product card to the details screen.
- **Feedback**: Soft button press animations, smooth appearance of list items.
- **Libraries**: `Lottie` is recommended for confirmation icons (e.g., after placing an order) and `Animate Do` for simple entrance animations.

## Technical Requirements
- **Programming Language**: Dart.
- **Framework**: Flutter.
- **State Management**: Provider.
- **Animations**: `flutter_animate`, `lottie`.
- **Backend**: Supabase.
    - **Authentication**: Supabase Auth (Email/Password, Google).
    - **Database**: PostgreSQL (via Supabase).
    - **Storage**: Supabase Storage (for product images and avatars).
- **Telegram Integration**:
    - Notifications of new orders should be sent to a Telegram bot.
    - Implementation: Via **Supabase Edge Functions** (a database trigger on new order creation sends a request to the Telegram Bot API).
- **Assets**: All category images should be placed in the `assets/images/` directory.
- **Scrolling**: Implementation of `ScrollController` or specialized libraries for synchronizing tabs and scroll position (Anchor scrolling).

## Notifications
The following options are proposed for push notification implementation (choose one):

1.  **Firebase Cloud Messaging (FCM)** — *Recommended option*.
    - Industry standard for Android and iOS.
    - Excellent integration with Flutter via `firebase_messaging`.
    - Ability to send notifications via Supabase Edge Functions.
2.  **OneSignal**.
    - Simple setup and convenient campaign management dashboard.
    - Good Flutter support.
    - Paid for large volumes, but convenient for marketing pushes.
3.  **Supabase Realtime + Local Notifications**.
    - Allows for instant data updates in the app when it is open.
    - Combined with `flutter_local_notifications`, it can simulate pushes, but FCM is better for full background notifications.
