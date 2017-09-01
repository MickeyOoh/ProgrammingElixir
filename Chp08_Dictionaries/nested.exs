defmodule Nested do
  defmodule Customer do 
    defstruct name: "", company: ""
  end

  defmodule BugReport do 
    defstruct owner: %{}, details: "", severity: 1
  end
  
  def run do 
    report = %BugReport{owner: %Customer{name: "Dave", company: "Pragmatic"}, details: "broken"}
    IO.puts inspect(report)
    IO.puts "report.owner.company =>#{report.owner.company}"
    report = %BugReport{ report | owner: %Customer{ report.owner | company: "PragProg" }}
    IO.puts inspect(report)
    report = put_in(report.owner.company, "PragProg_new")
    IO.puts inspect(report)
    report = update_in(report.owner.name, &("Mr. " <> &1))
    IO.puts inspect(report)

    report = %BugReport{owner: %Customer{name: "Dave", company: "Pragmatic"}, details: "broken"}
    put_in(report[:owner][:company], "PragProg")
    update_in(report[:owner][:name], &("Mr. " <> &1))
    IO.puts inspect(report)

  end

end
#report = %BugReport{owner: %Customer{name: "Dave", company: "Pragmatic"}, severity: 1}

#report.owner.company
Nested.run
