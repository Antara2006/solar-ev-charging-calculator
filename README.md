
# Solar EV Charging Calculator

A beginner-friendly calculator built with Julia to estimate solar energy requirements for charging an electric vehicle.

## Features

- Calculates the energy required to charge an EV battery
- Estimates daily energy generation per solar panel
- Calculates the number of solar panels required
- Estimates solar array power and charging time
- Validates user input
- Includes automated tests

## Mathematical Model

Energy required:

Energy (kWh) = Battery Capacity (kWh) × (Target SOC − Current SOC) / 100

Daily energy per panel:

Energy (kWh/day) = Panel Power (kW) × Peak Sunlight Hours × System Efficiency

Number of panels:

Panels = Ceiling(Energy Required / Daily Energy per Panel)

Estimated charging time:

Time (hours) = Energy Required (kWh) / Effective Solar Power (kW)

## Requirements

- Julia 1.13 or compatible version

## Run the Calculator

```powershell
julia main.jl
```

## Run Tests

```powershell
julia test/runtests.jl
```

## Limitations

This project uses simplified calculations. Actual solar output and EV charging time depend on weather, shading, inverter performance, battery charging losses, and vehicle charging limits.

## Future Improvements

- Add a graphical dashboard
- Compare different solar panel configurations
- Visualize energy generation and charging estimates
- Include estimated installation costs

## License

MIT License
