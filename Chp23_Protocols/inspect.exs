@moduledoc """
  A protocol is a little like the behaviours we saw in the previous chapter
  in the previous chapter in that it defines the functions that must be provided
  to achieve something. But a behaviour is internal to a module -- the module
  implements the behaviour. Protocols are different--you can place a protocol's
  implementation completely outside the module.
  This means you can extend modules' functionality without having to add code
  them--in fact, you can extend the functionality even if you don't have the
modules' source code.  
"""
defimpl Inspect, for: PID do
  def inspect(pid, _opts) do 
    "#PID" <> IO.iodata_to_binary(:erlang.pid_to_list(pid))
  end
end
defimpl Inspect, for: Reference do 
  def inspect(ref, _opts) do 
    '#Ref' ++ rest = :erlang.ref_to_list(ref)
    "#Reference" <> IO.iodata_to_binary(rest)
  end
end

