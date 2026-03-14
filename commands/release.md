Execute a full release workflow for the current project.

## 1. Detect Project Type
- pubspec.yaml → Flutter
- wrangler.toml → Cloudflare Workers
- next.config.* or vercel.json → Next.js/Vercel
- firebase.json → Firebase
- package.json (other) → Node.js

## 2. Pre-flight Checks
- Confirm working directory is clean (git status --porcelain)
- Confirm on the correct branch

## 3. Version Management
Read current version (by project type):
- Flutter: version field in pubspec.yaml
- Node.js: version field in package.json
- Other: latest git tag

Ask user for target version. Auto-increment buildNumber (Flutter) or patch version.

## 4. Build (by project type)

### Flutter
```
flutter clean && flutter pub get
flutter analyze (stop on errors)
flutter build ipa --export-options-plist=ios/ExportOptions.plist
→ verify build/ios/ipa/*.ipa exists, show size
flutter build appbundle --release
→ verify build/app/outputs/bundle/release/*.aab exists, show size
```
Both artifacts must exist before proceeding.

### Cloudflare Workers
```
npm run build or npx wrangler deploy --dry-run
```
Confirm no errors.

### Next.js
```
npm run build
```
Confirm no errors.

## 5. Release Notes
Generate release notes from git log (since last tag):
- Plain text format, no emoji or special symbols
- Include: version, date, changes, known issues

## 6. Git
```
git add [changed version files]
git commit -m "release: v{version}"
git tag v{version}
```
Ask whether to push.

## 7. Summary Report
- Version number
- Artifact paths and sizes (if applicable)
- Git tag
- Next steps
