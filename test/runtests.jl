using TestItems
using TestItemRunner
@run_package_tests


@testitem "basic" begin
    import Unitful
    import DynamicQuantities

    ux = 10.0*Unitful.u"mm/s"
    dqx = 10.0*DynamicQuantities.u"mm/s"
    dqsx = 10.0*DynamicQuantities.us"mm/s"

    @test (@inferred ustrip(Unitful.u"km/hr", ux)) === 0.036
    @test (@inferred ustrip(Unitful.u"km/hr", dqsx)) === 0.036
    @test (@inferred ustrip(Unitful.u"km/hr", dqx)) === 0.036

    @test (@inferred ustrip(DynamicQuantities.us"km/hr", ux)) === 0.036
    @test (@inferred ustrip(DynamicQuantities.us"km/hr", dqsx)) === 0.036
    @test (@inferred ustrip(DynamicQuantities.us"km/hr", dqx)) === 0.036
    @test_throws r"You can .*convert.*SymbolicDimensions" ustrip(DynamicQuantities.u"km/hr", dqsx) === 0.036

    @test ustrip(ux) === ustrip(dqsx) === 10.
    @test string(unit(ux)) == "mm s⁻¹"
    @test string(unit(dqsx)) == "s⁻¹ mm"
    @test ustrip(dqx) == 0.01
    @test string(unit(dqx)) == "m s⁻¹"

    
    fu(x) = ustrip(Unitful.u"g/mm", x / 1Unitful.u"km")
    fdq(x) = ustrip(DynamicQuantities.us"g/mm", x / 1DynamicQuantities.u"km")
    
    @test (@inferred fu(1.0*Unitful.u"g")) == 1e-6
    @test (@inferred fdq(1.0*DynamicQuantities.u"g")) == 1e-6

    @test (@inferred fdq(1.0*Unitful.u"g")) == 1e-6
    @test (@inferred fu(1*DynamicQuantities.u"g")) == 1e-6
    @test (@inferred fu(1*DynamicQuantities.us"g")) == 1e-6
end


@testitem "_" begin
    import Aqua
    Aqua.test_all(UnitsBase; ambiguities=false)
    Aqua.test_ambiguities(UnitsBase)

    import CompatHelperLocal as CHL
    CHL.@check()
end
