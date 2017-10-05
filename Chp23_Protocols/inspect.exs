defimpl Inspect, for: PID do
  def inspect(pid, _opts) do 
    "#PID" <> iolist_to_binary(pid_to_list(pid))
  end
end
defimpl Inspect, for: Reference do 
  def inspect(ref, _opts) do 
    '#Ref' ++ rest = :erlang.ref_to_list(ref)
    "#Reference" <> iolist_to_binary(rest)
  end
end

