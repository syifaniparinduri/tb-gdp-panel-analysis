# tb-gdp-panel-analysis
Panel regression analysis of tuberculosis prevalence, GDP growth, and labor productivity using Stata and World Bank / Penn World Table data
# Tuberculosis, Labor Productivity, and Economic Growth: A Cross-Country Panel Analysis

> 🚧 **Status: Work in Progress** — analysis ongoing as part of undergraduate coursework at UBC

## About
This project applies the Solow growth model framework to estimate the relationship 
between tuberculosis (TB) prevalence, labor productivity, and GDP growth across countries. 
Using cross-country panel data, our results confirm the core predictions of the Solow model, 
and extend it by incorporating TB incidence as an additional variable — finding that higher 
TB prevalence is associated with positive effects on measured economic growth, likely 
reflecting the compounding burden on labor quality and human capital accumulation.

## Data Sources
- Penn World Table (PWT) — GDP, capital stock, human capital
- World Bank Open Data — TB incidence rate (per 100,000 people)
  https://data.worldbank.org/indicator/SH.TBS.INCD

## Tools
- Stata (panel regression, fixed effects estimation)

## Key Finding
TB incidence shows a statistically significant positive relationship with GDP growth, 
consistent with the Solow model's predictions on how human capital degradation 
propagates through labor productivity into long-run output.

## Status
This analysis is currently in progress. Final regression outputs, robustness checks, 
and policy implications will be updated upon completion.
