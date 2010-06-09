SHOW := @echo
HIDE := @

SAXON_DIR ?= ../tools/saxon
SAXON_JAR ?= $(SAXON_DIR)/saxon9.jar
RESOLVER_JAR ?= $(SAXON_DIR)/resolver.jar
SAXON := java -cp $(SAXON_JAR):$(RESOLVER_JAR) -Dxml.catalog.files=../tools/saxon/dtds/catalog.xml \
	-Dxml.catalog.verbosity=1 net.sf.saxon.Transform \
	-r org.apache.xml.resolver.tools.CatalogResolver \
	-x org.apache.xml.resolver.tools.ResolvingXMLReader \
	-y org.apache.xml.resolver.tools.ResolvingXMLReader
RUN_XSLT := $(SAXON)
