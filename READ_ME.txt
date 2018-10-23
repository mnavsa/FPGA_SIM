FPGA_SIM by Mikhaeel Navsa

Instructions:
1. Make sure all VHDL files are in the same directory.
2. Use ModelSim to simulate the EDAC operation with a simulated RAM component.
3. Create a new project in ModelSim and add all the VHDL files.
4. Start simulation and simulate VHDL file FPGA_SIM.vhd.
5. Click on EDAC_SIM_1 and select "Add wave."
6. Set the device clock.
7. Only the CLK input requires setting.
8. Can be implemented on the Nexys 4 DDR FPGA. Set the clock input to a clock on the FPGA and 
   output to on-board LED.