@echo off
echo ===OSIC-TOOLS-PROBE===
for %%T in (xschem magic netgen ngspice klayout) do (
  where %%T >nul 2>nul && echo %%T OK || echo %%T MISSING
)
echo ===VERSIONS===
call xschem --version 2>&1 | more +0
