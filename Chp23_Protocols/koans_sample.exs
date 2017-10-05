defmodule Protocols do 

  defprotocol School, do: def enroll(person)

  defimpl School, for: Any do 
    def enroll(_) do
      "Pupil enrolled at school"
    end
  end

  defmodule Student do 
    @derive School
    defstruct name: ""
  end

  defmodule Baker, do: defstruct name: ""

  def run do 
    School.enroll(%Baker{name: "Delia"} )
  end
end

Protocols.run()

