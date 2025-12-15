# Contributing to QuickNotes

First off, thank you for considering contributing to QuickNotes! It's people like you that make QuickNotes such a great app.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* **Use a clear and descriptive title**
* **Describe the exact steps which reproduce the problem**
* **Provide specific examples to demonstrate the steps**
* **Describe the behavior you observed after following the steps**
* **Explain which behavior you expected to see instead and why**
* **Include screenshots and animated GIFs if possible**
* **Include your environment details:**
  - Flutter version (`flutter --version`)
  - Dart version (`dart --version`)
  - OS and version
  - Device/emulator details

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* **Use a clear and descriptive title**
* **Provide a step-by-step description of the suggested enhancement**
* **Provide specific examples to demonstrate the steps**
* **Describe the current behavior and the expected behavior**
* **Explain why this enhancement would be useful**

### Pull Requests

* Fill in the required template
* Follow the Dart styleguides
* Include appropriate test cases
* End all files with a newline
* Update documentation accordingly

## Styleguides

### Dart/Flutter Code Style

* Use meaningful variable and function names
* Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
* Use `flutter format` before committing
* Maximum line length: 80 characters (soft limit)
* Use `const` constructors where possible
* Document complex logic with comments

```dart
// Good
class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  
  const NoteCard({
    required this.note,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Text(note.title),
      ),
    );
  }
}
```

### Git Commit Messages

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line

**Format:**
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
* `feat`: A new feature
* `fix`: A bug fix
* `docs`: Documentation only changes
* `style`: Changes that don't affect code meaning (formatting, etc.)
* `refactor`: Code change that neither fixes a bug nor adds a feature
* `test`: Adding or updating tests
* `chore`: Changes to build process, dependencies, etc.

**Example:**
```
feat(notes): add search functionality

Implement real-time search across note titles and content.
Uses debouncing to optimize performance.

Closes #123
```

### Documentation

* Use clear and concise language
* Include code examples where appropriate
* Update README.md if you change functionality
* Add inline comments for complex logic
* Document public APIs with doc comments

## Development Setup

1. Fork and clone the repository
2. Install dependencies: `flutter pub get`
3. Create a new branch: `git checkout -b feature/your-feature`
4. Make your changes
5. Format code: `dart format .`
6. Test your changes: `flutter test`
7. Commit your changes following the guidelines above
8. Push to your fork and submit a pull request

## Testing

* Write unit tests for new functionality
* Ensure all existing tests pass: `flutter test`
* Aim for at least 80% code coverage
* Test edge cases and error conditions

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## Review Process

1. Maintainers will review your PR
2. Changes may be requested
3. Once approved, your PR will be merged
4. Your contribution will be acknowledged

## Recognition

Contributors will be recognized in:
* The README.md file
* Commit history
* GitHub contributors page

## Questions?

* Create an issue for questions
* Check existing issues and discussions
* Refer to the main README.md

Thank you for contributing! 🎉
