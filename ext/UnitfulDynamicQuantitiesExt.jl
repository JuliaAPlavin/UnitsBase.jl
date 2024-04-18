module UnitfulDynamicQuantitiesExt

using Unitful
using DynamicQuantities
import UnitsBase: ustrip

ustrip(u::Unitful.Units, x::DynamicQuantities.Quantity) = Unitful.ustrip(u, convert(Unitful.Quantity, DynamicQuantities.uexpand(x)))
ustrip(u::DynamicQuantities.Quantity, x::Unitful.Quantity) = DynamicQuantities.ustrip(convert(DynamicQuantities.Quantity, x) |> u)

Unitful.Quantity{T, D, U}(v::DynamicQuantities.Quantity) where {T,D,U} = convert(Unitful.Quantity{T, D, U}, v)

Base.:*(x::DynamicQuantities.Quantity, y::Unitful.Quantity) = convert(Unitful.Quantity, x) * y
Base.:*(x::Unitful.Quantity, y::DynamicQuantities.Quantity) = x * convert(Unitful.Quantity, y)
Base.:/(x::DynamicQuantities.Quantity, y::Unitful.Quantity) = convert(Unitful.Quantity, x) / y
Base.:/(x::Unitful.Quantity, y::DynamicQuantities.Quantity) = x / convert(Unitful.Quantity, y)

end
