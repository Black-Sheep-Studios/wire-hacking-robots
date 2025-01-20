.PHONY: package
package: release
	zip -r build/logic-hazard-html.zip build/html/*

.PHONY: release
release:
	mkdir -p build/html
	godot --export-release "Web"

.PHONY: clean
clean:
	rm -rf build
