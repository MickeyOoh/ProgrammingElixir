defmodule Case do 
  def casecheck(data) do 
    case data do 
      val when val in [1, 3, 5, nil, false]
        -> "val #{to_string(val)}"
      _other
        -> "other #{to_string(data)}"
    end
  end
end

