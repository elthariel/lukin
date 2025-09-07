# Grindr‑Style MVP – Feature Roadmap

## 1. User Registration & Authentication
- **TODO**
  - [x] Add Devise for email/phone sign‑up.
  - [] Style devise pages with daisy/tailwind
  - [] Implement password reset & email/phone verification.
  - [] Wire Turbo Frames for the sign‑up flow. (???)
- **Notes**
  - Service worker should cache the login page for offline access.

## 2. Profile Creation & Editing
- **TODO**
  - [x] Create `UserProfile` model with fields: `name`, `age`, `gender`, `pronouns`, `bio`.
  - [/] Attach photos via ActiveStorage (image variants for thumbnails).
  - [] Stimulus controller for image upload preview.
- **Notes**
  - All users are always visible; no “invisible” flag.
  - Validation rules: age ≥ 18, required fields.

## 3. Geolocation & Nearby Users
- **TODO**
  - [] Request location permission on first visit.
  - [x] Store user’s last known coordinates in `users` table (PostGIS `geography` column).
  - [x] Create a `profiles#index` endpoint that returns users.
  - [] Use Turbo Streams to push new nearby users as they appear.
    - Not sure. Will probably just do a refresh
- **Notes**
  - [x] Use PostGIS for efficient distance queries.
  - Cache the result for a short period to reduce DB load.

## 4. User Discovery & Filtering
- **TODO**
  - [x] Build a grid view (Turbo Frame) that lists nearby users.
  - [] Add filter controls (distance, age range, gender) in a separate Turbo Frame.
  - [] Stimulus controller to submit filter changes via AJAX and update the grid.
- **Notes**
  - Keep the UI responsive; avoid full page reloads.
  - [] Store filter preferences in localStorage for persistence.

## 5. “Tap” Interaction
- **TODO**
  - [x] Implement a dedicated profile page for the clicked user.
  - [x] Provide a “Start Chat” button on that page.
- **Notes**
  - Ensure accessibility: focus trap, ARIA roles.

## 6. Messaging
- **TODO**
  - [x] Create `Chat` model with jsonb `messages` columns
  - [x] Create a `ChakLink` model to link profile to chats
  - [x] Store each message as a JSON object: `{ profile_id:, body:, sent_at: }`.
  - [x] Build a chat view (Turbo Frame) that streams new messages via ActionCable.
  - [x] Stimulus controller for sending messages and auto‑scrolling.
- **Notes**
  - No separate `Message` table; all conversation history lives in the `messages` jsonb column.
  - This limits history size but reduces write‑scale overhead.
  - Consider truncating or archiving old messages if needed.

## 7. Push Notifications
- **TODO**
  - [] Register service worker for push.
  - [] Use Rails ActionCable to push notifications for new messages and nearby users.
  - [] Implement a simple notification UI (toast or badge).
- **Notes**
  - Respect user preferences for notification types.
  - Fallback to email notifications if push fails.

## 8. User Settings & Privacy
- **TODO**
  - [] Build a settings page (Turbo Frame) for:
    - [/] Editing profile.
    - [] Blocking users (create `Block` model).
    - [] Managing notification preferences.
  - [] Stimulus controller for toggle switches.
- **Notes**
  - Blocked users should never appear in the nearby grid.
  - Provide a confirmation dialog before blocking.

## 9. Basic Analytics & Reporting
- **TODO**
  - [] Log key events (sign‑up, login, message sent) using `ActiveSupport::Notifications`.
  - [] Integrate Sentry or similar for crash reporting.
- **Notes**
  - Keep analytics lightweight; avoid storing PII.

## 10. Responsive PWA
- **TODO**
  - [] Create `manifest.json` with icons, start URL, display mode.
  - [] Write a service worker that caches static assets and API responses.
  - [] Add “Add to Home Screen” prompts for iOS/Android.
- **Notes**
  - Ensure offline fallback pages for critical routes.
  - Test on real devices for performance.

## 11. Front‑end Stack
- **TODO**
  - [x] Add Tailwind CSS via `vite-rails`.
  - [x] Configure Vite for Hotwired (Turbo & Stimulus).
  - [x] Ensure Tailwind is purged for production.

---

### Next Steps
1. Scaffold the Rails 8 API with Hotwired.
2. Set up PostGIS and seed initial data.
3. Implement authentication (Devise) and profile flow.
4. Build the discovery grid and filtering.
5. Add messaging and push notifications.
6. Wrap up with PWA assets and testing.

Happy coding! 🚀
