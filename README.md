# erlang_one

This is a cookbook which installs erlang from source, it runs only on Ubuntu.  It is meant to
show how to modify a 'computed attribute' recipe to move the computation into recipe code and
to replace the node objects with simple ruby variables.

There are three test cookbooks.  One which is the default which installs 'R15B01' from erlang.org
using the computed URL from the default version string.  The second installs a wrapper cookbook
which modifies the version to "R16B03" in a default attribute override and installs it from a
computed uri from erlang.org.   The third overrides the url and the version and pulls down erlang
"17.3" from erlang-solutions.com and discards the computed attributes.

This works correctly, with wrapper cookbooks, with the _behavior_ desired by computed attributes
and without lazy evaluation or with setting any attribute code.  The magic comes via using a
simple ruby variable in recipe code (ruby variables are unencumbered by attribute precedence
level issues because they're simply variables, so the code always wins):

https://github.com/lamont-granquist/erlang_one/blob/bcfc35300fc6fa19ef55a068dd29e0e96cd74fef/recipes/default.rb#L17-L18

In fact I convert all of my node attributes into ruby variables in block of code and do not feed
any node attributes directly into resources.  Once chef node attributes become difficult to
work with this pattern of taking node attributes and turning them into normal ruby variables
as early as possible in your recipe code and discarding the use of attributes will significantly
reduce attribute pain.

If you want to search on the computed value, that can be set in its own _output_ node attribute
in order to search on later.

For many distributed consumers of the computed information this computation should be moved into
a library and ideally memoized.

