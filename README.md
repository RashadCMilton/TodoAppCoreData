# Notes App

A lightweight note-taking application built with SwiftUI and Core Data for iOS.

## Overview

This application allows users to create, read, update, and delete notes. It uses Core Data for persistent storage and is built with SwiftUI for the user interface.

## Features

- Create new notes with title and content
- View list of saved notes with previews
- Edit existing notes
- Delete notes
- Automatic saving
- Notes sorted by last updated date

## Project Structure

### Models

- **Note (Core Data Entity)**
  - `id`: UUID - Unique identifier for each note
  - `title`: String - Title of the note
  - `content`: String - Content/body of the note
  - `createdAt`: Date - Creation timestamp
  - `updatedAt`: Date - Last modification timestamp

- **NoteModel (Struct)**
  - A Swift struct wrapper around the Core Data Note entity for easier use in SwiftUI views

### Views

- **NoteListView**
  - Main view displaying a list of all notes
  - Includes functionality to add, edit, and delete notes
  - Displays title, content preview, and modification date for each note

- **NoteEditorView**
  - View for creating new notes or editing existing ones
  - Supports two modes: new and edit
  - Form-based input for title and content

- **ContentView**
  - Root view of the application

### View Model

- **NotesViewModel**
  - Manages the application's data and business logic
  - Handles CRUD operations for notes using Core Data
  - Implements sorting notes by last updated date

### Core Data Manager

- **CoreDataManager**
  - Singleton for managing Core Data stack
  - Provides convenient access to persistent container and managed object context
  - Handles saving context

## Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone the repository
2. Open the project in Xcode
3. Build and run the application on your device or simulator

## Usage

### Creating a New Note

1. Tap the "+" button in the top right corner
2. Enter a title and content for your note
3. Tap "Save" to save your note

### Editing a Note

1. Tap on an existing note in the list
2. Modify the title or content
3. Tap "Save" to save your changes

### Deleting a Note

1. Swipe left on a note in the list
2. Tap "Delete" to remove the note

## Future Enhancements

- Add search functionality
- Implement note categories or tags
- Add support for rich text formatting
- Implement cloud synchronization
- Add dark mode support

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [Apple Documentation for Core Data](https://developer.apple.com/documentation/coredata)
- [Apple Documentation for SwiftUI](https://developer.apple.com/documentation/swiftui)
