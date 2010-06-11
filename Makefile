# - Adam Koprowski 9/06/2010

include .imdb_passwd
include Makefile-XSLT

######################################################################################################

LOGIN_URL := https://secure.imdb.com/register-imdb/login?login=$(USERNAME)&password=$(PASSWD)
VOTE_HISTORY_URL := http://www.imdb.com/mymovies/list?votehistory

COOKIES := cookies.txt

######################################################################################################

.PHONY: login clean movie-files poster-files

all: movies.xml poster-files

login:
	wget --save-cookies $(COOKIES) "$(LOGIN_URL)" --directory-prefix=/tmp

%.xhtml: %.html
	html2xhtml -t strict $< -o $@ 

vote_history.html: login
	wget --load-cookies $(COOKIES) "$(VOTE_HISTORY_URL)" -O $@

premovies.xml: vote_history.xhtml
	$(RUN_XSLT) -o $@ $< premovies.xsl

movie_list.txt: premovies.xml movie_list.xsl
	$(RUN_XSLT) -o $@ $< movie_list.xsl

movies.xml: premovies.xml movies.xsl movie-files 
	$(RUN_XSLT) -o $@ $< movies.xsl
	
movie-files: movie_list.txt
	make -f Makefile-posters get-movie-files 

poster-files: movies.xml
	make -f Makefile-posters get-poster-files

clean:
	rm -f vote_history.html vote_history.xhtml premovies.xml movies.xml movie_list.txt $(COOKIES)
