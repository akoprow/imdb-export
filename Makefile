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
	$(SHOW) Logging to IMDB...
	$(HIDE) wget --save-cookies $(COOKIES) "$(LOGIN_URL)" --directory-prefix=/tmp -o /dev/null

%.xhtml: %.html
	$(SHOW) Generating: [$@]
	$(HIDE) html2xhtml -t strict $< -o $@ 

vote_history.html: login
	$(SHOW) Generating: [$@]
	$(HIDE) wget --load-cookies $(COOKIES) "$(VOTE_HISTORY_URL)" -O $@ -o /dev/null

premovies.xml: vote_history.xhtml
	$(SHOW) Generating: [$@]
	$(HIDE) $(RUN_XSLT) -o $@ $< premovies.xsl

movie_list.txt: premovies.xml movie_list.xsl tvseries.xml
	$(SHOW) Generating: [$@]
	$(HIDE) $(RUN_XSLT) -o $@ $< movie_list.xsl

movies.xml: premovies.xml movies.xsl movie-files 
	$(SHOW) Generating: [$@] 
	$(HIDE) $(RUN_XSLT) -o $@ $< movies.xsl

movie-files: movie_list.txt
	$(HIDE) make -f Makefile-posters get-movie-files 

poster-files: movies.xml
	$(HIDE) make -f Makefile-posters get-poster-files

clean:
	$(SHOW) Cleaning...
	$(HIDE) rm -f vote_history.html vote_history.xhtml premovies.xml movies.xml movie_list.txt $(COOKIES)

full-clean: clean
	$(SHOW) Cleaning cached movies and poster files...
	$(HIDE) rm -f imdb/*.xhtml posters/*.jpg
