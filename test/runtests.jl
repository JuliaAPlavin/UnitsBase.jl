using TestItems
using TestItemRunner
@run_package_tests


@testitem "basic" begin
    import Unitful
    import DynamicQuantities

    ux = 10.0*Unitful.u"mm/s"
    dqx = 10.0*DynamicQuantities.us"mm/s"

    @test ustrip(Unitful.u"km/hr", ux) === 0.036
    @test_broken ustrip(Unitful.u"km/hr", dqx) === 0.036
    @test ustrip(Unitful.u"km/hr", dqx) ≈ 0.036
    @test ustrip(DynamicQuantities.us"km/hr", ux) === 0.036
    @test ustrip(DynamicQuantities.us"km/hr", dqx) === 0.036
    @test_throws r"You can .*convert.*SymbolicDimensions" ustrip(DynamicQuantities.u"km/hr", dqx) === 0.036
    @test ustrip(ux) === ustrip(dqx) === 10.
    @test string(unit(ux)) == "mm s⁻¹"
    @test string(unit(dqx)) == "s⁻¹ mm"

    fu(x) = ustrip(Unitful.u"g/mm", x / 1Unitful.u"km")
    fdq(x) = ustrip(DynamicQuantities.us"g/mm", x / 1DynamicQuantities.u"km")
    @test fu(1.0*Unitful.u"g") == 1e-6
    @test fdq(1*Unitful.u"g") == 1e-6
    @test fu(1*DynamicQuantities.u"g") == 1e-6
    @test fdq(1.0*DynamicQuantities.u"g") == 1e-6
end


@testitem "_" begin
    import Aqua
    Aqua.test_all(UnitsBase; ambiguities=false)
    Aqua.test_ambiguities(UnitsBase)

    import CompatHelperLocal as CHL
    CHL.@check()
end
