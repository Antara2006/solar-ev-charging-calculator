
# Solar EV Charging Calculator
# Version 2: Interactive inputs and validation

# Read a positive number from the user
function get_positive_number(prompt)
    while true
        print(prompt)
        input = strip(readline())

        try
            value = parse(Float64, input)

            if isfinite(value) && value > 0
                return value
            else
                println("Please enter a number greater than zero.")
            end
        catch
            println("Invalid input. Please enter a numeric value.")
        end
    end
end

# Read a percentage between 0 and 100
function get_percentage(prompt)
    while true
        print(prompt)
        input = strip(readline())

        try
            value = parse(Float64, input)

            if isfinite(value) && 0 <= value <= 100
                return value
            else
                println("Please enter a percentage from 0 to 100.")
            end
        catch
            println("Invalid input. Please enter a numeric value.")
        end
    end
end

# Display the calculator title
println("\n===== Solar EV Charging Calculator =====\n")

# Step 1: Collect EV battery details
battery_capacity_kwh =
    get_positive_number("Battery capacity (kWh): ")

current_soc_percent =
    get_percentage("Current battery charge (%): ")

target_soc_percent =
    get_percentage("Target battery charge (%): ")

# Step 2: Validate the target charge
while target_soc_percent <= current_soc_percent
    println("Target charge must be greater than current charge.")
    target_soc_percent =
        get_percentage("Enter a higher target charge (%): ")
end

# Step 3: Collect solar system details
panel_power_kw =
    get_positive_number("Power of one solar panel (kW): ")

sunlight_hours_per_day =
    get_positive_number("Peak sunlight hours per day: ")

system_efficiency_percent =
    get_percentage("System efficiency (%): ")

# Step 4: Validate system efficiency
while system_efficiency_percent == 0
    println("System efficiency must be greater than 0%.")
    system_efficiency_percent =
        get_percentage("Enter system efficiency (%): ")
end

system_efficiency = system_efficiency_percent / 100

# Step 5: Calculate the required energy
energy_needed_kwh = battery_capacity_kwh *
    (target_soc_percent - current_soc_percent) / 100

# Step 6: Estimate energy generated per panel per day
energy_per_panel_kwh = panel_power_kw *
    sunlight_hours_per_day * system_efficiency

# Step 7: Estimate the required number of panels
panels_required = ceil(Int,
    energy_needed_kwh / energy_per_panel_kwh)

# Step 8: Calculate the solar array's rated and effective power
total_solar_power_kw = panels_required * panel_power_kw
effective_solar_power_kw = total_solar_power_kw *
    system_efficiency

# Step 9: Estimate charging time at effective power
charging_time_hours = energy_needed_kwh /
    effective_solar_power_kw

# Step 10: Display results
println("\n========== Results ==========")
println("Energy required: ",
    round(energy_needed_kwh, digits=2), " kWh")
println("Energy per panel per day: ",
    round(energy_per_panel_kwh, digits=2), " kWh")
println("Estimated panels required: ", panels_required)
println("Total solar array power: ",
    round(total_solar_power_kw, digits=2), " kW")
println("Effective solar power: ",
    round(effective_solar_power_kw, digits=2), " kW")
println("Estimated charging time at effective power: ",
    round(charging_time_hours, digits=2), " hours")
println("Estimated solar energy collection time: ",
    round(energy_needed_kwh /
        (panels_required * energy_per_panel_kwh) * sunlight_hours_per_day,
        digits=2), " peak-sun hours")
println("=============================")

