SRCDIR = input
TEMPLDIR = templates
ARTICLES = $(shell find $(SRCDIR) -name '*.md' -printf '%f \n')

all: index

index: articles
	redcarpet assests/index >> $(TEMPLDIR)/content.html
	cat $(TEMPLDIR)/header.html $(TEMPLDIR)/content.html $(TEMPLDIR)/footer.html > index.html
	rm $(TEMPLDIR)/content.html

articles: $(ARTICLES) 

%.md: 
	cat $(TEMPLDIR)/header.html > $*.html
	redcarpet $(SRCDIR)/$@ >> $*.html
	cat $(TEMPLDIR)/footer.html >> $*.html


config: 
	mkdir -p $(TEMPLDIR)
	mkdir -p $(SRCDIR)
