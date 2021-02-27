setup:
	flutter channel stable
	flutter upgrade
	npm install

dependencies:
	cd packages/core/ && dart pub get
	cd packages/runner/ && dart pub get
	cd packages/command && dart pub get
	cd example && flutter pub get && cd ..

analyze:
	dart analyze packages/core/lib/
	dart analyze packages/runner/lib/
	dart analyze packages/command/bin/

format:
	dart format packages/core/lib/
	dart format packages/runner/lib/
	dart format packages/command/bin/

build:
	cd example && flutter build apk && cd ..

generate-config-model:
	cd packages/core/ && dart pub run build_runner build && cd ..

generate-with-command:
	dart packages/command/bin/flutter_gen_command.dart --config example/pubspec.yaml

generate-with-runner:
	cd example && flutter packages pub run build_runner build --delete-conflicting-outputs && cd ..

unit-test:
	cd packages/core/ && dart pub run --no-sound-null-safety test && cd ..

coverage:
	./scripts/coverage.sh packages/core
	./scripts/codecov.sh ${CODECOV_TOKEN}

setup-ubuntu:
	sudo apt-get update
	sudo apt-get install apt-transport-https
	sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
	sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
	sudo apt-get update
	sudo apt-get install dart

setup-macos:
	brew tap dart-lang/dart
	brew install dart
