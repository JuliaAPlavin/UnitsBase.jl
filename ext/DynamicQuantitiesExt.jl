module DynamicQuantitiesExt

import UnitsBase: ustrip, unit
import DynamicQuantities

ustrip(x::DynamicQuantities.Quantity) = DynamicQuantities.ustrip(x)
ustrip(u::DynamicQuantities.Quantity, x::DynamicQuantities.Quantity) = DynamicQuantities.ustrip(x |> u)
unit(x::DynamicQuantities.Quantity) = DynamicQuantities.dimension(x)

end
