module UnitfulDynamicQuantitiesExt

using Unitful
using DynamicQuantities
import UnitsBase: ustrip

ustrip(u::Unitful.Units, x::DynamicQuantities.Quantity) =
    DynamicQuantities.ustrip(x / convert(DynamicQuantities.Quantity, 1.0*u))
ustrip(u::Unitful.Units, x::DynamicQuantities.Quantity{<:Number, <:DynamicQuantities.AbstractSymbolicDimensions}) =
    ustrip(u, DynamicQuantities.uexpand(x))
ustrip(u::DynamicQuantities.Quantity, x::Unitful.Quantity) =
    DynamicQuantities.ustrip(convert(DynamicQuantities.Quantity, x) |> u)

Unitful.Quantity{T, D, U}(v::DynamicQuantities.Quantity) where {T,D,U} = convert(Unitful.Quantity{T, D, U}, v)

for f in (:+, :-, :*, :/)
    @eval Base.$f(x::DynamicQuantities.Quantity, y::Unitful.Quantity) = $f(x, convert(DynamicQuantities.Quantity, y))
    @eval Base.$f(x::Unitful.Quantity, y::DynamicQuantities.Quantity) = $f(convert(DynamicQuantities.Quantity, x), y)
end

end
