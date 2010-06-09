# - Adam Koprowski 9/06/2010

include imdb_passwd
include Makefile.XSLT

######################################################################################################

LOGIN_URL := https://secure.imdb.com/register-imdb/login?login=$(USERNAME)&password=$(PASSWD)
VOTE_HISTORY_URL := http://www.imdb.com/mymovies/list?votehistory

COOKIES := cookies.txt

######################################################################################################

.PHONY: login clean

all: movies.xml

login:
	wget --save-cookies $(COOKIES) "$(LOGIN_URL)" --directory-prefix=/tmp

%.xhtml: %.html
	html2xhtml -t strict $< -o $@ 

vote_history.html: login
	wget --load-cookies $(COOKIES) "$(VOTE_HISTORY_URL)" -O $@

premovies.xml: vote_history.xhtml
	$(RUN_XSLT) -o $@ $< movies.xsl

movie_list.txt: premovies.xml
	$(RUN_XSLT) -im:list-movie-ids $< movies.xsl	

clean:
	rm -f vote_history.html vote_history.xhtml premovies.xml $(COOKIES)
