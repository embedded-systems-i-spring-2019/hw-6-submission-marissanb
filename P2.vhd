----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2019 08:17:53 PM
-- Design Name: 
-- Module Name: P2 - FSM
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity P2 is
  Port ( 
        X1, X2: in std_logic;
        CLK: in std_logic;
        Z: out std_logic;
        Y: out std_logic_vector(1 downto 0)
  );
end P2;

architecture FSM of P2 is
type state is (ST0, ST1, ST2);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of state: type is "10 01 11";
signal PS,NS : state;

begin
    sync_process: process (CLK,NS)
    begin
    if (rising_edge(CLK)) then
        PS <= NS;
    end if;
    end process sync_process;
    
    comb_process: process(PS,X1,X2)
    begin
    -- preassign outputs
    Z <= '0';
    Y <= (others=>'0');
    case PS is
        when ST0 =>
            if X1 = '0' then
                Z <= '0';
                NS <= ST0;
            else
                Z <= '0';
                NS <= ST1;
            end if;
        when ST1 =>
            if X2 = '0' then
                Z <= '1';
                NS <= ST0;
            else
                Z<= '0';
                NS <= ST2;
            end if;
        when ST2 =>
            if X2 = '0' then
                Z <= '1';
                NS <= ST0;
            else
                Z <= '0';
                NS <= ST2;
            end if;
        when others=>
                Z <= '0';
                NS <= ST0;
        end case;
    end process comb_process;
 
 -- one hot encoding
 with PS select
    y <= "10" when ST0,
         "01" when ST1,
         "11" when ST2,
         "10" when others;
end FSM;
