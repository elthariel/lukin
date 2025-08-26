# Grindr‑Style MVP – Feature Roadmap

## 1. User Registration & Authentication
- **TODO**  
  - [] Add Devise (or Sorcery) for email/phone sign‑up.  
  - [] Implement password reset & email/phone verification.  
  - [] Wire Turbo Frames for the sign‑up flow.  
- **Notes**  
  - Keep the API thin; use Rails 8’s built‑in API mode.  
  - Service worker should cache the login page for offline access.

## 2. Profile Creation & Editing
- **TODO**  
  - [] Create `UserProfile` model with fields: `name`, `age`, `gender`, `pronouns`, `orientation`, `bio`.  
  - [] Attach photos via ActiveStorage (image variants for thumbnails).  
  - [] Build Turbo Streams for live preview of profile changes.  
  - [] Stimulus controller for image upload preview.  
- **Notes**  
  - All users are always visible; no “invisible” flag.  
  - Validation rules: age ≥ 18, required fields.

## 3. Geolocation & Nearby Users
- **TODO**  
  - [] Request location permission on first visit.  
  - [] Store user’s last known coordinates in `users` table (PostGIS `geography` column).  
  - [] Create a `nearby_users` endpoint that returns users within a configurable radius.  
  - [] Use Turbo Streams to push new nearby users as they appear.  
- **Notes**  
  - Use PostGIS for efficient distance queries.  
  - Cache the result for a short period to reduce DB load.

## 4. User Discovery & Filtering
- **TODO**  
  - [] Build a grid view (Turbo Frame) that lists nearby users.  
  - [] Add filter controls (distance, age range, orientation, gender) in a separate Turbo Frame.  
  - [] Stimulus controller to submit filter changes via AJAX and update the grid.  
- **Notes**  
  - Keep the UI responsive; avoid full page reloads.  
  - Store filter preferences in localStorage for persistence.

## 5. “Tap” Interaction
- **TODO**  
  - [] Implement a tap handler (Stimulus) that opens a modal with the tapped user’s profile.  
  - [] Provide a “Start Chat” button inside the modal.  
- **Notes**  
  - Use Turbo Frames to load the profile modal content.  
  - Ensure accessibility: focus trap, ARIA roles.

## 6. Messaging
- **TODO**  
  - [] Create `Message` model with `sender_id`, `receiver_id`, `body`, `created_at`.  
  - [] Build a chat view (Turbo Frame) that streams new messages via ActionCable.  
  - [] Stimulus controller for sending messages and auto‑scrolling.  
- **Notes**  
  - No match logic: any two users can chat once they tap each other.  
  - Store message history in the database; paginate older messages.

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
    - [] Editing profile.  
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

---

### Next Steps
1. Scaffold the Rails 8 API with Hotwired.  
2. Set up PostGIS and seed initial data.  
3. Implement authentication and profile flow.  
4. Build the discovery grid and filtering.  
5. Add messaging and push notifications.  
6. Wrap up with PWA assets and testing.

Happy coding! 🚀
