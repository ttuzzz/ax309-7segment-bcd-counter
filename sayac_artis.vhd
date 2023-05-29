----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:14:19 05/13/2023 
-- Design Name: 
-- Module Name:    Sayac_artis - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sayac_artis is
	port(
			clock			: in std_logic;
			bcd_s1 : out unsigned(3 downto 0);
		   bcd_s2 : out unsigned(3 downto 0);
		   bcd_s3 : out unsigned(3 downto 0);
		   bcd_s4 : out unsigned(3 downto 0);
		   bcd_s5 : out unsigned(3 downto 0);
		   bcd_s6 : out unsigned(3 downto 0));
end Sayac_artis;

architecture Behavioral of Sayac_artis is
  signal counter : unsigned(22 downto 0) := (others => '0');
  signal digit1,digit2,digit3,digit4,digit5,digit6:integer := 0;
  constant CLK_FREQUENCY : integer := 5000000; -- 5 MHz
	-- BCD değerlerini tutan dizi
	type BCD_Array is array (integer range 0 to 9) of unsigned(3 downto 0);
	constant BCDs : BCD_Array := (
		0 => "0000",
		1 => "0001",
		2 => "0010",
		3 => "0011",
		4 => "0100",
		5 => "0101",
		6 => "0110",
		7 => "0111",
		8 => "1000",
		9 => "1001"
	);
begin  
  process(clock)
  begin
    if rising_edge(clock) then
      if counter = CLK_FREQUENCY then
        counter <= (others => '0');
		  
		if digit1 = 9 then
		  digit1 <= 0;
		  if digit2 = 9 then
			 digit2 <= 0;
			 if digit3 = 9 then
				digit3 <= 0;
				if digit4 = 9 then
				  digit4 <= 0;
				  if digit5 = 9 then
					 digit5 <= 0;
					 if digit6 = 9 then
						digit6 <= 0;
					 else
						digit6 <= digit6 + 1;
					 end if;
				  else
					 digit5 <= digit5 + 1;
				  end if;
				else
				  digit4 <= digit4 + 1;
				end if;
			 else
				digit3 <= digit3 + 1;
			 end if;
		  else
			 digit2 <= digit2 + 1;
		  end if;
		else
		  digit1 <= digit1 + 1;
		end if;
		
		  bcd_s1 <=BCDs(digit1);
		  bcd_s2 <=BCDs(digit2);
		  bcd_s3 <=BCDs(digit3);
		  bcd_s4 <=BCDs(digit4);
		  bcd_s5 <=BCDs(digit5);
		  bcd_s6 <=BCDs(digit6);

		else
        counter <= counter + 1;
      end if;
    end if;
  end process;

end Behavioral;