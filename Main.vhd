----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 		Hamid Reza Tanhaei
-- 
-- Create Date:    2020 
-- Design Name: 	
-- Module Name:    Main - Behavioral 
-- Project Name: 	Alinx AX309 RTC UART Test
-- Target Devices: 	Xilinx FPGA SPARTAN6 XC6SLX9 (FTG256 package)
-- Tool versions: 
-- Description:A sample project for driving RTC (Real Time Clock) 
-- and UART for evaluation board Alinx-AX309 
-- Additional Comments: 
--	Xilinx ISE 14.7
----------------------------------------------------------------------------------
--------   Library and Packages   -----------
LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

--------   Interface or Entity   ------------
Entity Main is
  port (
		 Clock  : in std_logic;
		 to_LED : out unsigned(6 downto 0);
		 Selected_digit : out unsigned(5 downto 0)
	   );
End Main;

--------   Architecture or Body  ------------
Architecture Behavioral of Main is
	signal	clk_50M, clk_5M, clk_7M : std_logic;
	signal	bcd_p1, bcd_p2, bcd_p3, bcd_p4, bcd_p5, bcd_p6 : unsigned(3 downto 0) ;
	--signal	data_ila : std_logic_vector(7 downto 0) := (others => '0');
	--signal	trig_ila : std_logic :='0';
	--signal	control_icon : std_logic_vector(35 downto 0);
	----------------------
-----------------------------------------
Begin

	-----------------
	DCM_inst : entity  work.DCM_CLOCK
	  port map
	   (-- Clock in ports
		CLK_IN_50M => Clock, 	-- input clock from osillator
		-- Clock out ports
		--CLK_50M => CLK_50M,		-- output main clock
		--CLK_7M => CLK_7M,		-- clock 7.143MHz for UART timing
		CLK_5M => CLK_5M);		-- clock for RTC interfacing
	----------------------------
	   sevent_seg: entity work.Seven_segment
		port map
		(
			clock => clk_5M,
			to_LED => to_LED,
			Selected_digit => Selected_digit,
			bcd_s1=> bcd_p1,
			bcd_s2=> bcd_p2,
			bcd_s3=> bcd_p3,
			bcd_s4=> bcd_p4,
			bcd_s5=> bcd_p5,
			bcd_s6=> bcd_p6
		);
	----------------------------
		sayac_artis: entity work.Sayac_artis
		port map
		(
			clock => clk_5M,
			bcd_s1=> bcd_p1,
			bcd_s2=> bcd_p2,
			bcd_s3=> bcd_p3,
			bcd_s4=> bcd_p4,
			bcd_s5=> bcd_p5,
			bcd_s6=> bcd_p6
		);
	----------------------------
		
end Behavioral;
-------------------------------------------------------------------------
-------------------------------------------------------------------------
