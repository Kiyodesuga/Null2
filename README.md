# NULL² Flutter Web Demo v11

This project integrates:
- SidePanel navigation (Profile, Thought Log, Wave Graph, Settings)
- Dynamic post input UI: floating button opens text input, posts flow into river

## Build & Deploy

```bash
flutter pub get
flutter build web --release --web-renderer html
```

Push to GitHub, Vercel will auto-deploy using `vercel.json`.
