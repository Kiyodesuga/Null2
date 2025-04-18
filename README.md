# NULL² Flutter Web Demo

This project integrates a SidePanel with navigation to:
- Profile (view-only)
- Thought Log (placeholder)
- Wave Graph (placeholder)
- Settings (profile edit)

## Build & Deploy

```bash
flutter pub get
flutter build web --release --web-renderer html
```

Push to GitHub, Vercel will auto-deploy using `vercel.json`.
