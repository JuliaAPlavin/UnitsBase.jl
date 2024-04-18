module UnitfulExt

import UnitsBase: ustrip, unit
import Unitful

ustrip(x::Unitful.Quantity) = Unitful.ustrip(x)
ustrip(u::Unitful.Units, x::Unitful.Quantity) = Unitful.ustrip(u, x)
unit(x::Unitful.Quantity) = Unitful.unit(x)

end
