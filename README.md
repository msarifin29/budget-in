# Budget In

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart


To build APK Android:

```sh
# Development
$ flutter build apk --split-per-abi --flavor development --target lib/main_development.dart

# Staging
$ flutter build apk --split-per-abi --flavor staging --target lib/main_staging.dart --release

# Production
$ flutter build apk --split-per-abi --flavor production --target lib/main_production.dart --release
```

To build AppBundle Android:

```sh
# Development
$ flutter build appbundle --flavor development --target lib/main_development.dart --release

# Staging
$ flutter build appbundle --flavor staging --target lib/main_staging.dart --release

# Production
$ flutter build appbundle --flavor production --target lib/main_production.dart --release
```

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

