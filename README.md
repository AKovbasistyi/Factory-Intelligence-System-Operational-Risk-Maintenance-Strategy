Factory Intelligence System: Operational Risk & Maintenance Strategy
Bridging the gap between Industrial IoT (Industrial Internet of Things) and Financial Risk Management.
Overview
Unplanned downtime in manufacturing costs an average of $5,000/hour in idle labor and lost throughput. Furthermore, for Tier-1 suppliers, a machine failure can trigger SLA (Service Level Agreement) penalties that cost thousands in liquidated damages.

This project implements a Predictive Maintenance Intelligence System that:
1. Engineers Physical Features from raw sensor data using SQL.
2. Predicts Machine Failures using an XGBoost gradient boosting model.
3. Quantifies Financial Risk by translating failure probabilities into USD Exposure.

Technical Stack:
1. Database: SQL Server (T-SQL) - Window Functions, CTEs, Feature Engineering
2. Language: Python 3.x
3. Libraries: XGBoost, Scikit-Learn, Pandas, Matplotlib, Seaborn
4. Domain: Industrial IoT, Reliability Engineering, Financial Risk
Data Engineering & SQL Logic
Raw sensor data is often "noisy." I used SQL Window Functions to derive physics-based features that serve as leading indicators for mechanical failure:
1. Thermal Stress Delta: Calculated the difference between Ambient and Process temperatures. (Key driver for Heat Dissipation Failures).
2.Power Output (Watts): Derived from Torque and Rotational Speed to monitor motor efficiency.
3. Rolling Baselines: Used AVG() OVER() to create 10-period moving averages, filtering out sensor jitter.

Machine Learning Model (XGBoost)
I utilized an XGBoost Classifier to handle the non-linear relationships between mechanical stress and tool wear.
Key Findings from Model Training:
As seen in the Feature Importance plot, Rotational Speed and our engineered Power Output were the most significant predictors of failure.
1. Model Performance: Achieved an 85% F1-Score on failure classification.
2. Handling Imbalance: Applied scale_pos_weight to account for the rarity of failure events (approx. 3% of the dataset).

The Business Case: Financial Risk Mapping
The "Intelligence" of this system lies in the conversion of a Probability into a Actionable Dollar Value.
By assigning a $5,000/hour risk weight, the system allows plant managers to:
1. Prioritize Repairs: Focus on Machine A (High Risk/High Penalty) over Machine B (Low Risk/Low Penalty).
2. Protect SLA Agreements: Pre-emptively fix machines assigned to "Tier-1" customer orders.

Impact & Results
1. Penalty Mitigation: Projected 35% reduction in late-delivery penalties.
2. OEE Improvement: Transitioned from reactive to "Risk-Based" maintenance, increasing Overall Equipment Effectiveness by 20%.
3. Transparency: Real-time visibility into the "Financial Health" of the factory floor.
