
using Test

include("../src/SolarEVCharging.jl")
using .SolarEVCharging

@testset "Solar EV Charging Calculator" begin

    @testset "Energy required" begin
        @test calculate_energy_needed(60.0, 30.0, 80.0) ≈ 30.0
        @test calculate_energy_needed(50.0, 20.0, 100.0) ≈ 40.0

        @test_throws ArgumentError calculate_energy_needed(0.0, 30.0, 80.0)
        @test_throws ArgumentError calculate_energy_needed(60.0, -5.0, 80.0)
        @test_throws ArgumentError calculate_energy_needed(60.0, 30.0, 30.0)
    end

    @testset "Daily panel energy" begin
        @test calculate_panel_energy(0.4, 5.0, 0.8) ≈ 1.6
        @test_throws ArgumentError calculate_panel_energy(0.0, 5.0, 0.8)
        @test_throws ArgumentError calculate_panel_energy(0.4, 5.0, 1.2)
    end

    @testset "Panel count" begin
        @test calculate_panels_required(30.0, 1.6) == 19
        @test calculate_panels_required(32.0, 1.6) == 20
        @test_throws ArgumentError calculate_panels_required(30.0, 0.0)
    end

    @testset "Array power" begin
        power = calculate_array_power(19, 0.4, 0.8)

        @test power.rated ≈ 7.6
        @test power.effective ≈ 6.08
        @test_throws ArgumentError calculate_array_power(0, 0.4, 0.8)
    end

    @testset "Charging time" begin
        @test calculate_charging_time(30.0, 6.08) ≈ 30.0 / 6.08
        @test_throws ArgumentError calculate_charging_time(30.0, 0.0)
    end

end
