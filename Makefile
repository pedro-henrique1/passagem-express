# Variável com o comando do Flutter
FLUTTER := flutter

# Alvo padrão ao rodar `make`
all: analyze

# 📌 Analisa o código conforme as regras do analysis_options.yaml
analyze:
	@$(FLUTTER) analyze

# 📌 Formata o código seguindo o padrão do Dart
format:
	@$(FLUTTER) format . --set-exit-if-changed

# 📌 Executa análise + formatação (ideal para CI/CD)
check:
	@make format
	@make analyze

# 📌 Limpa cache do Flutter
clean:
	@$(FLUTTER) clean

# 📌 Build do projeto para Web
build-web:
	@$(FLUTTER) build web

# 📌 Atalho para rodar o app no Chrome
run-web:
	@$(FLUTTER) run -d chrome

# 📌 Mostra as opções disponíveis
help:
	@echo "Comandos disponíveis:"
	@echo "  make analyze     - Executa 'flutter analyze'"
	@echo "  make format      - Formata o código Dart"
	@echo "  make check       - Executa format + analyze"
	@echo "  make clean       - Limpa o cache do Flutter"
	@echo "  make build-web   - Compila o app Flutter Web"
	@echo "  make run-web     - Roda o app no Chrome"