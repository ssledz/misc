for s in `ls`; do echo "svn mkdir file:///home/ssledz/crypt/svn_repository/$s -m 'bzz'; svn mkdir file:///home/ssledz/crypt/svn_repository/$s/trunk -m 'bzz'; svn import $s file:///home/ssledz/crypt/svn_repository/$s/trunk -m 'bzz'"; done;
