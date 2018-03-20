## Macros Are Hygienic
#   It is tempting to think of macors as some kind of textual substitution
#   a macro's body is expanded as text and then compiled at the point
#   of call. bu that's not the case. Consider this exanple:

defmodule Scope do
  defmacro update_local(val) do 
    local = "some value"
    result = quote do 
      local = unquote(val)
      IO.puts "End of macro body, local = #{local}"
    end
    IO.puts "In macro definition, local = #{local}"
    result
  end
end
defmodule Test do 
  require Scope

  local = 123
  Scope.update_local("cat")
  IO.puts "On return, local = #{local}"
end
# If the macro body was just substituted in at the point of call, both
# it and the mdoule Test would share the same scope, and the macro 
# would overwrite the variable local, so we'd see
#
# In macro defintion, local = some value
# End of macro body, local = cat
# On Return, local = cat
#
# But that isn't what happens. Instead the macro definition has both its own scope and a scope during execution of the quoted macro boyd.
# Both are distinct to the scope within the Test module. The upshot is
# that macros will not clobber each other's variables or the variable
# modules and functions that use them.

