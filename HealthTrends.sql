WITH MachinePhysics AS (
    SELECT 
        UDI,
        Product_ID,
        Type,
        Air_temperature_K,
        Process_temperature_K,
        Rotational_speed_rpm,
        Torque_Nm,
        Tool_wear_min,
        Machine_failure,
        -- 1. THERMAL STRESS: The difference between process and air temp.
        (Process_temperature_K - Air_temperature_K) AS Temp_Delta,

        -- 2. MECHANICAL POWER (kW): Power = (Torque * Speed) / Constant.
        (Torque_Nm * Rotational_speed_rpm) / 9.5488 AS Power_Output_Watts,

        -- 3. TOOL STRAIN: A combined metric of torque and cumulative wear.
        (Torque_Nm * Tool_wear_min) AS Cumulative_Strain
    FROM Maintenance_Strategy
),
HealthTrends AS (
    SELECT *,
        -- 4. THERMAL TREND: Is the machine getting hotter relative to its recent past?
        AVG([Process_temperature_K]) OVER(PARTITION BY [Type] ORDER BY [UDI] ROWS BETWEEN 10 PRECEDING AND CURRENT ROW) as Rolling_Temp_Avg,
        
        -- 5. SUDDEN TORQUE SPIKE: Difference from the previous reading.
        Torque_Nm - LAG(Torque_Nm, 1) OVER(ORDER BY UDI) as Torque_Instant_Change
    FROM MachinePhysics
)
SELECT * FROM HealthTrends;