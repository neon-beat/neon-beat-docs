PLANTUML_VERSION="1.2025.7"

doc: plantuml.jar
	java -jar plantuml.jar internals/*.txt

plantuml.jar:
	wget https://github.com/plantuml/plantuml/releases/download/v$(PLANTUML_VERSION)/plantuml-$(PLANTUML_VERSION).jar -O plantuml.jar
