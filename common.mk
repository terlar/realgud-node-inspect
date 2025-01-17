MOSTLYCLEANFILES = *.elc
EMACSLOADPATH=:/home/rocky/.emacs.d/elpa/test-simple-20170527.832/:/home/rocky/.emacs.d/elpa/realgud-20180207.1330/

short:
	$(MAKE) 2>&1 >/dev/null | ruby $(top_srcdir)/make-check-filter.rb

%.short:
	$(MAKE) $(@:.short=) 2>&1 >/dev/null

# This is the default rule, but we need to include an EMACLOADPATH
.el.elc:
	if test "$(EMACS)" != "no"; then \
	  am__dir=. am__subdir_includes=''; \
	  case $@ in */*) \
	    am__dir=`echo '$@' | sed 's,/[^/]*$$,,'`; \
	    am__subdir_includes="-L $$am__dir -L $(srcdir)/$$am__dir"; \
	  esac; \
	  test -d "$$am__dir" || $(MKDIR_P) "$$am__dir" || exit 1; \
	  EMACSLOADPATH=$(EMACSLOADPATH) $(EMACS) --batch \
	    $(AM_ELCFLAGS) $(ELCFLAGS) \
	    $$am__subdir_includes -L $(builddir) -L $(srcdir) \
	    --eval "(defun byte-compile-dest-file (f) \"$@\")" \
	    --eval "(unless (byte-compile-file \"$<\") (kill-emacs 1))"; \
	else :; fi
