# Uniq-Gold-Mobile-App

A good plan is to build `Uniq Gold` in 3 layers: product scope, backend design, then Flutter app delivery.

**Recommended roadmap**

1. Define the MVP first.
Decide the first version of the app before coding:
- Customer app or admin app, or both
- Core features: product catalog, gold rates, cart/inquiry, orders, login, profile, notifications
- If this is jewelry retail, decide whether users can `buy`, `reserve`, or just `request quote`

2. Design the backend in Supabase.
Use Supabase for:
- `Auth`: email/phone/social login
- `Postgres`: products, categories, orders, users, addresses, gold-rate history
- `Storage`: product images, certificates, banners
- `Row Level Security`: protect customer/admin data
- Optional later: `Edge Functions` for payments, notifications, admin workflows

3. Plan the database schema.
Start with tables like:
- `profiles`
- `products`
- `product_images`
- `categories`
- `gold_rates`
- `cart_items`
- `orders`
- `order_items`
- `addresses`
- `favorites`
- `notifications`

4. Build Flutter app structure.
Suggested modules:
- `auth`
- `home`
- `catalog`
- `product_details`
- `cart`
- `checkout`
- `orders`
- `profile`
- `admin` if needed

Suggested technical structure:
- `presentation`
- `application`
- `domain`
- `data`

5. Build the MVP in phases.
Phase 1:
- Splash
- Auth
- Home
- Product listing
- Product details
- Gold rate display
- Favorites

Phase 2:
- Cart / inquiry flow
- Address management
- Order placement
- Order history

Phase 3:
- Push notifications
- Coupons
- Reviews
- Admin controls
- Analytics

6. Secure and productionize.
Before launch:
- Enable `RLS` on every user table
- Separate `admin` and `customer` roles
- Validate image upload rules
- Add deep links for auth flows
- Add app logging and crash reporting
- Test Android and iOS release builds

**Best starting stack**
- `Flutter`
- `supabase_flutter`
- `go_router`
- `flutter_riverpod` or `bloc`
- `freezed` + `json_serializable`
- `cached_network_image`

**8-week practical timeline**
- Week 1: requirements, wireframes, schema
- Week 2: Supabase project, auth, database, RLS
- Week 3: Flutter app setup, navigation, theme, auth UI
- Week 4: catalog, product details, search/filter
- Week 5: cart/inquiry, profile, addresses
- Week 6: orders, order history, admin basics
- Week 7: testing, polish, security review
- Week 8: release prep and deployment

**Important current notes from official docs**
- Supabase’s Flutter quickstart uses `supabase_flutter` and recommends initializing with your project URL and key.
- Supabase is moving toward new `publishable` and `secret` keys; older `anon` keys still work until the end of `2026`.
- Some auth methods need mobile deep-link setup.

Sources:
- https://supabase.com/docs/guides/getting-started/quickstarts/flutter
- https://supabase.com/docs/guides/auth
- https://supabase.com/docs/reference/dart/introduction
- https://supabase.com/docs/guides/with-flutter/

If you want, I can turn this into a **full project blueprint** next:
- feature list
- Supabase table schema
- Flutter folder structure
- screen-by-screen plan
