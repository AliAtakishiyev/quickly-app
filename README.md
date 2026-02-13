# Quickly App

A Flutter note-taking app with local storage (Hive) and AI-powered summarization via OpenAI.

---

## How to run the project

1. **Prerequisites:** [Flutter SDK](https://docs.flutter.dev/get-started/install) (SDK ^3.10.8).

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters** (required for the note model):
   ```bash
   dart run build_runner build (dart run build_runner build --delete-conflicting-outputs)
   ```

4. **Configure the API key** (see below), then run:
   ```bash
   flutter run
   ```



---

## How to configure the API key

The app uses **OpenAI’s API** for note summarization. Configure your key via a `.env` file at the **project root** (same level as `pubspec.yaml`).

1. Create a file named `.env` in the project root:
   ```bash
   touch .env
   ```

2. Add your OpenAI API key:
   ```
   OPENAI_API_KEY=sk-your-openai-api-key-here
   ```

3. **Security:** `.env` is listed in `.gitignore`, so your key is not committed. Do not share this file or commit it to version control.

If `OPENAI_API_KEY` is missing or empty, the app will throw when using AI summarization.

---

## Packages used

| Package | Purpose |
|--------|---------|
| **flutter_svg** | Render SVG assets in the UI. |
| **hive** / **hive_flutter** | Local NoSQL storage for notes. |
| **provider** | State management (notes, OpenAI). |
| **flutter_dotenv** | Load `OPENAI_API_KEY` from `.env`. |
| **http** | HTTP requests to the OpenAI API. |


**Dev dependencies:**

| Package | Purpose |
|--------|---------|
| **hive_generator** / **build_runner** | Generate Hive type adapters from `Note` model. |


---

## Project structure

```
lib/
├── main.dart                          # Entry point: loads .env, initializes Hive & providers, runs app
└── features/
    └── quickly/
        ├── data/
        │   ├── services/
        │   │   └── openai_service.dart      # OpenAI API client (summarization)
        │   └── repositories/
        │       ├── note_repository.dart     # Hive CRUD for notes
        │       └── openai_repositories.dart # OpenAIService repository for the app
        ├── models/
        │   ├── note_model.dart              # Note entity + Hive adapter registration
        │   └── note_model.g.dart            # Generated Hive adapter (from build_runner, auto generated)
        ├── providers/
        │   ├── note_provider.dart           # Note list state & repository usage
        │   └── openai_provider.dart         # AI summarization state & repository usage
        └── ui/
            ├── pages/
            │   ├── home_screen.dart         # List of notes
            │   └── note_details_screen.dart # Single note view & edit
            └── widgets/
                ├── custom_app_bar.dart      # custom app bar for the app
                ├── create_note_dialog.dart  # create note dialog
                ├── edit_note_dialog.dart    # edit note dialog
                ├── go_back.dart             # simple go back menu 
                ├── no_notes.dart            # When there is no note on screen this look appears
                ├── note_object.dart         # Note object for list view
                └── summary_ai.dart          # AI summary UI
```

- **Feature-first layout:** All “quickly” (notes + AI) code lives under `features/quickly/`.
- **Data layer:** `services` call external APIs; `repositories` abstract storage and API usage for the rest of the app.
- **State:** `Provider` is used for notes and OpenAI; providers use the repositories.
- **UI:** `pages` are full screens; reusable pieces are in `widgets`.
- 


## Screenshots

<img width="320" height="714" alt="1" src="https://github.com/user-attachments/assets/586838ff-1c22-4b69-85c1-49bb31e154ba" />
<img width="320" height="714" alt="2" src="https://github.com/user-attachments/assets/a67171d2-0f82-4550-b2c2-11831cbbb70a" />

