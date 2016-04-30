@echo off
cls
if not exist op.* goto Compile
del op.*

:Compile
tasm %1 op
tlink op
echo --------------------------------------------------------------------------------
if %2.==. op
if %2.==d. td op
:Exit
echo .